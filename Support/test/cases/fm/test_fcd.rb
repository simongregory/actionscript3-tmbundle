#!/usr/bin/env ruby -wKU
# encoding: utf-8

require "test/unit"
require "fm/fcd"

class FlexConfigDocTest < Test::Unit::TestCase

  def test_find

    checks = [
      { :node => 'meta.tag.xml.flex-config.compiler.warn-number-from-string-changes',
        :help => "In ActionScript 3.0, white space is ignored and '' returns 0. Number() returns NaN in ActionScript 2.0 when the parameter is '' or contains white space."
      },
      { :node => 'meta.tag.xml.flex-config.compiler.defaults-css-files',
        :help => 'No documentation found.'
      },
      { :node => 'meta.tag.xml.flex-config.compiler.external-library-path',
        :help => 'list of SWC files or directories to compile against but to omit from linking'
      },
      { :node => 'meta.tag.xml.flex-config.frames.frame',
        :help => 'A SWF frame label with a sequence of classnames that will be linked onto the frame.'
      },
      { :node => nil,
        :help => 'No documentation found.'
      }
    ]

    fcd = FlexConfigDoc.new
    checks.each { |e| assert_equal(e[:help], fcd.find(e[:node])) }

  end

end
