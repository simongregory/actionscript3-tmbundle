#!/usr/bin/env ruby
# encoding: utf-8

################################################################################
#
#		Copyright 2009 Simon Gregory
#		
#		This program is free software: you can redistribute it and/or modify
#		it under the terms of the GNU General Public License as published by
#		the Free Software Foundation, either version 3 of the License, or
#		(at your option) any later version.
#		
#		This program is distributed in the hope that it will be useful,
#		but WITHOUT ANY WARRANTY; without even the implied warranty of
#		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#		GNU General Public License for more details.
#		
#		You should have received a copy of the GNU General Public License
#		along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
################################################################################

# STUB

# A Utilty class to convert a mxml document into
# list of it's constituent methods, properties, etc.
#
class MxmlParser
  def initialize(args)
    
  end
  
  
end

# A object representing the information on class members found within a
# mxml document. 
#
class MxmlDoc
  attr_accessor :super_class
  attr_accessor :properties
  attr_accessor :methods
  attr_accessor :accessors

  def initialize(args)
    
  end

end

# Class member token.
#
class MemberToken
  attr_accessor :name
  attr_accessor :type
  attr_accessor :signature
end

if __FILE__ == $0
  puts "TODO"
end