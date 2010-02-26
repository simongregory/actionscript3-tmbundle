package flash.security {
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	public class XMLSignatureValidator extends EventDispatcher {
		public function get digestStatus():String;
		public function get identityStatus():String;
		public function get referencesStatus():String;
		public function get revocationCheckSetting():String;
		public function set revocationCheckSetting(value:String):void;
		public function get signerCN():String;
		public function get signerDN():String;
		public function get signerExtendedKeyUsages():Array;
		public function get signerTrustSettings():Array;
		public function get uriDereferencer():IURIDereferencer;
		public function set uriDereferencer(value:IURIDereferencer):void;
		public function get useSystemTrustStore():Boolean;
		public function set useSystemTrustStore(value:Boolean):void;
		public function get validityStatus():String;
		public function XMLSignatureValidator();
		public function addCertificate(cert:ByteArray, trusted:Boolean):*;
		public function verify(signature:XML):void;
	}
}
