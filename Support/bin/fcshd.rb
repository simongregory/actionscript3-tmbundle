#!/usr/bin/env ruby -wKU

BUN_SUP = File.dirname(__FILE__)
SUPPORT = "#{ENV['TM_SUPPORT_PATH']}"

require 'xmlrpc/client'
require SUPPORT + '/lib/escape'
require SUPPORT + '/lib/web_preview'

$server = XMLRPC::Client.new2("http://localhost:2345")

def server_status
	begin
		result = $server.call("no_existent_mehtod")
	rescue Errno::ECONNREFUSED => e
		return false
	rescue XMLRPC::FaultException => e
		return true
	end
end

def status
	if server_status
		puts "Running"
	else
		puts "Stopped"
	end
end

def generate_view
		
		puts html_head(:window_title => "ActionScript 3", :page_title => "fcshd", :sub_title => "__" );

		puts	"<link rel='stylesheet' href='file://#{e_url(BUN_SUP)}/../css/fcshd.css' type='text/css' charset='utf-8' media='screen'>"
		puts  "<script src='file://#{e_url(BUN_SUP)}/../js/fcshd.js' type='text/javascript' charset='utf-8'></script>"
		puts "<div id='script-path'>#{BUN_SUP}/</div>"
		puts "
		<h2><div id='status'>Checking daemon status</div></h2>
		<div id='controls'>
		  <a id='refresh' href='javascript:refreshStatus()' title='Check daemon status'>Check Status</a><br/>
		  <a id='toggle' href='javascript:toggleClick();'>Toggle State</a><br/>
		</div>"
		
		compiler_state = server_status ? "up" : "down"
		puts '<script type="text/javascript" charset="utf-8">setState("'+compiler_state+'")</script>'
		
end

def stop_server
	return unless server_status
	`#{e_sh(BUN_SUP)}/fcshd.py --stop-server`
	sleep 0.5
	status
end

def start_server
	return if server_status
	`#{e_sh(BUN_SUP)}/fcshd.py --start-server`
	sleep 0.5
	status
end

def success
  print "<script type='text/javascript' charset='utf-8'>
      document.getElementById('status').className='success'
      document.getElementById('status').innerHTML='Success'
  </script>"
end

def fail
  print "<script type='text/javascript' charset='utf-8'>
      document.getElementById('status').innerHTML='Compilation Failed'
      document.getElementById('status').className='fail'
  </script>"
end

def run
	
	if ARGV.empty?
		puts "Please specify args."
		print "Server is "
		status
		return
	end
	
	generate_view if ARGV[0] == "-view"
	stop_server if ARGV[0] == "-stop"
	start_server if ARGV[0] == "-start"
	status if ARGV[0] == "-status"
	success if ARGV[0] == "-success"
	fail if ARGV[0] == "-fail"
  
end

run
