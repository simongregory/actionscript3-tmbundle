package
{
	public final dynamic class Date
	{
		public var date:Number;
		public var dateUTC:Number;
		public var day:Number;
		public var dayUTC:Number;
		public var fullYear:Number;
		public var fullYearUTC:Number;
		public var hours:Number;
		public var hoursUTC:Number;
		public var milliseconds:Number;
		public var millisecondsUTC:Number;
		public var minutes:Number;
		public var minutesUTC:Number;
		public var month:Number;
		public var monthUTC:Number;
		public var seconds:Number;
		public var secondsUTC:Number;
		public var time:Number;
		public var timezoneOffset:Number;
		public function Date(yearOrTimevalue:Object, month:Number, date:Number = 1, hour:Number = 0, minute:Number = 0, second:Number = 0, millisecond:Number = 0);
		public function getDate():Number;
		public function getDay():Number;
		public function getFullYear():Number;
		public function getHours():Number;
		public function getMilliseconds():Number;
		public function getMinutes():Number;
		public function getMonth():Number;
		public function getSeconds():Number;
		public function getTime():Number;
		public function getTimezoneOffset():Number;
		public function getUTCDate():Number;
		public function getUTCDay():Number;
		public function getUTCFullYear():Number;
		public function getUTCHours():Number;
		public function getUTCMilliseconds():Number;
		public function getUTCMinutes():Number;
		public function getUTCMonth():Number;
		public function getUTCSeconds():Number;
		public static function parse(date:String):Number;
		public function setDate(day:Number):Number;
		public function setFullYear(year:Number, month:Number, day:Number):Number;
		public function setHours(hour:Number, minute:Number, second:Number, millisecond:Number):Number;
		public function setMilliseconds(millisecond:Number):Number;
		public function setMinutes(minute:Number, second:Number, millisecond:Number):Number;
		public function setMonth(month:Number, day:Number):Number;
		public function setSeconds(second:Number, millisecond:Number):Number;
		public function setTime(millisecond:Number):Number;
		public function setUTCDate(day:Number):Number;
		public function setUTCFullYear(year:Number, month:Number, day:Number):Number;
		public function setUTCHours(hour:Number, minute:Number, second:Number, millisecond:Number):Number;
		public function setUTCMilliseconds(millisecond:Number):Number;
		public function setUTCMinutes(minute:Number, second:Number, millisecond:Number):Number;
		public function setUTCMonth(month:Number, day:Number):Number;
		public function setUTCSeconds(second:Number, millisecond:Number):Number;
		public function toDateString():String;
		public function toLocaleDateString():String;
		public function toLocaleString():String;
		public function toLocaleTimeString():String;
		public function toString():String;
		public function toTimeString():String;
		public function toUTCString():String;
		public static function UTC(year:Number, month:Number, date:Number = 1, hour:Number = 0, minute:Number = 0, second:Number = 0, millisecond:Number = 0):Number;
		public function valueOf():Number;
	}
}