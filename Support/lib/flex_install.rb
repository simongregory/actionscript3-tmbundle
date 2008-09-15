#!/usr/bin/env ruby -wKU

# Downloads and installs flex to a default location used by TextMate.

SUPPORT = "#{ENV['TM_SUPPORT_PATH']}"
BUN_SUP = File.dirname(__FILE__)

require 'open-uri'
require SUPPORT + '/lib/ui'

install_path = "/"
sdk_path = "/Developer/SDKs"
install_path = sdk_path if File.exists?(sdk_path)

TextMate::UI.request_file(:only_directories => true, :directory => install_path)

flex_uri = "http://download.macromedia.com/pub/flex/sdk/flex_sdk_3.zip"
flex_help_uri = "http://livedocs.adobe.com/flex/3/flex3_documentation.zip"


#open("/Users/simon/Desktop/flex_sdk_3.zip","w").write(open(flex_uri).read)
#open("/Users/simon/Desktop/flex_help.zip","w").write(open(flex_help_uri).read)

# flex_dl_dir = "/tmp/tm_actionscript_3_bundle"
# download_file = "/tmp/TM_GetGITBundle/github.tmbundle.zip"
# 
# begin
#   %x{rm -r #{flex_dl_dir}}
#   FileUtils.mkdir_p flex_dl_dir
#   Timeout::timeout(20) do
#     File.open(download_file, 'w') { |f| f.write(open(path).read)}
#     system "/usr/bin/unzip '#{download_file}' -d '#{flex_dl_dir}'"
#     FileUtils.rm(download_file)
#     %x{cd '#{gitdir}'; mv '#{idname}' '#{name}'}
#     %x{cp -r '#{gitdir}/#{name}' #{e_sh install_path}}
#     %x{rm -r #{gitdir}}
#   end
# rescue Timeout::Error
#   errorcnt += 1
#   #write_to_log_file("Timeout error while installing %s" % item)
# end
# 
