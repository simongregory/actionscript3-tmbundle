#!/usr/bin/env ruby -wKU
# encoding: utf-8

module FCSHD

BUN_SUP = ENV['TM_BUNDLE_SUPPORT']

require 'xmlrpc/client'
#require 'Logger'
require ENV['TM_SUPPORT_PATH'] + '/lib/escape'
require ENV['TM_SUPPORT_PATH'] + '/lib/web_preview'

require ENV['TM_BUNDLE_SUPPORT'] + '/bin/fcshd_server'

# @logger = Logger.new('/tmp/fcshd/gui.log')
# @logger.level = Logger::DEBUG

def self.status
	if FCSHD_SERVER.running
		puts "Running"
	else
		puts "Stopped"
	end
end

def self.generate_view
		
		puts html_head(:window_title => "ActionScript 3", :page_title => "fcshd", :sub_title => "__" );

		puts	"<link rel='stylesheet' href='file://#{e_url(BUN_SUP)}/css/fcshd.css' type='text/css' charset='utf-8' media='screen'>"
		puts  "<script src='file://#{e_url(BUN_SUP)}/js/fcshd.js' type='text/javascript' charset='utf-8'></script>"
		puts "<div id='script-path'>#{BUN_SUP}/bin/</div>"
		puts "
		<h2><div id='status'>Checking daemon status</div></h2>
		<div id='controls'>
		  <a id='refresh' href='javascript:refreshStatus()' title='Check daemon status'>Check Status</a><br/>
		  <a id='toggle' href='javascript:toggleClick();'>Toggle State</a><br/>
		</div>"
		
		compiler_state = FCSHD_SERVER.running ? "up" : "down"
		puts '<script type="text/javascript" charset="utf-8">setState("'+compiler_state+'")</script>'
end

def self.stop_server
	return unless FCSHD_SERVER.running
	FCSHD_SERVER.stop_server
	sleep 0.5
	status
end

def self.start_server
	return if FCSHD_SERVER.running
	FCSHD_SERVER.start_server
	
	#Give up from waiting if it's taking too long
	start_time = Time.now.to_i
	while !FCSHD_SERVER.running
	 sleep 0.5
	 break if Time.now.to_i - start_time > 1000 * 10
	end

end

def self.success
    print "<script type='text/javascript' charset='utf-8'>
      if( document.getElementById('status').className != 'fail'){
        document.getElementById('status').className='success'
        document.getElementById('status').innerHTML='Success'
      }
    </script>"  
end

def self.fail
  print "<script type='text/javascript' charset='utf-8'>
      document.getElementById('status').innerHTML='Compilation Failed'
      document.getElementById('status').className='fail'
  </script>"
end

def self.close_window
  print "<script type='text/javascript' charset='utf-8'>
        window.close();
  </script>"
end

end

def run
  if ARGV[0] == "-success" 
    FCSHD.success
  elsif ARGV[0] == "-fail"
      FCSHD.fail
    elsif ARGV[0] == "-status"
      FCSHD.status
    elsif ARGV[0] == "-start"
      FCSHD.start_server
    elsif ARGV[0] == "-stop"
      FCSHD.stop_server
    elsif ARGV[0] == "-view"
      FCSHD.generate_view
  else
    "No command given"
  end
end
run