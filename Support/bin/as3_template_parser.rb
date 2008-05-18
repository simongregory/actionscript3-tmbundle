#!/usr/bin/env ruby -wKU

doc_gen = (ENV['TM_ASDOC_GENERATION'] != nil)
ban_gen = (ENV['TM_AS3_BANNER_GENERATION'] != nil)

ENV['TM_YEAR'] = `date "+%Y"`.chop
ENV['TM_DATE'] = `date +%d.%m.%Y`.chop

new_file = ENV['TM_NEW_FILE']
new_file_path = new_file.sub(/.*\/(src|source|test)\//,"")
new_file_name = File.basename(new_file)

ENV['TM_CLASS_PATH'] = new_file_path.sub(new_file_name,"").chop.gsub("/",".")
ENV['TM_NEW_FILE_BASENAME'] = new_file_name.sub('.as','')

in_plate = STDIN.read.split("\n")
out_plate = ""

doc_regexp = /(^\s*\/\*)|(^\s*\*).*$/
ban_regexp = /^\s*\/\//

removed = false

in_plate.each do |line|
	
	if line =~ doc_regexp

		if doc_gen
			out_plate += line + "\n"
		else
			removed = true
		end
		
	elsif line =~ ban_regexp

		if ban_gen
			out_plate += line + "\n"
		else
			removed = true
		end
		
	else
		
		if removed == true
			next if (line =~ /^\s*$/ )
		end
		out_plate += line + "\n"
		removed = false
		
	end

end

%x{cat > #{ENV['TM_NEW_FILE']} <<ENDOFTEXT
#{out_plate}
ENDOFTEXT}

# Backup/Reference script previously used for the as3 templates.
# if test \! -e "$TM_NEW_FILE"; then
# 	TM_YEAR=`date +%Y` \
# 	TM_DATE=`date +%d.%m.%Y` \
# 	a=`echo ${TM_NEW_FILE#$TM_PROJECT_DIRECTORY/src/}` \
# 	b=`echo ${a%/$TM_NEW_FILE_BASENAME.as}` \
# 	c=`echo ${b#/}` \
# 	TM_CLASS_PATH=`echo $c | tr '/' '.'` \
# 	perl -pe 's/\$\{([^}]*)\}/$ENV{$1}/g' \
#       < class.as > "$TM_NEW_FILE";
# fi