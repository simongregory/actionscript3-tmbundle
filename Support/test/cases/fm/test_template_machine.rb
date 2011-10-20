#!/usr/bin/env ruby -wKU
# encoding: utf-8

require "test/unit"
require "fm/template_machine"

class TestTemplateMachine < Test::Unit::TestCase
  def setup
    ENV['TM_NEW_FILE'] = "example/path/to/src/org/helvector/Test.as"
    ENV['TM_FULLNAME'] = "Brian Potter"
    ENV['TM_YEAR'] = "2010"
  end

  def example_class
    "//AS3///////////////////////////////////////////////////////////////////////////
    //
    // Copyright ${TM_YEAR} ${TM_ORGANIZATION_NAME:-$TM_FULLNAME}
    //
    ////////////////////////////////////////////////////////////////////////////////

    package ${TM_CLASS_PATH}
    {

    /**
     * @author ${TM_FULLNAME}
     */
    public class ${TM_NEW_FILE_BASENAME}
    {

      //--------------------------------------
      //  CONSTRUCTOR
      //--------------------------------------

      /**
       * @constructor
       */
      public function ${TM_NEW_FILE_BASENAME}()
      {
        super();
      }

    }

    }
    "
  end

  def eg_banners_and_docs
    "//AS3///////////////////////////////////////////////////////////////////////////
    //
    // Copyright 2010 Brian Potter
    //
    ////////////////////////////////////////////////////////////////////////////////

    package org.helvector
    {

    /**
     * @author Brian Potter
     */
    public class Test
    {

      //--------------------------------------
      //  CONSTRUCTOR
      //--------------------------------------

      /**
       * @constructor
       */
      public function Test()
      {
        super();
      }

    }

    }
    \n"
  end

  def eg_no_docs_or_banners
    "    package org.helvector
    {

    public class Test
    {

      public function Test()
      {
        super();
      }

    }

    }
    \n"
  end

  def eg_no_banners
    "    package org.helvector
    {

    /**
     * @author Brian Potter
     */
    public class Test
    {

      /**
       * @constructor
       */
      public function Test()
      {
        super();
      }

    }

    }
    \n"
  end

  def eg_no_docs
    "//AS3///////////////////////////////////////////////////////////////////////////
    //
    // Copyright 2010 Brian Potter
    //
    ////////////////////////////////////////////////////////////////////////////////

    package org.helvector
    {

    public class Test
    {

      //--------------------------------------
      //  CONSTRUCTOR
      //--------------------------------------

      public function Test()
      {
        super();
      }

    }

    }
    \n"
  end

  def test_no_docs_or_banners
    p = ActionScript3TemplateMachine.new
    assert_equal(eg_no_docs_or_banners, p.process(example_class))
  end

  def test_no_banners
   p = ActionScript3TemplateMachine.new
   p.docs = true
   assert_equal(eg_no_banners, p.process(example_class))
  end

  def test_banners_and_docs
    ENV['TM_ORGANIZATION_NAME'] = 'Brian Potter'
    p = ActionScript3TemplateMachine.new
    p.bans = true
    p.docs = true
    assert_equal(eg_banners_and_docs, p.process(example_class))
  end

  def test_banners_only
    ENV['TM_ORGANIZATION_NAME'] = 'Brian Potter'
    p = ActionScript3TemplateMachine.new
    p.bans = true
    assert_equal(eg_no_docs, p.process(example_class))
  end
end
