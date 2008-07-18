package {
	public final  class String {
		public function get length():int;
		public function String(val:String);
		public function charAt(index:Number = 0):String;
		public function charCodeAt(index:Number = 0):Number;
		public function concat(... args):String;
		AS3 static function fromCharCode(... charCodes):String;
		public function indexOf(val:String, startIndex:Number = 0):int;
		public function lastIndexOf(val:String, startIndex:Number = 0x7FFFFFFF):int;
		public function localeCompare(other:String, ... values):int;
		), the method adds that
		 *                            empty string to the array of matches, and then continues searching at the next index position.
		 *                            The lastIndex property of the regular expression is set to 0 after the
		 *                            method completes.
		 *                            If no match is found, the method returns null. If you pass
		 *                            no value (or an undefined value) as the pattern parameter,
		 *                            the method returns null.
		 */
		public function match(pattern:*):Array;
		public function replace(pattern:*, repl:Object):String;
		public function search(pattern:*):int;
		public function slice(startIndex:Number = 0, endIndex:Number = 0x7fffffff):String;
		public function split(delimiter:*, limit:Number = 0x7fffffff):Array;
		public function substr(startIndex:Number = 0, len:Number = 0x7fffffff):String;
		public function substring(startIndex:Number = 0, endIndex:Number = 0x7fffffff):String;
		public function toLocaleLowerCase():String;
		public function toLocaleUpperCase():String;
		public function toLowerCase():String;
		public function toUpperCase():String;
		public function valueOf():String;
	}
}
