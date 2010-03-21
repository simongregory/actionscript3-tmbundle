#!/usr/bin/env ruby -wKU
# encoding: utf-8

# TextMate Bundle Utils.
#
module FlexMate

  module BundleTool

    class << self

      # List of directories in which TextMate commonly stores Bundles.
      #
      # The list is returned in the order (zero index == first) in which TextMate
      # uses to decide precedence of bundle items.
      #
      def bundle_dirs

        require ENV['TM_SUPPORT_PATH'] + '/lib/textmate'

        #NOTE: this order is important as it represents the precedence tm uses
        paths = [ "#{ENV['HOME']}/Library/Application Support/TextMate/Bundles",
                  "#{ENV['HOME']}/Library/Application Support/TextMate/Pristine Copy/Bundles",
                  "/Library/Application Support/TextMate/Bundles"
        ]

        begin
          paths << TextMate::app_path.gsub('(.*?)/MacOS/TextMate','\1') + "/Contents/SharedSupport/Bundles"
        rescue
        end

        paths
      end

      # List all the paths in which the named bundle is located.
      #
      def find_bundle(name='')
        return nil if name.empty?
        name += ".tmbundle" unless name =~ /\.tmbundle$/
        found = bundle_dirs.find_all { |dir| File.directory? "#{dir}/#{name}" }
        found.collect! {|d| d + "/" + name }
      end

      # Returns a list of file paths to all templates found within
      # the specified paths.
      #
      def get_template_paths(paths,template_name)

        template = '/Templates'
        filter    = /Project/
        found = []
        stored = []

        paths.each { |p|
          bundle_name = p.split('/').pop
          template_dir = "#{p}#{template}"
          Dir.entries(template_dir).each { |filename|
            next if filename =~ filter
            template_path = template_dir+'/'+filename+'/'+template_name
            if File.exists? template_path
              title = filename.sub('.tmTemplate','')
              id = "#{bundle_name}/#{title}"
              unless stored.include?(id)
                found << { 'title' => title,
                           'data' => template_path,
                           'bundle' => bundle_name }
                stored << id
              end
            end
          }
          found << { 'title' => '---' } if found.any?
        }

        found.pop if found.last['title'] == '---'
        
        found
      end

      # Returns all the templates within the named bundles conforming to our
      # search criteria (they don't have 'Project' in the template name, and
      # contain a file named class.as)
      #
      def class_template_search(names)
        names = [ENV['TM_BUNDLE_PATH']] if names.empty?
        paths = []
        names.each { |n| paths << find_bundle(n) }
        get_template_paths(paths.flatten!, 'class.as')
      end

    end

  end

end

if __FILE__ == $0

  puts "--- Bundle Dirs"
  puts FlexMate::BundleTool.bundle_dirs

  puts "\n--- Bundle Names (without file extension)"
  puts FlexMate::BundleTool.find_bundle('ActionScript 3')
  puts FlexMate::BundleTool.find_bundle('Flex')
  puts FlexMate::BundleTool.find_bundle('Flash')

  puts "\n--- Bundle Names (with file extension)"
  puts FlexMate::BundleTool.find_bundle('ActionScript 3.tmbundle')
  puts FlexMate::BundleTool.find_bundle('Flex.tmbundle')
  puts FlexMate::BundleTool.find_bundle('Flash.tmbundle')
  puts FlexMate::BundleTool.find_bundle('zzzzzz')

  puts "\n--- All ActionScript 3 and Flex Templates"
  FlexMate::BundleTool.class_template_search(['ActionScript 3', 'Flex']).each { |t|
    tmpl = t['bundle'] + ' ' + t['title'] rescue 'TEST ERROR'
    puts tmpl
  }

end
