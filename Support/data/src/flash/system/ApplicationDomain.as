package flash.system
{
	public final class ApplicationDomain
	{
		public var currentDomain:ApplicationDomain;
		public var parentDomain:ApplicationDomain;
		public function ApplicationDomain(parentDomain:ApplicationDomain = null);
		public function getDefinition(name:String):Object;
		public function hasDefinition(name:String):Boolean;
	}
}