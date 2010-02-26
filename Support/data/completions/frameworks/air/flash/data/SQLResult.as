package flash.data {
	public class SQLResult {
		public function get complete():Boolean;
		public function get data():Array;
		public function get lastInsertRowID():Number;
		public function get rowsAffected():Number;
		public function SQLResult(data:Array = null, rowsAffected:Number = 0, complete:Boolean = true, rowID:Number = 0);
	}
}
