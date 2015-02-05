package  {
	
	import flash.display.MovieClip;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;
	import ml.L10NE;
	import ml.Utils;
	
	public class test extends MovieClip {
		public var testCount:uint = 2;
		public function test() {
			var contentLoader:URLLoader = new URLLoader(new URLRequest('content.xml'));
			contentLoader.addEventListener(Event.COMPLETE, function(e:Event):void	{	testCountdown();	});
			//	L10NE.init('config.xml', function():void	{	testCountdown();	});
			/*
			var xml1:XML =
				<xml rootatt="a">
					<emptyNode />
					<node1>abc123</node1>
					<node2 attr="value">xyz321</node2>
					<node3 attr2="val2" />
					<parentNode attr3="vall you">
						<childNode id="1"></childNode>
						<childNode id="2"></childNode>
						<childNode id="3"></childNode>
					</parentNode>
				</xml>
			
			var xml2:XML =
				<xml rootatt="b">
					<emptyNode isEmpty="false">is no longer empty</emptyNode>
					<node1>ABC-123</node1>
					<node2 attr="different_value" isEmpty="true" />
					<node3 attr2="val2" attr="val">No Longer Empty</node3>
					<parentNode>
						<childNode id="1">a</childNode>
						<childNode>b</childNode>
						<childNode id="3">c</childNode>
					</parentNode>
				</xml>
			*/
			
			var xml1:XML =
				<xml rootatt="1"><inner><okay>yes</okay><whatever>no</whatever></inner></xml>
			
			var xml2:XML =
				<xml rootatt="2">value</xml>
			
			//trace(xml1);
			trace(ml.Utils.mergeXMLNode(xml1,xml2));
			//trace(xml1);
		}
		public function testCountdown():void	{
			if(!--testCount){	test2();	}
		}
		public function test2():void	{
			trace(L10NE.lionize('※Text1'));	//text
			trace(L10NE.lionize('※Node1'));	//xml node
		}
	}
}