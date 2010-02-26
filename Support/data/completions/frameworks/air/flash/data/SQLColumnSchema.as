package flash.data {
	public class SQLColumnSchema {
		public function get allowNull():Boolean;
		public function get autoIncrement():Boolean;
		public function get dataType():String;
		public function get defaultCollationType():String;
		public function get name():String;
		public function get primaryKey():Boolean;
		public function SQLColumnSchema(name:String, primaryKey:Boolean, allowNull:Boolean, autoIncrement:Boolean, dataType:String, defaultCollationType:String);
	}
}
