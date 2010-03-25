#!/usr/bin/env ruby -wKU
# encoding: utf-8

################################################################################
#
#   Copyright 2009-2010 Simon Gregory
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

# Designed to scan from the caret location within the current document and
# output a string that can be used by the class parser to load and store the
# properteries, methods etc of the resulting class reference.
#
module PropertyInspector

  # Finds and returns a 'Property Chain' ie foo.bar.baz based on the
  # current line.
  #
  # Where it finds an object that has been type cast it's
  # class is inserted into the chain not it's property name. So
  # foo.( bar as Sprite ).baz becomes foo.Sprite.baz
  #
  def self.property_chain

    li = ENV['TM_LINE_INDEX']
    ln = ENV['TM_CURRENT_LINE']
    la = ln.split("")
    i = li.to_i-1

    # When we are on a completly blank line return "this"
    if ln =~ /^\s*$/
      return "this"
    end

    # Stop looking when we hit these chars.
    stop_match = /[\[\s=;,:"']/

    # Casting using the as operator.
    as_regexp = /\bas\b\s+(\w+)/

    # Holds the cars found
    found = []
    bracket_contents = []

    # int to track the level of nesting.
    nests = 0;

    while i >= 0

      current_letter = la[i]

      # Make sure we stop if we hit a closing nest char.
      break if current_letter == "("

      if current_letter =~ /\)/

        while i >= 0

          current_letter = la[i]
          i -= 1

          if current_letter =~ /\)/
            nests += 1
          elsif current_letter =~ /\(/
            nests -= 1
          end

          if nests == 0

            if bracket_contents.reverse.to_s =~ as_regexp
              found << $1
            end
            bracket_contents = []
            break

          end

          bracket_contents << current_letter

        end
      end

      break if current_letter =~ stop_match
      next if current_letter =~ /[()]/
      found << current_letter
      i -= 1

    end

    found.reverse!

    # Search for casting.
    if found.empty?
      if bracket_contents.reverse.to_s =~ as_regexp
        return $1
      end
    end

    return nil if found.empty?

    chain = found.to_s
    chain.chop! if chain =~ /\.$/

    return nil if chain == ""

    return chain

  end

  # Tests to see if the caret is currently at a class reference or a
  # property instance name.
  #
  # NOTE: Relies entirely on the convention that classes start with an
  # uppercase character.
  #
  def self.is_static

    li = ENV['TM_LINE_INDEX']
    ln = ENV['TM_CURRENT_LINE']
    la = ln.split("")
    i = li.to_i-1

    last_c = ""

    while i >= 0

      c = la[i]

      unless c =~ /[\w.]/
        if last_c =~ /[A-Z]/
          before = la[0..i].join()
          return false if before =~ /new\s+$/
          return true
        end
        return false
      end

      last_c = c
      i -= 1

    end
    return false
  end

  # Return a boolean depending on whether the caret is just after a '.'
  #
  def self.at_dot
    li = ENV['TM_LINE_INDEX']
    ln = ENV['TM_CURRENT_LINE']
    la = ln.split("")
    i = li.to_i-1
    return true if la[i] == "."
    return false
  end

  # Should autocompletion insert a dot before the completed statement.
  # Deprecated, in favour of scope in the language file.
  #
  def self.insert_dot
    li = ENV['TM_LINE_INDEX']
    ln = ENV['TM_CURRENT_LINE']
    la = ln.split("")
    i = li.to_i-1
    return false if la.length <= i
    return false if la[i] =~ /(\.|\s)/
    return true
  end

  # Single access point to collect all information about the current scope.
  #
  def self.capture

    state = {
      :ref => self.property_chain,
      :is_static => self.is_static,
      :insert_dot => self.insert_dot,
      :filter => nil
    }

    return state if state[:ref] == nil

    chain = state[:ref].split(".")

    # Do we need to filter output?
    unless ENV['TM_SCOPE'] =~ /following\.dot/

      if chain.size > 1
        state[:filter] = chain.pop()
        state[:ref] = chain.join(".")
        if state[:ref] == ''
          state[:ref] = "this"
        end
      elsif chain.size == 1 and chain[0] != "this" and state[:is_static] != true
        state[:ref] = "this"
        state[:filter] = chain[0]
      end
    end

    state

  end

end
