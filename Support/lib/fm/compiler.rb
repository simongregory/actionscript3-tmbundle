#!/usr/bin/env ruby -wKU
# encoding: utf-8

module FlexMate

  class Compiler

    def initialize
      FlexMate::SDK.add_flex_bin_to_path
    end

    # Run mxmlc or compc to compile a swf adapting to the current environment as
    # necessary.
    #
    def build

      s = FlexMate::Settings.new

      cmd = build_tool(s)

      TextMate.require_cmd(cmd.name)

      init_html(cmd)

      exhaust = get_exhaust

      # This works... when, occasionally, using TextMate::Process fails. Memory allocation maybe?
      #{}`#{cmd.line}`.each { |str| STDOUT << exhaust.line(str) }

      TextMate::Process.run(cmd.line) do |str|
        STDOUT << exhaust.line(str)
      end

      STDOUT << exhaust.raw
      STDOUT << exhaust.complete

      html_footer

    end

    protected

    # Print initial html header.
    #
    def init_html(cmd)

      require ENV['TM_SUPPORT_PATH'] + '/lib/web_preview'

      puts html_head( :window_title => "ActionScript 3 Build Command",
                      :page_title => "Build (#{cmd.name})",
                      :sub_title => cmd.file_specs_name )

      puts "<h2>Building...</h2>"
      puts "<p><pre>#{cmd.to_s}</pre></p>"

    end

    # Create the object responsible for parsing the compiler output.
    #
    def get_exhaust
      require 'fm/mxmlc_exhaust'
      MxmlcExhaust.new
    end

    # Create the command responsible for compiling the source.
    #
    def build_tool(settings)
        return CompcCommand.new(settings) if settings.is_swc
        return AMxmlcCommand.new(settings) if settings.is_air
        return MxmlcCommand.new(settings)
    end

  end

  class FcshCompiler < Compiler
    def initialize
      super
    end

    # Run mxmlc inside the fcsh wrapper to compile.
    #
    def build

      bin = 'fcsh'

      TextMate.require_cmd(bin)

      s = FlexMate::Settings.new

      ENV['TM_FLEX_FILE_SPECS'] = s.file_specs
      ENV['TM_FLEX_OUTPUT'] = s.flex_output

      #WARN: Accessing s.flex_output after this point will fail. This is because
      #      settings expects TM_FLEX_OUTPUT to be relative to the project root
      #      + we've just set it to a full path.

      FlexMate.required_settings({ :files => ['TM_FLEX_FILE_SPECS'],
                                   :evars => ['TM_FLEX_OUTPUT'] })

      cmd = build_tool(s)

      fcsh = e_sh(ENV['TM_FLEX_PATH'] + '/bin/fcsh')

      #Make sure there are no spaces for fcsh to trip up on.
      FlexMate.check_valid_paths([cmd.file_specs,cmd.o,fcsh])

      init_html(cmd)

      `osascript -e 'tell application "Terminal" to activate'` unless ENV['TM_FLEX_BACKGROUND_TERMINAL']
      `#{e_sh ENV['TM_BUNDLE_SUPPORT']}/lib/fcsh_terminal \"#{fcsh}\" \"#{cmd.line}\" >/dev/null;`

      html_footer

    end

  end

  class FcshdCompiler < Compiler
    def initialize
      super
    end

    # Run mxmlc using the fcshd to compile.
    #
    def build

      TextMate.require_cmd('fcsh')

      s = FlexMate::Settings.new

      ENV['TM_FLEX_FILE_SPECS'] = s.file_specs
      ENV['TM_FLEX_OUTPUT'] = s.flex_output

      #WARN: Accessing s.flex_output after this point will fail. This is because
      #      settings expects TM_FLEX_OUTPUT to be relative to the project root
      #      + we've just set it to a full path.
      FlexMate.required_settings({ :files => ['TM_FLEX_FILE_SPECS'],
                                   :evars => ['TM_FLEX_OUTPUT'] })

      cmd = build_tool(s)

      #Make sure there are no spaces for fcsh to trip up on.
      FlexMate.check_valid_paths([cmd.file_specs,cmd.o])

      FCSHD.generate_view('Fcshd Compiler')

      exhaust = get_exhaust

      #Update status if needed
      FCSHD.set_status 'launching' if not FCSHD_SERVER.running

      # run the compiler and print filtered error messages
      FCSHD_SERVER.start_server do

        FCSHD.set_status 'up'

        STDOUT << "<h3>Compiling, #{cmd.file_specs_name}</h3>"

        FCSHD_SERVER.build(cmd.line).each_line do |ln|
          STDOUT << exhaust.line(ln)
        end

        STDOUT << exhaust.raw
        STDOUT << exhaust.complete

        html_footer

      end

    end

  end

  class TestCompiler < Compiler
    def initialize
      super
    end

    # Run mxmlc or compc to compile a swf adapting to the current environment as
    # necessary.
    #
    def build

      s = FlexMate::TestSettings.new

      cmd = build_tool(s)

      TextMate.require_cmd(cmd.name)

      init_html(cmd)

      exhaust = get_exhaust

      # This works... when, occasionally, using TextMate::Process fails. Memory allocation maybe?
      #{}`#{cmd.line}`.each { |str| STDOUT << exhaust.line(str) }

      TextMate::Process.run(cmd.line) do |str|
        STDOUT << exhaust.line(str)
      end

      STDOUT << exhaust.raw
      STDOUT << exhaust.complete

      html_footer

    end
  end

end

# Object to encapsulate a mxmlc command and its arguments.
#
class MxmlcCommand

  attr_reader :file_specs
  attr_reader :o
  attr_reader :name

  def initialize(settings)
    @name = 'mxmlc'
    @o = settings.flex_output
    @file_specs = settings.file_specs
  end

  def line
    "#{name} -file-specs=#{e_sh file_specs} -o=#{e_sh o}"
  end

  def file_specs_name
    File.basename(file_specs)
  end

  def to_s
    "#{name} -file-specs=#{file_specs}\n-o=#{e_sh o}"
  end

end

# Object to encapsulate a compc command and its arguments.
#
class CompcCommand < MxmlcCommand

  attr_reader :include_classes
  attr_reader :source_path

  def initialize(settings)
    super(settings)
    @name = 'compc'
    @include_classes = settings.list_classes
    @source_path = settings.source_path
  end

  def line
    "#{name} -source-path+=#{e_sh source_path} -o=#{e_sh o} #{include_classes}"
  end

  def to_s
    "#{name} -source-path+=#{e_sh source_path} -o=#{e_sh o}\n-include-classes=#{include_classes}"
  end

end

# Object to encapsulate a amxmlc command and its arguments.
#
class AMxmlcCommand < MxmlcCommand

  def initialize(settings)
    super(settings)
  end

  def line
    #Note: If you open the amxmlc tool you find it's just a proxy to mxmlc.
    #      However using amxmlc with fcsh doesn't work (SDK 3.5) so it's worth
    #      the risk of failure by being exposed to internal changes to amxmlc in
    #      future revisions.
    "#{name} +configname=air -file-specs=#{e_sh file_specs} -o=#{e_sh o}"
  end

  def file_specs_name
    File.basename(file_specs)
  end

  def to_s
    "#{name} +configname=air -file-specs=#{file_specs}\n-o=#{e_sh o}"
  end

end

if __FILE__ == $0

  require ENV['TM_SUPPORT_PATH'] + '/lib/escape'
  require ENV['TM_SUPPORT_PATH'] + '/lib/exit_codes'
  require ENV['TM_SUPPORT_PATH'] + '/lib/textmate'
  require ENV['TM_SUPPORT_PATH'] + '/lib/tm/process'

  require '../add_lib'
  require 'fm/sdk'
  require 'fm/settings'
  require 'as3/source_tools'

  #There's no error checking at any point so we fall back on TM_CURRENT_FILE
  #and mxmlc is perfectly happy to compile some ruby! If only :)
  FlexMate::Compiler.new.build

  #FlexMate::FcshCompiler.new.build

end
