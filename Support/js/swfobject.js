/**
 * These methods have been extracted from:
 * SWFObject v1.5: Flash Player detection and embed - http://blog.deconcept.com/swfobject/
 * SWFObject is (c) 2007 Geoff Stearns and is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 */
if(typeof deconcept == "undefined") var deconcept = new Object();
if(typeof deconcept.util == "undefined") deconcept.util = new Object();
if(typeof deconcept.SWFObjectUtil == "undefined") deconcept.SWFObjectUtil = new Object();
deconcept.SWFObject = function() {}
deconcept.SWFObject.prototype = {}
deconcept.SWFObjectUtil.getPlayerVersion = function(){
	var PlayerVersion = new deconcept.PlayerVersion([0,0,0]);
	if(navigator.plugins && navigator.mimeTypes.length){
		var x = navigator.plugins["Shockwave Flash"];
		if(x && x.description) {
			PlayerVersion = new deconcept.PlayerVersion(x.description.replace(/([a-zA-Z]|\s)+/, "").replace(/(\s+r|\s+b[0-9]+)/, ".").split("."));
		}
	}
	return PlayerVersion;
}
deconcept.PlayerVersion = function(arrVersion){
	this.major = arrVersion[0] != null ? parseInt(arrVersion[0]) : 0;
	this.minor = arrVersion[1] != null ? parseInt(arrVersion[1]) : 0;
	this.rev = arrVersion[2] != null ? parseInt(arrVersion[2]) : 0;
}
deconcept.util = {}
function writeVersionToElement( theElement ){
	var version = deconcept.SWFObjectUtil.getPlayerVersion();
	if (document.getElementById && version["major"] > 0) {
		document.getElementById(theElement).innerHTML = "Flash player <code>"+ version['major'] +"."+ version['minor'] +"."+ version['rev'] +"</code> installed.";
	}
}
var SWFObject = deconcept.SWFObject;
