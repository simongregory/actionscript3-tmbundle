package flash.system {
	public final  class ApplicationDomain {
		public static function get currentDomain():ApplicationDomain;
		public function get parentDomain():ApplicationDomain;
		public function ApplicationDomain(parentDomain:ApplicationDomain = null);
		public function getDefinition(name:String):Object;
		public function hasDefinition(name:String):Boolean;
	}
}
