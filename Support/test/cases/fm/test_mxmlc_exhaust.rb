#!/usr/bin/env ruby -wKU
# encoding: utf-8

require "test/unit"
require "fm/mxmlc_exhaust"
require ENV['TM_SUPPORT_PATH'] + '/lib/escape'

class TestMxmlcExhaust < Test::Unit::TestCase
  def in_out
    [
      { :in => 'Loading configuration file /Developer/SDKs/flex_sdk_3.1.0/frameworks/flex-config.xml',
        :out => '<br/>Loading configuration file: <a title="Click to open /Developer/SDKs/flex_sdk_3.1.0/frameworks/flex-config.xml" href="txmt://open?url=file:///Developer/SDKs/flex_sdk_3.1.0/frameworks/flex-config.xml" >flex-config.xml</a><br/>'
      },
      {
        :in => "/Users/simon/Documents/code/actionscript_3/flex_unit/trunk/FlexUnitTest/src/FlexUnitTestRunner.mxml: Error: Unable to locate specified base class 'FlexUnitTestRunnerApplication' for component class 'FlexUnitTestRunner'.",
        :out => "<br/>Error Unable to locate specified base class 'FlexUnitTestRunnerApplication' for component class 'FlexUnitTestRunner'. in <a title=\"/Users/simon/Documents/code/actionscript_3/flex_unit/trunk/FlexUnitTest/src/FlexUnitTestRunner.mxml\" href=\"txmt://open?url=file:///Users/simon/Documents/code/actionscript_3/flex_unit/trunk/FlexUnitTest/src/FlexUnitTestRunner.mxml\">FlexUnitTestRunner.mxml</a><br/>",
      },
      {
        :in => "deploy/CompileTest.swf (417 bytes)",
        :out => "<script type=\"text/javascript\" charset=\"utf-8\">function openSwf(){TextMate.system('open deploy/CompileTest.swf', null);}</script><br/><a href='javascript:openSwf()' title='Click to run (if there is space in the file path this may not work).'>deploy/CompileTest.swf</a> (417 bytes)<br/>"
      },
      {
        :in => "Error: could not find source for class BlahBlah:mxml",
        :out => "<pre>Error: could not find source for class BlahBlah:mxml</pre>"
      },
      {
        :in => " ",
        :out => "<!-- empty -->"
      },
      {
        :in => "Adobe Compc (Flex Component Compiler)",
        :out => "Adobe Compc (Flex Component Compiler)<br/>"
      },
      {
        :in => "Version 3.4.0 build 9271",
        :out => "Version 3.4.0 build 9271<br/>"
      },
      {
        :in => "Copyright (c) 2004-2007 Adobe Systems, Inc. All rights reserved.",
        :out => "Copyright (c) 2004-2007 Adobe Systems, Inc. All rights reserved.<br/>"
      },
      {
        :in => "Nothing has changed since the last compile. Skip...",
        :out => "<br/>Nothing has changed since the last compile. Skip..."
      }
      # Added the following after getting problematic output when compiling the RobotLegs helvector gallery, but couldn't work out what the problem was.
      #,{
      #  :in => "/Users/simon/src/helvector/robotlegs-framework/src/org/robotlegs/base/CommandMap.as(64): col: 19 Warning: The super() statement will be executed prior to entering this constructor.  Add a call to super() within the constructor if you want to explicitly control when it is executed.",
      #  :out => "???"
      #},
      #{
      #  :in => "public function CommandMap(eventDispatcher:IEventDispatcher, injector:IInjector, reflector:IReflector)",
      #  :out => ""
      #}
    ]
  end

  def test_exhaust

    exhaust = MxmlcExhaust.new

    in_out.each { |e|
      assert_equal(e[:out], exhaust.line(e[:in]))
    }

    assert_equal(2, exhaust.error_count)
    assert_equal(in_out.length, exhaust.line_count)

    assert_equal(in_out.map { |e| e[:in] }.to_s, exhaust.input.to_s)

  end
end