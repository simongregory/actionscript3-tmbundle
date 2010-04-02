#!/usr/bin/env ruby -wKU
# encoding: utf-8

module FlexMate

  module ASD

    class << self

      # Search documentation for the following.
      #
      def find(word='')

        word = request_search_term if word.empty?
        TextMate.exit_discard if word.empty?
        word = esc(word)

        fx = FlexLangReference.new
        results = fx.search(word)

        fl4 = FlashCS4LangReference.new
        results << fl4.search(word) if fl4.usable

        fl3 = FlashCS3LangReference.new
        results << fl3.search(word) if fl3.usable && !fl4.usable

        show_results(word,results)

      end

      def request_search_term()

        require ENV['TM_SUPPORT_PATH'] + '/lib/ui'

        word = TextMate::UI.request_string( :title => "ActionScript 3 Help Search",
                                            :prompt => "Enter a term to search for:",
                                            :button1 => "search")
      end

      def show_results(word, results)

        require ENV['TM_SUPPORT_PATH'] + '/lib/tm/htmloutput'
        require ENV['TM_SUPPORT_PATH'] + '/lib/exit_codes'
        
        TextMate::HTMLOutput.show(
          :title => "Documentation for ‘#{word}’",
          :sub_title => "ActionScript 3 / Flex Dictionary"
        ) do |io|
          io << <<-HTML
            #{results}
            <p>
            #{online_docs(word)}
            </p>
          HTML
        end

        TextMate.exit_show_html

      end

      # Link to index online version of the documentation.
      #
      def online_docs(word)
        "<a title=\"Search Adobe Livedocs for #{word}\"
            href=\"http://livedocs.adobe.com/cfusion/search/index.cfm?loc=en_US&termPrefix=site%3Alivedocs.macromedia.com%2Fflex%2F201++&term=site%3Alivedocs.macromedia.com%2Fflex%2F201++%22#{word}%22&area=&search_text=#{word}&action=Search\">Search Livedocs</a>"
      end

      # Converts < and & to html entities.
      #
      def esc(word)
        word.gsub("&", "&amp;").gsub("<", "&lt;")
      end

    end

  end

end

# Abstract superclass for language references.
#
class LangReference

  attr_reader :toc
  attr_reader :path
  attr_reader :lang_ref
  attr_reader :found

  def initialize()
    @name     = 'Docs'
    @path     = ''
    @toc      = ''
    @lang_ref = ''
    @found    = []
  end

  def search(word)

    return "#{@name}<p><ul><li>#{@name} language reference not found.</li></ul></p>" unless usable

    setup_regex(word)

    ::IO.readlines(@toc).each do |line|
      if line =~ @exact_rgx
        m = $1 
        p = cp(m)
        @found << { :href => "#{@path}/#{m}", :hit => 'exact', :title => p, :class => p.split('.').pop()}
      elsif line =~ @partial_rgx
        m = $1
        p = cp(m)
        @found << { :href => "#{@path}/#{m}", :hit => 'partial', :title => p, :class => p.split('.').pop()}
      end
    end

    out = ""

    if @found.size == 1
      
      fp = @found[0][:href]
      
      if File.exist?(fp)
        out << "<b>#{word}</b> Found, redirecting..."
        out << "<meta http-equiv='refresh' content='0; tm-file://#{fp}'>"
      else
        out << "<b>#{word}</b> was found in search index but the corresponding documentation file is missing."
      end

    elsif @found.size > 0

      out << lang_ref
      out << "<p><ul>"

      @found.each { |e|
        doc_file = e[:href].sub(/#.+$/,'')
        if File.exist?(doc_file)
          out << "<li><a title='#{e[:title]}' href='tm-file://#{e[:href]}'>#{e[:class]}</a></li>\n"
        else
          out << "<li><span title='In search index but document is missing.'>#{e[:class]}</span></li>\n"
        end
        
      }

      out << "</ul></p>"

    else

      out << lang_ref
      out << "<ul><li>No results</li></ul><br>"

    end

  end

  def usable
    File.exists?(@toc) && File.exists?(@path)
  end

  protected

  # Override in subclasses to customise a search for a different data source.
  #
  def setup_regex(word)
    @exact_rgx   = /href='(.*)'>#{word}<\//
    @partial_rgx = /href='(.*)'>#{word}/
  end

  private

  # Converts a asdoc file path to a class path.
  #
  def cp(path)
     path.gsub('/','.').sub('.html','')
  end

end

class FlexLangReference < LangReference

  def initialize()
    super
    @name     = 'Flex SDK'
    @path     = ENV['TM_FLEX_PATH'] + '/docs/langref'
    #         This covers the odd case where the user has built the docs using the 
    #         tasks provided with the SDK.
    @path     = ENV['TM_FLEX_PATH'] + '/asdoc-output' unless File.directory?(@path)
    @toc      = ENV['TM_BUNDLE_SUPPORT'] + '/data/doc_dictionary.xml'
    @lang_ref = "<a href='tm-file://#{@path}/index.html'" +
                "title = '#{@name} - Flex Language Reference Index'>Flex&trade; Language Reference</a>"
  end

end

class FlashCS3LangReference < LangReference

  def initialize()
    super
    @name     = 'Flash CS3'
    @path     = '/Library/Application Support/Adobe/Flash CS3/en/Configuration/HelpPanel/help/ActionScriptLangRefV3'
    @toc      = "#{@path}/help_toc.xml"
    @lang_ref = "<a href='tm-file://#{@path}index.html'"+
                "title = '#{@name} - ActionScript 3.0 Language and Components Reference Index'>#{@name} ActionScript 3.0 Language Reference</a>"
  end

  protected

  def setup_regex(word)
    @exact_rgx = /name="#{word} class"\shref="(.*)"\/>/
    @partial_rgx = /name="#{word}.*"\shref="(.*)"\/>/
  end

end

class FlashCS4LangReference < LangReference

  def initialize()
    super
    @name     = 'Flash CS4'
    @path     = '/Library/Application Support/Adobe/Help/en_US/AS3LCR/Flash_10.0'
    @toc      = "#{@path}/helpmap.txt"
    @lang_ref = "<a href='tm-file://#{@path}/index.html'"+
                "title = '#{@name} - ActionScript 3.0 Language and Components Reference Index'>#{@name} ActionScript 3.0 Language Reference</a>"
  end

  protected

  def setup_regex(word)
    @exact_rgx = /:#{word}\t(.*)\t/
    @partial_rgx = /:#{word}[\w:]+\t(.*)(\t)/
  end

end

if __FILE__ == $0

  ENV['TM_BUNDLE_SUPPORT'] = "/Users/#{ENV['USER']}/Documents/code/git/actionscript3-tmbundle/Support"
  ENV['TM_FLEX_PATH'] = '/Developer/SDKs/flex_sdk_3.2.0'

  term = FlexMate::ASD.request_search_term()

  puts term

  FlexMate::ASD.find(term)
  FlexMate::ASD.find()

end
