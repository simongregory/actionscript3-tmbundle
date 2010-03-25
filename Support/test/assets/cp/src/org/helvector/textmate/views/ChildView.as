package org.helvector.textmate.views {

import org.helvector.textmate.views.AbstractView;
import org.helvector.textmate.views.BasicViewInterface;

/**
 *  Concrete level dummy Class for autocompletion tests.
 */
public class ChildView
	   extends AbstractView
	   implements BasicViewInterface
{

	private static var _childPrivateStatic:String;
	private static const CHILD_PRIVATE_STATIC_CONST:Object;

	public function ChildView()
	{
		super();
		var foo:Object = {};
		this.childPrivateFuncti

	}

	private var _childPrivateVar:Array;

	protected var _childProtectedVar:String;

    public var childPublicVar:Number;

	private function childPrivateFunction():void
	{}

	protected function childProtectedFunction():void{}

	public function childPublicFunction():void{}

	private var _childAccessor:String;

	public function get childAccessor():String {}
	public function set childAccessor(value:String):void {}

}

}

