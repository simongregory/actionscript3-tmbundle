package {
	public final  class QName {
		public function get localName():String;
		public function get uri():String;
		public function QName(uri:Namespace, localName:QName);
		public function QName(qname:QName);
		public function toString():String;
		public function valueOf():QName;
	}
}
