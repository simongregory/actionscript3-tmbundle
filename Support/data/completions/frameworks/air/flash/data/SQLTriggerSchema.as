package flash.data {
	public class SQLTriggerSchema extends SQLSchema {
		public function get table():String;
		public function SQLTriggerSchema(database:String, name:String, sql:String, table:String);
	}
}
