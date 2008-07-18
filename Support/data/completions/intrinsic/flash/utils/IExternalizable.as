package flash.utils {
	public interface IExternalizable {
		public function readExternal(input:IDataInput):void;
		public function writeExternal(output:IDataOutput):void;
	}
}
