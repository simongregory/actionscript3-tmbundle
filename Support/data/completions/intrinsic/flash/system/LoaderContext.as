package flash.system {
	public class LoaderContext {
		public var applicationDomain:ApplicationDomain = null;
		public var checkPolicyFile:Boolean = false;
		public var securityDomain:SecurityDomain = null;
		public function LoaderContext(checkPolicyFile:Boolean = false, applicationDomain:ApplicationDomain = null, securityDomain:SecurityDomain = null);
	}
}
