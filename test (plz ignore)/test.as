package  {
	
	import flash.display.MovieClip;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;
	import ml.Utils;
	import ml.L10NE;
	
	
	public class test extends MovieClip {
		
		public function test() {
		trace(L10NE);
		L10NE.init('config.xml');
			
			/*
			var configLoader = new URLLoader(new URLRequest('config.xml'));
			configLoader.addEventListener(Event.COMPLETE, function(e:Event):void	{
				var configXML:XML = XML(e.target.data);
				for each(var textfield:XML in configXML.textField){
					trace(lionize(textfield));
				}
			});
			
			var lionLoader = new URLLoader(new URLRequest('de.xml'));
			lionLoader.addEventListener(Event.COMPLETE, function(e:Event):void	{
				var dictionaryXML:XML = XML(e.target.data);
				var textField = new TextField();
				//	textField.text = dictionaryXML.text.(@id=='A1').toString();
				addChild(textField);
			});
			*/
		}
		
		/*
		public function lionize(target:*):*	{
			var contentType:String = typeof(target);
			switch(contentType){
				case 'xml':	//	apply localized attributes to this node
					
				break;
				case 'string':	//	use localized string value
					
				break;
				default:
					throw new Error('lionize function does not support argument class "' + getQualifiedClassName(target) + '" (' + contentType + ')');
				break;
			}
			return {};
		}
		
		public function getLionByID(ID:String):XML	{
			return new XML();
		}
		
		public function lionizeString(target:String):String	{
			return new String();
		}
		
		public function lionizeXML(target:XML):XML	{
			
			return new XML();
		}
		
		*/
	}
}