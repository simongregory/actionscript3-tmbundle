#!/usr/bin/env ruby -wKU
# encoding: utf-8

module FlexMate

  module YamlTool

    class << self

      def build

        require 'fc/fcshd'
        require 'fm/as3project'
        require 'fm/mxmlc_exhaust'

        #Require being in a project
        FlexMate.require_tmproj

        #Add flex to path
        FlexMate::SDK.add_flex_bin_to_path

        #Generate the beautiful header
        FCSHD.generate_view('Yaml Tool')

        #Update status if needed
        FCSHD.set_status 'launching' if not FCSHD_SERVER.running

        # run the compiler and print filtered error messages
        FCSHD_SERVER.start_server do
          FCSHD.set_status 'up'
          AS3Project.compile
        end

      end

      def build_and_run
      end

      def run
      end

    end

  end

end
