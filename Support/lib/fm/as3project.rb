#!/usr/bin/env ruby -wKU
# encoding: utf-8

require 'yaml'
require 'digest/md5'
require 'fileutils'

module AS3Project

    # @logger = Logger.new('/tmp/fcshd/gui.log')
    # @logger.level = Logger::DEBUG

    @project = ENV['TM_PROJECT_DIRECTORY']
    @build_yaml = nil

    def self.build_file
        if !@build_yaml:
            build_file_path = ENV['TM_FLEX_BUILD']

            if !build_file_path and not @project.nil?
                build_file_path = File.join(@project, "build.yaml")
            end

            if !file = File.open(build_file_path) rescue nil
                printf('Could not find the build file at %s', build_file_path)
                exit
            end

            @build_yaml = YAML::load(file) rescue nil
            if !@build_yaml
              print "Something wrong when parsing YAML file"
              exit
            end
        end

        @build_yaml
    end

    def self.get_path_list(attr_name)
        dirs = []

        if build_file.has_key?(attr_name)
            build_file.fetch(attr_name).each do |path|
                dirs.push path
            end
        end

        dirs
    end

    def self.definitions(paths, relative_path_from=nil)
        classes = {}
        paths.each do |path|
        source_path = Pathname.new(File.join(@project,path))

        Find.find(source_path.to_s) do |f|
            if f =~ /.as$/
              if !relative_path_from
                clean_path = Pathname.new(f).relative_path_from(source_path).to_s
              else
                clean_path = Pathname.new(f).relative_path_from(Pathname.new(File.join(@project, relative_path_from))).to_s
              end

              classes[f.to_s] = clean_path.gsub("/", ".").gsub(".as", "")
            end
          end
        end
        classes
    end

    def self.source_path_list
        get_path_list("source-path")
    end

    def self.libray_path_list
        get_path_list("library-path")
    end

    def self.mxmlc_source_path
        paths = source_path_list
        source_path = []

        paths.each do |path|
            source_path.push "-sp+="+File.join(@project, path)
        end

        source_path.join(" ")
    end

    def self.mxmlc_library_path
        paths = libray_path_list
        library_path = []

        paths.each do |path|
            library_path.push "-library-path+="+File.join(@project, path)
        end

        library_path.join(" ")
    end

    def self.mxmlc_default_extra
        build_file.fetch("default")[0].fetch("extra") rescue ""
    end

    def self.mxmlc_default_debug
        build_file.fetch("default")[0].fetch("debug") rescue "false"
    end

    def self.default_run_file
        build_file.fetch("default")[0].fetch("open") rescue ""
    end

    def self.mxmlc_applications
        apps = []

        if build_file.has_key?("applications")
            build_file.fetch("applications").each do |app|
                if app && app.has_key?("class") && app.has_key?("output")
                    debug = app.fetch("debug") rescue mxmlc_default_debug
                    extra = app.fetch("extra") rescue mxmlc_default_extra
                    klass = File.join(@project, app.fetch("class"))
                    output = File.join(@project, app.fetch("output"))
                    library_path = mxmlc_library_path rescue ""
                    source_path = mxmlc_source_path rescue ""

                    app_obj = {"klass"=>app.fetch("class")}
                    if output =~ /.swc$/
                      require 'pathname'
                      require 'find'
                      app_obj["mxmlc"] = "compc -include-classes=#{definitions(source_path_list)[klass]} -o=#{output} #{library_path} #{source_path} #{extra}"
                    else
                      app_obj["mxmlc"] = "mxmlc #{klass} -o=#{output} -debug=#{debug} #{library_path} #{source_path} #{extra}"
                    end

                    apps.push(app_obj)
                end
            end
        end

        apps
    end

    def self.asdocs_source_path()
        paths = build_file.fetch("asdoc")[0].fetch("source-path") rescue source_path_list
        source_path = []

        paths.each do |path|
            source_path.push "-doc-sources+="+File.join(@project, path)
        end

        source_path.join(" ")
    end

    def self.asdocs_exclude_dirs()
      build_file.fetch("asdoc")[0].fetch("exclude-dirs") rescue []
    end

    def self.asdocs_exclude_classes()
      to_exclude = []

      definitions(asdocs_exclude_dirs, source_path_list).each do |path|
        to_exclude.push("-exclude-classes+="+path[1])
      end

      to_exclude.join(" ")
    end

    def self.asdocs_title()
      build_file.fetch("asdoc")[0].fetch("title") rescue "ActionScript Project"
    end

    def self.asdocs_footer()
      build_file.fetch("asdoc")[0].fetch("footer") rescue "ActionScript Project"
    end

    def self.asdocs_output()
      File.join(@project, build_file.fetch("asdoc")[0].fetch("output")) rescue ""
    end

    def self.asdocs()

      require 'find'
      require 'pathname'

      puts html_head(:window_title => "ActionScript 3", :page_title => "ASDocs", :sub_title => "Yaml Tool" );

      if build_file.has_key?("asdoc")
         print("<h2>Running ASDoc...</h2><pre>")
         system("#{ENV["TM_FLEX_PATH"]}/bin/asdoc -output #{asdocs_output} #{asdocs_source_path} #{mxmlc_library_path} #{mxmlc_source_path} #{asdocs_exclude_classes} -warnings=false -window-title '#{asdocs_title}' -main-title '#{asdocs_title}' -footer '#{asdocs_footer}'")
         print "</pre>"
         print "<strong>Done!</strong>"
       else
         print "You have to set ASDocs settings on YAML file"
       end
    end

    def self.compile()

        mxmlc_parser = MxmlcExhaust.new
        mxmlc_parser.print_output = true

        mxmlc_applications.each do |app|
          
            printf('<h3>Compiling %s</h3>', app["klass"])

            puts "<pre>"
            result = FCSHD_SERVER.build(app["mxmlc"])
            result.each_line do |line|
              mxmlc_parser.line line
            end
            puts "</pre>"

            id = app["klass"].gsub(/[\/.]/,'_').downcase
            mxmlc_parser.raw(id)
            mxmlc_parser.complete

        end
        
        if mxmlc_parser.error_count <= 0
          FCSHD.success

          if ENV["TM_BUILD_AND_RUN"].to_i == 1
            run
            FCSHD.close_window
          end

        else
          FCSHD.fail
        end
        
        html_footer
        return 0;
    end

    def self.run()
        if default_run_file != ""
          #checking if the default_run_file is local or remote
          if default_run_file.include?("://") #oh man, we have a protocol (http://, https://, ftp://)
            system("open #{default_run_file}")
          else
            system("open #{File.join(@project, default_run_file)}")
          end
        end
    end
    
    def self.library_path_list
      libs = ['lib']
      
      dirs = `ls "$TM_PROJECT_DIRECTORY/lib" 2>/dev/null`.split("\n") rescue []
      dirs.each { |d| libs << "lib/#{d}" }
      
      dirs = `ls "$TM_PROJECT_DIRECTORY/libs" 2>/dev/null`.split("\n") rescue []
      dirs.each { |d| libs << "libs/#{d}" }

      dirs = `ls "$TM_PROJECT_DIRECTORY/libs/bin" 2>/dev/null`.split("\n") rescue []
      dirs.each { |d| libs << "libs/bin/#{d}" }
      
      libs
    end
    
    def self.dump_path_list
      list = []
      #Loop through library, searching for SWC paths
      library_path_list.each do |p|
        
        next unless File.exist? p

        #Where to unpack
        lib_path = File.join(tmp_swc_dir, p.gsub("/","_"))
        #Unpack files in this folder
        Dir.entries(lib_path).delete_if{|d| not d =~ /\.swc/}.each do |entry|
          list << File.join(lib_path, entry, "classes")
        end
      end
        #@logger.debug("list: #{list}")
        list
    end

    # Unpack all swc in the library path
    # searching for possible classes
    def self.dump_swcs

      project = "#{ENV['TM_PROJECT_DIRECTORY']}"

      #Loop through library, searching for SWC paths
      library_path_list.each do |p|

        next unless File.exist? p
        
        #Where to unpack
        lib_path = File.join(tmp_swc_dir, p.gsub("/","_"))
        
        # @logger.debug("swc path: #{p} will be unpacked into: #{lib_path}")

        #Create a directory in the temp folder for holding the unpacked files
        FileUtils.mkdir_p lib_path unless File.directory? lib_path

        #Unpack files in this folder
        Dir.entries(File.join(project, p)).delete_if{|d| not d =~ /\.swc/}.each do |entry|

          #Full path to file
          swc_path = File.join(project, p, entry)
          extraction_path = File.join lib_path, entry

          #Checking if file changed
          stamp = File.stat(swc_path).mtime.to_i.to_s
          
          #checking if the file needs to be extracted
          if !File.exists? File.join(extraction_path, stamp)
            #removing old entries
            `rm -rf #{extraction_path}`
            #swc found, time to unzip it
            `unzip #{swc_path} -d #{extraction_path}`
            #create file to avoid extracting the same swc when not needed
            `touch #{File.join(extraction_path, stamp)}`
            #extract classes
            class_path = "#{File.expand_path(ENV['TM_FLEX_PATH']).gsub(' ', '\\ ')}/lib/swfutils.jar:#{ENV["TM_BUNDLE_SUPPORT"].gsub(' ', '\\ ')}/bin/definitiondumper"
            result = `java -cp #{class_path} Main #{extraction_path}/library.swf #{File.join(extraction_path, "classes")}`
          end
        end
      end
    end
    
    #SWC working folder
    def self.tmp_swc_dir

      #Create unique dir per project
      dir = "/tmp/tmas3/swcs" + Digest::MD5.hexdigest("#{ENV['TM_PROJECT_DIRECTORY']}")
      FileUtils.mkdir_p dir unless File.directory? dir
      dir 

    end
    

end

def init
    if !ARGV.empty?
        AS3Project.compile() if ARGV[0] == "-compile"
        AS3Project.run() if ARGV[0] == "-run"
        AS3Project.asdocs() if ARGV[0] == "-docs"
    end
end

init
