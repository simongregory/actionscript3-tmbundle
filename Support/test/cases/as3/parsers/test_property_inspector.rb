#!/usr/bin/env ruby -wKU
# encoding: utf-8

################################################################################
#
#   Copyright 2009-2010 Simon Gregory
#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
################################################################################

require "test/unit"
require "as3/parsers/property_inspector"

class TestPropertyInspector < Test::Unit::TestCase

  # ==========================================================================
  # = WARNING - LEAVE INDENTATION AS IT IS FOR LINE INDEXES TO WORK PROPERLY =
  # ==========================================================================

    # ========================
    # = property_chain Tests =
    # ========================

    def test_property
      ENV['TM_SCOPE'] = 'source.actionscript.3'
      ENV['TM_CURRENT_LINE'] = <<-EOF
      basicProperty.
      EOF

      ENV['TM_LINE_INDEX']   = '19'
      assert_equal 'basicProperty', PropertyInspector.property_chain

      ENV['TM_LINE_INDEX']   = '20'
      assert_equal 'basicProperty', PropertyInspector.property_chain

      ENV['TM_LINE_INDEX']   = '0'
      assert_equal nil, PropertyInspector.property_chain

      ENV['TM_LINE_INDEX']   = '5'
      assert_equal nil, PropertyInspector.property_chain

      ENV['TM_LINE_INDEX']   = '47'
      assert_equal nil, PropertyInspector.property_chain

    end

    def test_method
      ENV['TM_SCOPE'] = 'source.actionscript.3'
      ENV['TM_LINE_INDEX']   = '20'
      ENV['TM_CURRENT_LINE'] = <<-EOF
      simpleMethod()
      EOF

      assert_equal 'simpleMethod', PropertyInspector.property_chain

    end

    def test_method_with_basic_parameters
      ENV['TM_SCOPE'] = 'source.actionscript.3'
      ENV['TM_LINE_INDEX']   = '47'
      ENV['TM_CURRENT_LINE'] = <<-EOF
      parameterisedMethodCall( "hello", world )
      EOF

      assert_equal 'parameterisedMethodCall', PropertyInspector.property_chain

    end

    def test_method_with_nested_parameters
      ENV['TM_SCOPE'] = 'source.actionscript.3'
      ENV['TM_LINE_INDEX']   = '60'
      ENV['TM_CURRENT_LINE'] = <<-EOF
      paramaterisedMethodCall( ["hello" , 'world' ], foo() )
      EOF

      assert_equal 'paramaterisedMethodCall', PropertyInspector.property_chain

    end

    def test_property_chain
      ENV['TM_SCOPE'] = 'source.actionscript.3'
      ENV['TM_CURRENT_LINE'] = <<-EOF
      one.two().three.four( TypeCast(five) )
      EOF

      ENV['TM_LINE_INDEX']   = '26'
      assert_equal 'one.two.three.four', PropertyInspector.property_chain

      ENV['TM_LINE_INDEX']   = '44'
      assert_equal 'one.two.three.four', PropertyInspector.property_chain

      ENV['TM_LINE_INDEX']   = '42'
      assert_equal 'TypeCast', PropertyInspector.property_chain

    end

    def test_as_cast
      ENV['TM_SCOPE'] = 'source.actionscript.3'
      ENV['TM_LINE_INDEX']   = '24'
      ENV['TM_CURRENT_LINE'] = <<-EOF
      ( hello as World )
      EOF

      assert_equal 'World', PropertyInspector.property_chain

    end

    def test_with_nested_casting
      ENV['TM_SCOPE'] = 'source.actionscript.3'
      ENV['TM_LINE_INDEX']   = '35'
      ENV['TM_CURRENT_LINE'] = <<-EOF
      a.big.( hello as World ).here
      EOF

      assert_equal 'a.big.World.here', PropertyInspector.property_chain

    end

    def test_with_nested_comments
      ENV['TM_SCOPE'] = 'source.actionscript.3'
      ENV['TM_LINE_INDEX']   = '54'
      ENV['TM_CURRENT_LINE'] = <<-EOF
      doSomething( /* with some (annoying) content*/ )
      EOF

      assert_equal 'doSomething', PropertyInspector.property_chain

    end

    def test_new_constructor
      ENV['TM_SCOPE'] = 'source.actionscript.3'
      ENV['TM_CURRENT_LINE'] = <<-EOF
      var e:TypicalEvent = new TypicalEvent( TypicalEvent.SAY_HELLO );
      EOF

      ENV['TM_LINE_INDEX'] = '11'
      assert_equal 'e', PropertyInspector.property_chain

      ENV['TM_LINE_INDEX'] = '69'
      assert_equal 'TypicalEvent', PropertyInspector.property_chain

      ENV['TM_LINE_INDEX'] = '58'
      assert_equal 'TypicalEvent', PropertyInspector.property_chain

      ENV['TM_LINE_INDEX'] = '67'
      assert_equal 'TypicalEvent.SAY_HELLO', PropertyInspector.property_chain

    end

    def test_multliline_method

      ENV['TM_SCOPE'] = 'source.actionscript.3'

      ENV['TM_CURRENT_LINE'] = <<-EOF
      "foo" ).here
      EOF

      ENV['TM_LINE_INDEX']   = '18'
      assert_equal '.here', PropertyInspector.property_chain

      ENV['TM_LINE_INDEX']   = '13'
      assert_equal nil, PropertyInspector.property_chain

      ENV['TM_CURRENT_LINE'] = <<-EOF
      (navigationController as NavigationController).length).
      EOF

      ENV['TM_LINE_INDEX']   = '53'
      assert_equal "NavigationController", PropertyInspector.property_chain

      ENV['TM_LINE_INDEX']   = '61'
      assert_equal nil, PropertyInspector.property_chain

    end

    def test_blank

      ENV['TM_SCOPE'] = 'source.actionscript.3'

      ENV['TM_CURRENT_LINE'] = <<-EOF

      EOF

      ENV['TM_LINE_INDEX'] = '0'
      assert_equal "this", PropertyInspector.property_chain

      ENV['TM_LINE_INDEX'] = '20'
      assert_equal "this", PropertyInspector.property_chain

      ENV['TM_LINE_INDEX'] = '40'
      assert_equal "this", PropertyInspector.property_chain

    end

    def test_no_whitespace

      ENV['TM_SCOPE'] = 'source.actionscript.3'

      ENV['TM_CURRENT_LINE'] = <<-EOF
      _menu.removeEventListener(MenuEvent,handleMenuClosed);
      EOF

      ENV['TM_LINE_INDEX'] = '12'
      assert_equal "_menu", PropertyInspector.property_chain

      ENV['TM_LINE_INDEX'] = '31'
      assert_equal "_menu.removeEventListener", PropertyInspector.property_chain

      ENV['TM_LINE_INDEX'] = '41'
      assert_equal "MenuEvent", PropertyInspector.property_chain

      ENV['TM_LINE_INDEX'] = '42'
      assert_equal nil, PropertyInspector.property_chain

      ENV['TM_LINE_INDEX'] = '58'
      assert_equal "handleMenuClosed", PropertyInspector.property_chain

      ENV['TM_LINE_INDEX'] = '59'
      assert_equal "_menu.removeEventListener", PropertyInspector.property_chain

      ENV['TM_LINE_INDEX'] = '60'
      assert_equal nil, PropertyInspector.property_chain

    end

    def test_within_array

      ENV['TM_SCOPE'] = 'source.actionscript.3'

      ENV['TM_CURRENT_LINE'] = <<-EOF
      menuHeader.filters = [FilterCollection.];
      EOF

      ENV['TM_LINE_INDEX'] = '45'
      assert_equal "FilterCollection", PropertyInspector.property_chain

    end

    # ===================
    # = is_static tests =
    # ===================

    def test_static

      ENV['TM_SCOPE'] = 'source.actionscript.3'

      ENV['TM_CURRENT_LINE'] = <<-EOF
      Math. notStatic     Math().   new Bottle().cider
      EOF

      ENV['TM_LINE_INDEX'] = '11'
      assert_equal true, PropertyInspector.is_static

      ENV['TM_LINE_INDEX'] = '10'
      assert_equal true, PropertyInspector.is_static

      ENV['TM_LINE_INDEX'] = '21'
      assert_equal false, PropertyInspector.is_static

      ENV['TM_LINE_INDEX'] = '24'
      assert_equal false, PropertyInspector.is_static

      ENV['TM_LINE_INDEX'] = '33'
      assert_equal false, PropertyInspector.is_static

      ENV['TM_LINE_INDEX'] = '31'
      assert_equal false, PropertyInspector.is_static

      ENV['TM_LINE_INDEX'] = '30'
      assert_equal true, PropertyInspector.is_static

      ENV['TM_LINE_INDEX'] = '46'
      assert_equal false, PropertyInspector.is_static

      ENV['TM_LINE_INDEX'] = '54'
      assert_equal false, PropertyInspector.is_static

    end

    # ====================
    # = insert_dot tests =
    # ====================

    def test_insert_dot

      ENV['TM_SCOPE'] = 'source.actionscript.3'

      ENV['TM_CURRENT_LINE'] = <<-EOF
      property. property
      EOF

      ENV['TM_LINE_INDEX'] = '6'
      assert_equal false, PropertyInspector.insert_dot

      ENV['TM_LINE_INDEX'] = '24'
      assert_equal true, PropertyInspector.insert_dot

      ENV['TM_LINE_INDEX'] = '15'
      assert_equal false, PropertyInspector.insert_dot

      ENV['TM_LINE_INDEX'] = '30'
      assert_equal false, PropertyInspector.insert_dot

    end

    # =================
    # = capture tests =
    # =================

    def test_captures

      ENV['TM_SCOPE'] = 'following.dot'

      ENV['TM_CURRENT_LINE'] = <<-EOF
      StaticExample.
      EOF

      ENV['TM_LINE_INDEX'] = '20'

      c = PropertyInspector.capture

      assert_equal 'StaticExample', c[:ref]
      assert_equal true, c[:is_static]
      assert_equal nil, c[:filter]
      assert_equal false, c[:insert_dot]

      ENV['TM_CURRENT_LINE'] = <<-EOF
      this.
      EOF

      ENV['TM_LINE_INDEX'] = '11'

      c = PropertyInspector.capture

      assert_equal 'this', c[:ref]
      assert_equal false, c[:is_static]
      assert_equal nil, c[:filter]
      assert_equal false, c[:insert_dot]

      ENV['TM_CURRENT_LINE'] = <<-EOF
      this.foo.
      EOF

      ENV['TM_LINE_INDEX'] = '15'

      c = PropertyInspector.capture

      assert_equal 'this.foo', c[:ref]
      assert_equal false, c[:is_static]
      assert_equal nil, c[:filter]
      assert_equal false, c[:insert_dot]

      ENV['TM_CURRENT_LINE'] = <<-EOF
      one.two.three.foo
      EOF

      ENV['TM_LINE_INDEX'] = '23'

      c = PropertyInspector.capture

      assert_equal 'one.two.three.foo', c[:ref]
      assert_equal false, c[:is_static]
      assert_equal nil, c[:filter]
      assert_equal true, c[:insert_dot]

      ENV['TM_CURRENT_LINE'] = <<-EOF
      one.(p as Two).three.
      EOF

      ENV['TM_LINE_INDEX'] = '27'

      c = PropertyInspector.capture

      assert_equal 'one.Two.three', c[:ref]
      assert_equal false, c[:is_static]
      assert_equal nil, c[:filter]
      assert_equal false, c[:insert_dot]

      ENV['TM_CURRENT_LINE'] = <<-EOF
      BigOne(one).two.foo.
      EOF

      ENV['TM_LINE_INDEX'] = '26'

      c = PropertyInspector.capture

      assert_equal 'BigOne.two.foo', c[:ref]
      assert_equal false, c[:is_static]
      assert_equal nil, c[:filter]
      assert_equal false, c[:insert_dot]

    end

    def test_captures_with_filter

      ENV['TM_SCOPE'] = 'source.actionscript.3'

      ENV['TM_CURRENT_LINE'] = <<-EOF
      StaticExample
      EOF

      ENV['TM_LINE_INDEX'] = '19'

      c = PropertyInspector.capture

      assert_equal 'StaticExample', c[:ref]
      assert_equal true, c[:is_static]
      assert_equal nil, c[:filter]
      assert_equal true, c[:insert_dot]

      ENV['TM_CURRENT_LINE'] = <<-EOF
      this
      EOF

      ENV['TM_LINE_INDEX'] = '10'

      c = PropertyInspector.capture

      assert_equal 'this', c[:ref]
      assert_equal false, c[:is_static]
      assert_equal nil, c[:filter]
      assert_equal true, c[:insert_dot]

      ENV['TM_CURRENT_LINE'] = <<-EOF
      this.test_filter
      EOF

      ENV['TM_LINE_INDEX'] = '22'

      c = PropertyInspector.capture

      assert_equal 'this', c[:ref]
      assert_equal false, c[:is_static]
      assert_equal 'test_filter', c[:filter]
      assert_equal true, c[:insert_dot]

      ENV['TM_CURRENT_LINE'] = <<-EOF
      test_filter
      EOF

      ENV['TM_LINE_INDEX'] = '17'

      c = PropertyInspector.capture

      assert_equal 'this', c[:ref]
      assert_equal false, c[:is_static]
      assert_equal 'test_filter', c[:filter]
      assert_equal true, c[:insert_dot]

      ENV['TM_CURRENT_LINE'] = <<-EOF
      one.two.three.foo
      EOF

      ENV['TM_LINE_INDEX'] = '23'

      c = PropertyInspector.capture

      assert_equal 'one.two.three', c[:ref]
      assert_equal false, c[:is_static]
      assert_equal 'foo', c[:filter]
      assert_equal true, c[:insert_dot]

      ENV['TM_CURRENT_LINE'] = <<-EOF
      one.(p as Two).three.foo
      EOF

      ENV['TM_LINE_INDEX'] = '30'

      c = PropertyInspector.capture

      assert_equal 'one.Two.three', c[:ref]
      assert_equal false, c[:is_static]
      assert_equal 'foo', c[:filter]
      assert_equal true, c[:insert_dot]

      ENV['TM_CURRENT_LINE'] = <<-EOF
      BigOne(one).two.foo
      EOF

      ENV['TM_LINE_INDEX'] = '25'

      c = PropertyInspector.capture

      assert_equal 'BigOne.two', c[:ref]
      assert_equal false, c[:is_static]
      assert_equal 'foo', c[:filter]
      assert_equal true, c[:insert_dot]

      ENV['TM_CURRENT_LINE'] = <<-EOF
      BigOne(one).two.(z as Three).(x as Four).foo
      EOF

      ENV['TM_LINE_INDEX'] = '48'

      c = PropertyInspector.capture

      assert_equal 'BigOne.two.Three.Four', c[:ref]
      assert_equal false, c[:is_static]
      assert_equal true, c[:insert_dot]

      ENV['TM_CURRENT_LINE'] = <<-EOF
      BigOne(one).two.(z as Three).(x as Four).five
      EOF

      ENV['TM_LINE_INDEX'] = '51'

      c = PropertyInspector.capture

      assert_equal 'BigOne.two.Three.Four', c[:ref]
      assert_equal false, c[:is_static]
      assert_equal true, c[:insert_dot]
      assert_equal 'five', c[:filter]

    end

    def test_static_capture

      ENV['TM_SCOPE'] = 'source.actionscript.3'
      ENV['TM_LINE_INDEX'] = '27'
      ENV['TM_CURRENT_LINE'] = <<-EOF
      StaticExample.WITH_PA
      EOF

      c = PropertyInspector.capture

      assert_equal 'StaticExample', c[:ref]
      assert_equal true, c[:is_static]
      assert_equal 'WITH_PA', c[:filter]
      assert_equal true, c[:insert_dot]

    end
end
