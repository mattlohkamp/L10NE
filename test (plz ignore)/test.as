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
		public function test() {
			L10NE.addDictionary(new L10NEDictionary(<dictionary id="alt">
				<string lionid="str1">Hello, World</string>
			</dictionary>));
			L10NE.addDictionary(new L10NEDictionary(<dictionary id="main">
				<string lionid="str1">What up planet</string>
			</dictionary>));
			
			trace(L10NE.lionize('str1'));
		}
	}
}