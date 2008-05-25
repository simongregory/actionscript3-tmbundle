package flash.net
{
	import flash.net.IDynamicPropertyOutput;

	public interface IDynamicPropertyWriter
	{
		public function writeDynamicProperties(obj:Object, output:IDynamicPropertyOutput):void;
	}
}