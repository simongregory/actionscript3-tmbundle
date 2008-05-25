package flash.errors
{
	import flash.errors.IOError;

	public dynamic class EOFError extends IOError
	{
		public function EOFError(message:String = "");
	}
}