#!/usr/bin/env ruby -wKU
# encoding: utf-8

# Base class for Template Parsing.
#
# Take a template document which contains both 'Comment Banners', and 'Doc Blocks',
# and depending settings either keep or reject them. This will need to be
# extended for a specific language. As I'm working with ActionScript
# there's a good chance this will work with any ECMAScript derived language.
#
# Additionally searches for and replaces variable placeholders. For example
# ${TM_DATE} is replaced with the current date.
#
class TemplateMachine

  attr_accessor :docs, :bans, :snippetize

  def initialize

    #booleans indicating if doc blocks and comment banners are kept.
    @docs = false
    @bans = false

    # Regular expressions to use when filtering
    @doc_regexp = /(^\s*\/\*)|(^\s*\*).*$/
    @ban_regexp = /^\s*\/\//

    #should output be snippetized
    @snippetize = false

  end

  # ==============
  # = Properties =
  # ==============

  # Year string formatted eg '2000'.
  #
  def year
    ENV['TM_YEAR'] || `date "+%Y"`.chop
  end

  # Date string formatted eg '20.01.2000'.
  #
  def date
    `date +%d.%m.%Y`.chop
  end

  # Users full name as string, or 'Unkown'.
  #
  def full_name
    ENV['TM_FULLNAME'] || "Unknown"
  end

  # Copyright holder using, in order of precedence TM_ORGANIZATION_NAME,
  # TM_FULLNAME or 'Unknown'.
  #
  def copyright_holder
    ENV['TM_ORGANIZATION_NAME'] || ENV['TM_FULLNAME'] || "Unknown"
  end

  # =========================
  # = Parsing / Substituion =
  # =========================

  # Parse the input.
  #
  def process(input)
    out = substitue(input,generate_sub_list)
  end

  protected

  # Run placeholder substitutions.
  #
  def substitue(input,list)
    list.each { |item|
      sub = item[:snip].nil? ? item[:sub] : "${#{item[:snip]}:#{item[:sub]}}"
      input.gsub!(item[:var], sub )
    }
    input
  end

  # Generates a list of substitution items to use when processing documents.
  #
  def substitution_list
    list = []
    list << substitution('${TM_DATE}',date)
    list << substitution('${TM_YEAR}', year )
    list << substitution('${TM_ORGANIZATION_NAME:-$TM_FULLNAME}', copyright_holder)
    list << substitution('${TM_FULLNAME}',full_name)
    list
  end

  # Creates a substiution object.
  #
  # var is the string to substitute.
  # sub is the value to insert.
  # snip should be an optional snippet placeholder number.
  #
  def substitution(var,sub,snip=nil)
    s = snippetize ? snip : nil
    { :var => var, :sub => sub, :snip => s }
  end

end

# TemplateMachine subclass to specifically handle ActionScript 3 documents.
#
class ActionScript3TemplateMachine < TemplateMachine

  def initialize
    super

    @docs = (ENV['TM_ASDOC_GENERATION'] != nil)
    @bans = (ENV['TM_AS3_BANNER_GENERATION'] != nil)

  end

  # ==============
  # = Properties =
  # ==============

  # Use the current file name to determine the new class name.
  #
  def class_name
    return file_name.sub(/.as$/,'') rescue 'Unknown'
  end

  # Use the available environmental variables to determine the file class path.
  #
  def class_path

    #when invoked from a template TM_NEW_FILE will be set.
    if ENV['TM_NEW_FILE']
      cp = ENV['TM_NEW_FILE'].sub("#{file_name}",'')
      cp.sub!(/\/$/,'')
      return convert_path(cp).gsub( "/", ".")
    end

    dir = ENV['TM_DIRECTORY']
    cp = dir ? dir : ""

    return convert_path(cp).gsub( "/", ".")

  end

  # A list of common source directories, used when calculating class paths.
  #
  def src_directories

  end

  # =========================
  # = Parsing / Substituion =
  # =========================

  def process(input)

    doc = input.split("\n")

    #flag to track state of previous line
    removed = false
    out = ""

    doc.each do |line|
      if line =~ @doc_regexp
        if @docs
          out += line + "\n"
        else
          removed = true
        end
      elsif line =~ @ban_regexp
        if @bans
          out += line + "\n"
        else
          removed = true
        end
      else
        if removed == true
          next if (line =~ /^\s*$/ )
        end
        out += line + "\n"
        removed = false
      end
    end

    out = substitue(out,substitution_list)

  end

  protected

  def substitution_list
    list = super
    list << substitution('${TM_CLASS_PATH}',class_path)
    list << substitution('${TM_NEW_FILE_BASENAME}', class_name, 1)
    list
  end

  private

  def file_name
    return File.basename(ENV['TM_NEW_FILE']) if ENV['TM_NEW_FILE']
    return ENV['TM_FILENAME']
  end

  def convert_path(path)
    require 'as3/source_tools'
    SourceTools.truncate_to_src(path)
  end

end

