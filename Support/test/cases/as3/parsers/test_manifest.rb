#!/usr/bin/env ruby
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
require "as3/parsers/manifest"

class TestManifest < Test::Unit::TestCase

  # Not going overboard here, manifests should be machine generated. If you want
  # to break a node then reverse the id and class attributes.
  #
  def example_manifest
    '<?xml version="1.0"?>
    <componentPackage>
      <component id="ApplicationMediator" class="org.helvector.game.view.mediators.ApplicationMediator" />
      <component id="ApplicationProxy" class=\'org.helvector.game.model.proxies.ApplicationProxy\' />
      <!-- <component id="HowToPlayDialogMediator" class="org.helvector.game.view.mediators.dialogs.HowToPlayDialogMediator" /> -->
      <component id=\'InitialLoadProportions\' class="org.helvector.game.io.InitialLoadProportions" />
      <component id="LapTimes" class="org.helvector.game.view.controls.game.LapTimes" />
      <!--
      <component id="LeaderBoardEntryVO" class="org.helvector.game.model.domain.local.LeaderBoardEntryVO" />
      -->
      <component id="RaceData"
                 class="org.helvector.game.constants.RaceData" />
      <component id="RaceVO" class="org.helvector.game.model.domain.local.RaceVO" />
      <component id="RemoteServices" class="org.helvector.game.io.RemoteServices" />
      <component id="TrackingCallCommand" class="org.helvector.game.controller.TrackingCallCommand" />
      <component id="UserProxy" class="org.helvector.game.model.proxies.domain.UserProxy" />
      <component 
          
          id="CarProxy" 
          
          class="org.helvector.game.model.proxies.domain.CarProxy"
      
      />
      <component 
          
          id="WheelProxy" 
          class="org.helvector.game.model.proxies.domain.WheelProxy"
      ></component>
    </componentPackage>'
  end

  def test_find_class

  m = Manifest.new(example_manifest)

  found = m.find_class('RaceData')
  assert_equal('org.helvector.game.constants.RaceData',found)

  found = m.find_class('DummyClass')
  assert_equal(nil,found)

  found = m.find_class('ApplicationProxy')
  assert_equal('org.helvector.game.model.proxies.ApplicationProxy',found)

  found = m.find_class('WheelProxy')
  assert_equal('org.helvector.game.model.proxies.domain.WheelProxy',found)

  end

  def test_classes

    m = Manifest.new(example_manifest)
    c = m.classes

    assert_equal('ApplicationMediator', c.shift)
    assert_equal('ApplicationProxy', c.shift)
    assert_equal('InitialLoadProportions', c.shift)
    assert_equal('LapTimes', c.shift)
    assert_equal('RaceData', c.shift)
    assert_equal('RaceVO', c.shift)
    assert_equal('RemoteServices', c.shift)
    assert_equal('TrackingCallCommand', c.shift)
    assert_equal('UserProxy', c.shift)
    assert_equal('CarProxy', c.shift)
    assert_equal('WheelProxy', c.shift)

  end

end
