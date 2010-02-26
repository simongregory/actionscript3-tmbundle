package flash.data {
	public class SQLSchema {
		public function get database():String;
		public function get name():String;
		public function get sql():String;
		public function SQLSchema(database:String, name:String, sql:String);
	}
}
