#!/usr/bin/python

import sys, os.path, re, os, atexit, signal

matcher = re.compile(r'(/.*?)(\(([0-9]+)\)|):.*(Error|Warning):\s*(.*)$')

sys.stdout.flush()
line = sys.stdin.readline()
errs = 0

def exitSignal():
	global errs
	if ( errs == 0 ):
		sys.exit(0)._exit();
	else:
		sys.exit(1)._exit();
		
atexit.register( exitSignal )

build_message=""

while line:
	line = line.rstrip()
	#This line strips the formatting added by ant.
	line = line.replace( "[exec] ", "", 1 )
	match = matcher.search(line)
	if match:
		errs = errs + 1
		f = match.group(1)
		l = match.group(3)
		e = match.group(5)
		print '<br><div id="err"><code>File: %s<br />Line: %s<br />Error: <a title="Click to show error and close output" href="txmt://open?url=file://%s&line=%s" onclick="self.close();">%s</a></code></div>' % (f, l, f, l, e )
	elif (line[0:1] != " "):
		print '<code>%s</code><br />' % line
	#end_if
	sys.stdout.flush()
	line = sys.stdin.readline()
#end_while

print '<br><div id="end"><code>Build complete, %s error(s) occured.</code></div>' % errs
	