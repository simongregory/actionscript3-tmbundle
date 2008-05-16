#!/usr/bin/env ruby -wKU

#Conversion of the flex_utils.sh file to ruby. Currently not used by any commands...

require "#{ENV['TM_SUPPORT_PATH']}/lib/web_preview"
require "#{ENV['TM_SUPPORT_PATH']}/lib/exit_codes"

#Search locations for the flex sdk
FLEX_DIRS = [ "/Applications/flex_sdk_2",
             "/Applications/FlexSDK2",
             "/Applications/Flex",
             "/Applications/FlexSDK2.0.1",
             "/Applications/Adobe Flex Builder 2/Flex SDK 2",
             "~/Flex",
             "~/flex_sdk_2",
             "/Developer/SDKs/flex_sdk_2",
             "/Developer/SDKs/Flex",
             "/Developer/SDKs/FlexSDK2",
             "/Developer/Applications/Flex",
             "/Developer/Applications/flex_sdk_2",
             "/Developer/Applications/FlexSDK2",
             "/Developer/Applications/Adobe Flex Builder 2/Flex SDK 2" ]

FLEX_COMMANDS = [ "mxmlc" "compc" "asdoc" "fdb" "fcsh" "acompc" "adl" "adt" ]

#Return the first Flex SDK directory found in the list.
def dir_check    
    return FLEX_DIRS.find { |dir| File.directory? dir }
end

#Print the directories searched when trying to find the users Flex SDK.
def show_search_list
    FLEX_DIRS.each { |dir| puts dir }
end

#Search FLEX_DIRS list for the Flex SDK, if it exists then set it to the the TM_FLEX_PATH variable.
#returns 0 for success, 1 for failure.
def set_TM_FLEX_PATH
  
  if !ENV['TM_FLEX_PATH']
      #tm_flex_path = dir_check
      #puts tm_flex_path;
      ENV['TM_FLEX_PATH'] = dir_check
  end
  
  if !ENV['TM_FLEX_PATH']
      return 1; #Fail
  else
      return 0; #Succeed
  end
end

# Attempts to find the Flex SDK directory and set it to $TM_FLEX_PATH.
# If it fails then a html help window is shown to the user, or if -t is supplied then a tooltip.
def set_flex_path ( exit_with_tooltip )

  if set_TM_FLEX_PATH == 1

      if exit_with_tooltip == "-t"
          print "Please define the environment variable TM_FLEX_PATH and point it to your Flex SDK directory."
          TexMate.exit_show_tool_tip;
      end

      puts html_head(:window_title => "Help files 404", :page_title => "Help files 404", :sub_title => "")
      #importCSS "$TM_BUNDLE_SUPPORT/css/help.css";

      print <<-HTMOUT
              <h2>Help not found</h2>
              <p>Please define the environment variable <code>TM_FLEX_PATH</code> and point it to your Flex SDK directory.<br>
              Installation and configuration help can be found <a href="$TM_BUNDLE_SUPPORT/html/help.html#installation">here.</a></p>
      HTMOUT

      TextMate.exit_show_html
  else
      `export TM_FLEX_PATH="$TM_FLEX_PATH";`
  end
end

# Searches flex install directory list and adds the first found_dir/bin to the PATH.
# This should mean that mxmlc, fcsh etc are invokeable.
def try_to_add_flex_bin_to_PATH

    if !ENV['TM_FLEX_PATH']
          ENV['TM_FLEX_PATH'] = dir_check
    end

    if !ENV['TM_FLEX_PATH']
        #Fail
        return 1;
    else
        #Succeed
        `PATH="$PATH:$TM_FLEX_PATH/bin"`
        return 0;
    end

end

#Checks to see if the command is available or not and the result is printed to screen.
#def cmd_check ( cmd )
#  if `! type -p "#{cmd}" >/dev/null;`
#      puts cmd + " not available"
#      return 1;
#  else
#      puts cmd + " ok"
#      return 2;
#  end
#end
 
#Many of the commands only work from a project scope.
#This checks for the existence of a project, then sets $TM_PROJECT_DIR to work from.
def cd_to_tmproj_root()
  
  if !ENV['TM_PROJECT_FILEPATH']
      TextMate.exit_show_tool_tip "This Command should only be run from within a saved TextMate Project."
  end
  
  ENV['TM_PROJECT_DIR'] = File.dirname( ENV['TM_PROJECT_FILEPATH'] )
  
  #TODO: IS THIS EQUIVALENT POSSIBLE/USEFUL...
  `cd #{ENV['TM_PROJECT_DIR']}`
  
end

#Make sure an environment variable is set.
def require_var (evar)
  if !ENV[evar]
      
      puts html_head(:window_title => "Missing Environment Variable", :page_title => "Missing Environment Variable", :sub_title => "")
      #importCSS "$TM_BUNDLE_SUPPORT/css/help.css";

      puts <<-HTMOUT
              <h2>Environement var missing</h2>
              <p>Please define the environment variable <code>#{evar}</code>.
              <br>
              <br>
              Configuration help can be found <a href="tm-file://$TM_BUNDLE_SUPPORT/html/help.html#conf">here.</a></p>
      HTMOUT

      TextMate.exit_show_html
      
  end
end

#Make sure a file exists at the defined location.
def require_file ( file )

  if !File.exist?(file)

      puts html_head(:window_title => "File not found", :page_title => "File not found", :sub_title => "")
      #importCSS "$TM_BUNDLE_SUPPORT/css/help.css";

      print <<-HTMOUT
              <h2>#{file} 404</h2>
              <p>The environment variable <code>#{file}</code> does not resolve to an actual file.
              <br>
              <br>
              Configuration help can be found <a href="tm-file://#{ENV['TM_BUNDLE_SUPPORT']}/html/help.html#conf">here.</a></p>
      HTMOUT

      TextMate.exit_show_html
      
  end
end
