#!/usr/bin/env ruby
# encoding: utf-8

################################################################################
#
#   Copyright 2009 Simon Gregory
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

# Utility class for working with ActionScript manifest files.
#
class Manifest
  def initialize(doc)
    #require 'rexml/document'
    @doc = doc
  end
  
  def find_class(c)
    
    rgx = /<component\s+id="(#{c})"\s+class="([\w.]+)"/
    res = []
    res = @doc.scan(rgx)
    res
    
  end
  
  def classes
    rgx = /<component\s+id="(\w+)"\s+class="([\w.]+)"/
    cls = []
    @doc.each { |line|  cls << $1 if line =~ rgx }
    cls
  end
  
end

if __FILE__ == $0
  
  manifest = '<?xml version="1.0"?>
<componentPackage>
  <component id="ApplicationMediator" class="org.helvector.game.view.mediators.ApplicationMediator" />
  <component id="ApplicationProxy" class="org.helvector.game.model.proxies.ApplicationProxy" />
  <component id="BackButton" class="org.helvector.game.view.controls.BackButton" />
  <component id="BaseGame" class="org.helvector.game.gametype.BaseGame" />
  <component id="BaseMediator" class="org.helvector.game.view.mediators.BaseMediator" />
  <component id="CSSToTextFormatUtil" class="org.helvector.game.utils.CSSToTextFormatUtil" />
  <component id="CarProduct" class="org.helvector.game.model.structure.CarProduct" />
  <component id="FooterView" class="org.helvector.game.view.components.FooterView" />
  <component id="GtiButtonDownFilter" class="org.helvector.game.view.controls.filters.GtiButtonDownFilter" />
  <component id="HowToPlayDialogMediator" class="org.helvector.game.view.mediators.dialogs.HowToPlayDialogMediator" />
  <component id="InitialLoadProportions" class="org.helvector.game.io.InitialLoadProportions" />
  <component id="IntroPageViewEvent" class="org.helvector.game.view.events.IntroPageViewEvent" />
  <component id="InviteFriendsDelegateProxy" class="org.helvector.game.model.proxies.domain.InviteFriendsDelegateProxy" />
  <component id="InviteFriendsDialogViewEvent" class="org.helvector.game.events.InviteFriendsDialogViewEvent" />
  <component id="JoinLeagueDialogEvent" class="org.helvector.game.view.events.JoinLeagueDialogEvent" />
  <component id="LapTimes" class="org.helvector.game.view.controls.game.LapTimes" />
  <component id="LeaderBoardEntryVO" class="org.helvector.game.model.domain.local.LeaderBoardEntryVO" />
  <component id="LeaderBoardTableView" class="org.helvector.game.view.controls.LeaderBoardTableView" />
  <component id="LeaveRaceDialogStructure" class="org.helvector.game.model.structure.dialogs.LeaveRaceDialogStructure" />
  <component id="PageIdToViewMap" class="org.helvector.game.maps.PageIdToViewMap" />
  <component id="PageIds" class="org.helvector.game.constants.PageIds" />
  <component id="PreRacePageProxy" class="org.helvector.game.model.proxies.PreRacePageProxy" />
  <component id="QualifiedTime" class="org.helvector.game.constants.QualifiedTime" />
  <component id="RaceCompleteEvent" class="org.helvector.game.view.events.RaceCompleteEvent" />
  <component id="RaceData" class="org.helvector.game.constants.RaceData" />
  <component id="RaceVO" class="org.helvector.game.model.domain.local.RaceVO" />
  <component id="RemoteServices" class="org.helvector.game.io.RemoteServices" />
  <component id="RemotingErrors" class="org.helvector.game.io.remoting.RemotingErrors" />
  <component id="Sizing" class="org.helvector.game.constants.Sizing" />
  <component id="SoundActions" class="org.helvector.game.constants.SoundActions" />
  <component id="SoundControlCommand" class="org.helvector.game.controller.SoundControlCommand" />
  <component id="SpeedEvent" class="org.helvector.game.events.SpeedEvent" />
  <component id="TimeFormatter" class="org.helvector.game.utils.TimeFormatter" />
  <component id="Tracking" class="org.helvector.game.constants.Tracking" />
  <component id="TrackingCallCommand" class="org.helvector.game.controller.TrackingCallCommand" />
  <component id="UserProxy" class="org.helvector.game.model.proxies.domain.UserProxy" />
  <component id="UserVO" class="org.helvector.game.model.domain.local.UserVO" />
</componentPackage>'
  
   m = Manifest.new(manifest)
   puts m.find_class('RaceData')[0][1]
   puts m.find_class('Sizing')[0][1]
   puts m.classes
end
