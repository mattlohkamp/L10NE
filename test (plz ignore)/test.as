package  {
	
	import flash.display.MovieClip;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;
	import ml.L10NE.*;
	import ml.Utils;
	
	public class test extends MovieClip {
		public var testCount:uint = 2;
		public function test() {
			var contentLoader:URLLoader = new URLLoader(new URLRequest('content.xml'));
			contentLoader.addEventListener(Event.COMPLETE, function(e:Event):void	{	testCountdown();	});
			L10NE.init('config.xml', function():void	{	testCountdown();	});
		}
		public function testCountdown():void	{
			if(!--testCount){	test2();	}
		}
		public function test2():void	{
			//trace(L10NE.lionize('※Text1'));	//text
			//trace(L10NE.lionize(<xmlNode lionid="※Node1" repeat="0"><![CDATA[]]></xmlNode>));	//xml node
		}
	}
}