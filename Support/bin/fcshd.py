#!/usr/bin/env python
# encoding: utf-8
"""
fcshd.py by leo soto
http://code.google.com/p/flex-compiler-shell-daemon/

minor modifications for use with the textmate as3 bundle by cds

Created by Christian Swinehart on 2008-10-09.
Copyright (c) 2008 Pentagram. All rights reserved.
"""


import logging
import os
import re
import time
from optparse import OptionParser
from subprocess import Popen, PIPE, STDOUT
from xmlrpclib import ServerProxy, Error

# port used for xml-rpc communication with the compiler process
PORT = 2345

# -- createDaemon() code from: http://code.activestate.com/recipes/278731/
# Default daemon parameters.
# File mode creation mask of the daemon.
UMASK = 0

# Default working directory for the daemon.
WORKDIR = "/tmp/fcshd"
if not os.path.exists(WORKDIR):
  os.makedirs(WORKDIR)

# Default maximum for the number of available file descriptors.
MAXFD = 1024

# The standard I/O file descriptors are redirected to /dev/null by default.
if (hasattr(os, "devnull")):
   REDIRECT_TO = os.devnull
else:
   REDIRECT_TO = "/dev/null"

def createDaemon():
   """Detach a process from the controlling terminal and run it in the
   background as a daemon.
   """
   try:
      # Fork a child process so the parent can exit.  This returns control to
      # the command-line or shell.  It also guarantees that the child will not
      # be a process group leader, since the child receives a new process ID
      # and inherits the parent's process group ID.  This step is required
      # to insure that the next call to os.setsid is successful.
      pid = os.fork()
   except OSError, e:
      raise Exception, "%s [%d]" % (e.strerror, e.errno)

   if (pid == 0):       # The first child.
      # To become the session leader of this new session and the process group
      # leader of the new process group, we call os.setsid().  The process is
      # also guaranteed not to have a controlling terminal.
      os.setsid()

      # Is ignoring SIGHUP necessary?
      #
      # It's often suggested that the SIGHUP signal should be ignored before
      # the second fork to avoid premature termination of the process.  The
      # reason is that when the first child terminates, all processes, e.g.
      # the second child, in the orphaned group will be sent a SIGHUP.
      #
      # "However, as part of the session management system, there are exactly
      # two cases where SIGHUP is sent on the death of a process:
      #
      #   1) When the process that dies is the session leader of a session that
      #      is attached to a terminal device, SIGHUP is sent to all processes
      #      in the foreground process group of that terminal device.
      #   2) When the death of a process causes a process group to become
      #      orphaned, and one or more processes in the orphaned group are
      #      stopped, then SIGHUP and SIGCONT are sent to all members of the
      #      orphaned group." [2]
      #
      # The first case can be ignored since the child is guaranteed not to have
      # a controlling terminal.  The second case isn't so easy to dismiss.
      # The process group is orphaned when the first child terminates and
      # POSIX.1 requires that every STOPPED process in an orphaned process
      # group be sent a SIGHUP signal followed by a SIGCONT signal.  Since the
      # second child is not STOPPED though, we can safely forego ignoring the
      # SIGHUP signal.  In any case, there are no ill-effects if it is ignored.
      #
      # import signal           # Set handlers for asynchronous events.
      # signal.signal(signal.SIGHUP, signal.SIG_IGN)

      try:
         # Fork a second child and exit immediately to prevent zombies.  This
         # causes the second child process to be orphaned, making the init
         # process responsible for its cleanup.  And, since the first child is
         # a session leader without a controlling terminal, it's possible for
         # it to acquire one by opening a terminal in the future (System V-
         # based systems).  This second fork guarantees that the child is no
         # longer a session leader, preventing the daemon from ever acquiring
         # a controlling terminal.
         pid = os.fork()        # Fork a second child.
      except OSError, e:
         raise Exception, "%s [%d]" % (e.strerror, e.errno)

      if (pid == 0):    # The second child.
         # Since the current working directory may be a mounted filesystem, we
         # avoid the issue of not being able to unmount the filesystem at
         # shutdown time by changing it to the root directory.
         os.chdir(WORKDIR)
         # We probably don't want the file mode creation mask inherited from
         # the parent, so we give the child complete control over permissions.
         os.umask(UMASK)
      else:
         # exit() or _exit()?  See below.
         os._exit(0)    # Exit parent (the first child) of the second child.
   else:
      # exit() or _exit()?
      # _exit is like exit(), but it doesn't call any functions registered
      # with atexit (and on_exit) or any registered signal handlers.  It also
      # closes any open file descriptors.  Using exit() may cause all stdio
      # streams to be flushed twice and any temporary files may be unexpectedly
      # removed.  It's therefore recommended that child branches of a fork()
      # and the parent branch(es) of a daemon use _exit().
      os._exit(0)       # Exit parent of the first child.

   # Close all open file descriptors.  This prevents the child from keeping
   # open any file descriptors inherited from the parent.  There is a variety
   # of methods to accomplish this task.  Three are listed below.
   #
   # Try the system configuration variable, SC_OPEN_MAX, to obtain the maximum
   # number of open file descriptors to close.  If it doesn't exists, use
   # the default value (configurable).
   #
   # try:
   #    maxfd = os.sysconf("SC_OPEN_MAX")
   # except (AttributeError, ValueError):
   #    maxfd = MAXFD
   #
   # OR
   #
   # if (os.sysconf_names.has_key("SC_OPEN_MAX")):
   #    maxfd = os.sysconf("SC_OPEN_MAX")
   # else:
   #    maxfd = MAXFD
   #
   # OR
   #
   # Use the getrlimit method to retrieve the maximum file descriptor number
   # that can be opened by this process.  If there is not limit on the
   # resource, use the default value.
   #
   import resource              # Resource usage information.
   maxfd = resource.getrlimit(resource.RLIMIT_NOFILE)[1]
   if (maxfd == resource.RLIM_INFINITY):
      maxfd = MAXFD

   # Iterate through and close all file descriptors.
   for fd in range(0, maxfd):
      try:
         os.close(fd)
      except OSError:   # ERROR, fd wasn't open to begin with (ignored)
         pass

   # Redirect the standard I/O file descriptors to the specified file.  Since
   # the daemon has no controlling terminal, most daemons redirect stdin,
   # stdout, and stderr to /dev/null.  This is done to prevent side-effects
   # from reads and writes to the standard I/O file descriptors.

   # This call to open is guaranteed to return the lowest file descriptor,
   # which will be 0 (stdin), since it was closed above.
   os.open(REDIRECT_TO, os.O_RDWR)      # standard input (0)

   # Duplicate standard input to standard output and standard error.
   os.dup2(0, 1)                        # standard output (1)
   os.dup2(0, 2)                        # standard error (2)

   return(0)

# -- End of createDaemon() code from: http://code.activestate.com/recipes/278731/

class FCSH(object):
    """
    FCSH wrapper.

    Communicate with a fcsh process through a pipe, and transparently take
    advantage of fcsh "cache" of compilation steps.
    """
    PROMPT = '\n(fcsh)'
    TARGET_ID_RE = re.compile('fcsh: Assigned ([0-9]+) as the compile target id')

    def __init__(self):
        self.fcsh = Popen("$TM_FLEX_PATH/bin/fcsh", shell=True, close_fds=True,
                           stdin=PIPE, stdout=PIPE, stderr=STDOUT)
        #self.fcsh = Popen("/Developer/SDKs/flex_sdk_3/bin/fcsh", shell=True, close_fds=True, stdin=PIPE, stdout=PIPE, stderr=STDOUT)
        self.command_ids = {}
        self.read_to_prompt()

    def read_to_prompt(self):
        """
        Reads fcsh output until the prompt is detected, and returns the collected
        output
        """
        # self.fcsh.stdout.flush() # python 2.5 is choking on this. is that surprising?
        output = ""
        ch = self.fcsh.stdout.read(1)
        while ch:
            output += ch
            if output.endswith(self.PROMPT):
                break
            ch = self.fcsh.stdout.read(1)
        logging.debug("Found fcsh prompt")
        return output

    def run_command(self, cmd):
        """
        Pass the command to fcsh. Automatically adds '\n' to the end of ``cmd``.

        Also remembers the "compilation target id" of every passed command, to
        take advantage of fcsh 'cache'. This means that if the ``'mxmlc foo.mxml'``
        command is issued twice, the second time it actually executes
        ``"compile 1"`` (assuming that fcsh assigned 1 as the compilation id the
        first time the command was issued)

        The process described above is completely handled inside ``run_command``.
        The client code doesn't have to do anything special.
        """
        logging.debug("Running fcsh cmd: %s" % cmd)
        if cmd in self.command_ids:
            logging.debug("Found pre-existing id: %s" %
                          self.command_ids[cmd])
            self.fcsh.stdin.write('compile %s\n' % self.command_ids[cmd])
        else:
            self.fcsh.stdin.write(cmd + "\n")
        output = self.read_to_prompt()
        # If the command didn't had an id, it should have one now
        if not cmd in self.command_ids:
            match = self.TARGET_ID_RE.search(output)
            if match:
                self.command_ids[cmd] = match.groups()[0]
                logging.debug("Recording generated id: %s" %
                              self.command_ids[cmd])
        return output


def run_server():
    """
    Daemonizes the process and starts an XML-RPC server to drive the FCSH
    wrapper.
    """
    retCode = createDaemon()
    logging.basicConfig(level=logging.DEBUG,
                        format='%(asctime)s %(levelname)s %(message)s',
                        filename='%s/fcshd.log'%WORKDIR,
                        filemode='w')


    # The code, as is, will create a new file in the root directory, when
    # executed with superuser privileges.  The file will contain the following
    # daemon related process parameters: return code, process ID, parent
    # process group ID, session ID, user ID, effective user ID, real group ID,
    # and the effective group ID.  Notice the relationship between the daemon's
    # process ID, process group ID, and its parent's process ID.

    procParams = """
    return code = %s
    process ID = %s
    parent process ID = %s
    process group ID = %s
    session ID = %s
    user ID = %s
    effective user ID = %s
    real group ID = %s
    effective group ID = %s
    """ % (retCode, os.getpid(), os.getppid(), os.getpgrp(), os.getsid(0),
           os.getuid(), os.geteuid(), os.getgid(), os.getegid())
    logging.info(procParams + "\n")

    fcsh = FCSH()
    logging.debug("FCSH initialized\n")

    from SimpleXMLRPCServer import SimpleXMLRPCServer
    server = SimpleXMLRPCServer(("localhost", PORT))
    server.register_introspection_functions()
    server.register_function(lambda cmd: fcsh.run_command(cmd), 'run_command')
    server.register_function(lambda: os._exit(0), 'exit')
    server.serve_forever()

def fcsh_server_proxy():
    return ServerProxy("http://localhost:%d" % PORT)

def run_command(cmd):
    import socket
    server = fcsh_server_proxy()
    try:
       output =  server.run_command(cmd)
    except socket.error:
       start_server()
       # time.sleep(2) # moved here since we took the pause out of start_server
       output = server.run_command(cmd)
    except Error, v:
       print "XML-RPC Error:", v
       return 1
    print output
    # Check if compilation worked:
    if re.search(r'\.swf \([0-9]+ bytes\)', output):
       return 0
    else:
       return 1

def start_server():
    # print "Starting the server, please wait...",
    if os.fork() == 0:
        run_server()
        os._exit(0)

    # time.sleep(2) # Give time to child to start up the server
                    # actually, let's do this in the caller instead [cds - 9 oct 08]
    # print "OK."

def stop_server():
    server = fcsh_server_proxy()
    try:
        server.exit()
    except Error:
        # The exit() method in the server never returns. Thus,
        # it always trigger a RPC error.
        pass
    # But we can check that the server is down:
    try:
        server.run_command("dummy")
    except:
        pass
    else:
        print "Couldn't stop the server"

def parse_options(args):
    parser = OptionParser()
    parser.add_option('--stop-server', action="store_true", dest="stop",
                      default=False, help="Stops the FCSH server and exit")
    parser.add_option('--start-server', action="store_true", dest="start",
                      default=False, help="Starts the FCSH server and exit")
    return parser.parse_args(args)

def main(args):
    options, args = parse_options(args)
    if options.start:
        run_server()
    elif options.stop:
        stop_server()
    else:
        command = " ".join(args[1:]).strip()
        if not command:
            command = "help"
        return run_command(command)

if __name__ == "__main__":
    import sys
    sys.exit(main(sys.argv))
