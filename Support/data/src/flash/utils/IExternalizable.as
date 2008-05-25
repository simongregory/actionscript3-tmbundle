package flash.utils
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;

	public interface IExternalizable
	{
		public function readExternal(input:IDataInput):void;
		public function writeExternal(output:IDataOutput):void;
	}
}