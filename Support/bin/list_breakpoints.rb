#!/usr/bin/env ruby -wKU

# Collect all break points from the current textmate document.
# Breakpoints are specified as /*>BP<*/

require ENV['TM_SUPPORT_PATH']+"/lib/escape"

bps = []
file = ENV['TM_FILEPATH']

bp_rgx= /\/\*>BP<\*\//  #/*>BP<*/

File.open(file) do |io|
  io.grep(bp_rgx) do |bpt|
    bps << { 'file' => File.basename(file), 'line' => io.lineno }
  end
end

bps.each do |bp|
  arg = "break #{bp['file']}:#{bp['line']}"
  `fdb_terminal "nil" "nil" #{e_sh(arg)}`
end
