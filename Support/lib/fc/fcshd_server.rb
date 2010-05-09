#!/usr/bin/env ruby
# encoding: utf-8

require 'rubygems'

require 'daemons'
require 'fileutils'
require 'logger'
require 'net/http'
require 'webrick'

# Useful URLs for debugging via your web browser.
# http://localhost:6924/info
# http://localhost:6924/exit
# http://localhost:6924/status
#
# Notes: I removed all the exit calls on the s.mount_proc blocks - to what seems
# like no detrimental effect because they were being caught as an error by the 
# Webrick::HTTPServer (see the webrick_log_file).
#
# Zombies suck so I figured usig Daemons.daemonize(:mulitple => false) would be 
# a safer option but it appears to leave 'variable @controller_argv not initialized'
# errors in the system.log file.
#
# TODO: Streaming results, possibly using TCPSocket if http.request_post doesn't
# do the trick
#
module FCSHD_SERVER
  
  class << self
    
    PORT = 6924
    HOST = "localhost"

    ASSIGNED_REGEXP = /^ fcsh:.*(\d+).*/ 
    
    def log_file
      "#{ENV['HOME']}/Library/Logs/TextMate\ FCSHD.log"
    end
    
    def webrick_log_file
      "#{ENV['HOME']}/Library/Logs/TextMate\ Webrick\ FCSHD.log"
    end

    #remembering wich swfs we asked for compiling
    def start_server
      
      Daemons.call(:multiple => false) {
      
        @commands = Hash.new if @commands.nil?
      
        log = Logger.new(log_file)
        log.info("Initializing server")
      
        fcsh = ::IO.popen("#{ENV['TM_FLEX_PATH']}/bin/fcsh  2>&1", "w+")
        read_to_prompt(fcsh)

        #Creating the HTTP Server  
        s = WEBrick::HTTPServer.new(
          :Port => PORT,
          :Logger => WEBrick::Log.new(webrick_log_file, WEBrick::BasicLog::DEBUG), #WARN
          :AccessLog => []
        )

        #giving it an action
        s.mount_proc("/build"){|req, res|
          
          res['Content-Type'] = "text/html"
          res.body = ""
          
          #Searching for an id for this command
          if @commands.has_key?(req.body)
            # Exists, incremental
            fcsh.puts "compile #{@commands[req.body]}"
            res.body << read_to_prompt(fcsh)
          else
            # Does not exist, compile for the first time
            fcsh.puts req.body
            res.body << read_to_prompt(fcsh)
            match = res.body.scan(ASSIGNED_REGEXP)
            @commands[req.body] = match[0][0]
          end
          
          log.debug("asked: #{req.body}")
          log.debug("output: #{res.body}")
          
        }

        s.mount_proc("/exit"){|req, res|
          log.debug("shutting down")
          s.shutdown
          fcsh.close
          exit
        }

        s.mount_proc("/status"){|req, res|
          begin
            fcsh.puts("info 0")
            output = read_to_prompt(fcsh)
            res.body = "UP"
          rescue Exception => e
            res.body = "DOWN"
          end
          log.debug("getting status #{res.body}")
          exit
        }

        s.mount_proc("/info"){|req, res|
          log.debug("getting info")
          fcsh.puts 'info'
          output = read_to_prompt(fcsh)
          res.body = output
          res['Content-Type'] = "text/html"
          exit
        }

        trap("INT"){
          s.shutdown
          fcsh.close
        }

        #Starting webrick
        log.info("Starting Webrick at http://#{HOST}:#{PORT}")
      
        begin
        
          s.start
        
        rescue Exception => e

          #Do not show error if we're trying to start the server more than once
          if e.message =~ /Address already in use/ < 0
            log.debug(e.message)
          else
            log.debug(e)
          end

        end

      } if not running
      
      
      if block_given?
        while not running
          sleep 3
        end
        yield
      end

    end

    def build(what)
      http = Net::HTTP.new(HOST, PORT)
      http.read_timeout = 120
      #resp, date = http.post('/build', what)
      #resp.body
      
      rsp = ""
      http.request_post('/build', what) {|response|
        response.read_body do |str|
          rsp << str
        end
      }
      rsp
    end

    def stop_server
      #If you're seeing an error in the system log this could explain why...
      #http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-core/2578
      #I resolved by changing 'resp, date = http.get...' to 'resp = http.get...'
      http = Net::HTTP.new(HOST, PORT)
      resp = http.get('/exit')
      resp.body
    end

    def running
      begin
        http = Net::HTTP.new(HOST, PORT)
        resp = http.get('/status', nil)
        return true if resp.body == "UP"
      rescue => e
        puts "Error #{e}" unless e.message =~ /Connection refused - connect\(2\)/ #msql connection problem... apparently.
        return false
      end
      return false
    end
    
    protected
    
    #Helper method to read output
    def read_to_prompt(f)
      f.flush
      output = ""
      while chunk = f.read(1)
        output << chunk
        break if output =~ /^\(fcsh\)/
      end
      output
    end
    
  end
  
end
