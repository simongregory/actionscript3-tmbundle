package flash.data {
	public class SQLTableSchema extends SQLSchema {
		public function get columns():Array;
		public function SQLTableSchema(database:String, name:String, sql:String, columns:Array);
	}
}
