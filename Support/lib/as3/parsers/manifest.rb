#!/usr/bin/env ruby
# encoding: utf-8

################################################################################
#
#   Copyright 2009 Simon Gregory
#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
################################################################################

# Utility class for working with ActionScript manifest files.
#
class Manifest

  def initialize(doc)
    @doc = strip_comments(doc)
  end
  
  def find_class(id)
    
    rgx = /<component\s+id=["'](#{id})["']\s+class=["']([\w.]+)["']/
    res = []
    res = @doc.scan(rgx)

    return nil if res.empty?
    
    res[0][1]
    
  end
    
  def classes

    rgx = /<component\s+id=["'](\w+)["']\s+class=["']([\w.]+)["']/
    cls = []
    @doc.each { |line|  cls << $1 if line =~ rgx }
    cls
    
  end
  
  protected
  
  # Strips comments from the document.
	#
	def strip_comments(doc)

		multiline_comments = /<!--(?:.|([\r\n]))*?-->/
		doc.gsub!(multiline_comments,'')
		
		single_line_comments = /<!--.*-->/
		return doc.gsub(single_line_comments,'')

	end
  
end

# if __FILE__ == $0
# 
# end
