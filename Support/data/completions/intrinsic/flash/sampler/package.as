package flash.sampler {
	public function clearSamples():void;
	public function getGetterInvocationCount(obj:Object, qname:QName):Number;
	public function getInvocationCount(obj:Object, qname:QName):Number;
	public function getMemberNames(o:Object, instanceNames:Boolean = false):Object;
	public function getSampleCount():Number;
	public function getSamples():Object;
	public function getSetterInvocationCount(obj:Object, qname:QName):Number;
	public function getSize(o:*):Number;
	public function isGetterSetter(obj:Object, qname:QName):Boolean;
	public function pauseSampling():void;
	public function startSampling():void;
	public function stopSampling():void;
}
