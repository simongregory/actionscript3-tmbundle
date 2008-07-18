package flash.utils {
	public class Proxy {
		flash_proxy function callProperty(name:*, ... rest):*;
		flash_proxy function deleteProperty(name:*):Boolean;
		flash_proxy function getDescendants(name:*):*;
		flash_proxy function getProperty(name:*):*;
		flash_proxy function hasProperty(name:*):Boolean;
		flash_proxy function isAttribute(name:*):Boolean;
		flash_proxy function nextName(index:int):String;
		flash_proxy function nextNameIndex(index:int):int;
		flash_proxy function nextValue(index:int):*;
		flash_proxy function setProperty(name:*, value:*):void;
	}
}
