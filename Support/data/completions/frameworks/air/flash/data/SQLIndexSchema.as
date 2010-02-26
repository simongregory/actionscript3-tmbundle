package flash.data {
	public class SQLIndexSchema extends SQLSchema {
		public function get table():String;
		public function SQLIndexSchema(database:String, name:String, sql:String, table:String);
	}
}
