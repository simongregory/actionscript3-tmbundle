package flash.data {
	public class SQLSchemaResult {
		public function get indices():Array;
		public function get tables():Array;
		public function get triggers():Array;
		public function get views():Array;
		public function SQLSchemaResult(tables:Array, views:Array, indices:Array, triggers:Array);
	}
}
