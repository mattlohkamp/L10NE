package ml	{
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.utils.describeType;

	public class L10NE	{
				
			//	model stuff

		private static var dictURLs:Vector.<String>;
		private static var dictXMLs:Array;
		private static var $currentDict:String = new String();
		public function get currentDict():String	{	return $currentDict;	}
		public function set currentDict(_currentDict:String):void	{
			$currentDict = (_currentDict in dictXMLs) ? dictXMLs[_currentDict] : $currentDict;
		}
		
		private static var configURL:String;
		private static var $configXML:XML;
		private static function get configXML():XML	{	return $configXML;	}
		private static function set configXML(_configXML:XML):void	{	$configXML = _configXML;	}
		
			//	init + internals
		
		public static function init(_configURL:String):void	{
			var configLoader:URLLoader = new URLLoader(new URLRequest(configURL = _configURL));
			configLoader.addEventListener(Event.COMPLETE, function(e:Event):void	{	parseConfigXML(configXML = XML(e.target.data));	});
		}
		
		private static var loadQueue:Vector.<String>;
		
		private static function parseConfigXML(_configXML:XML):void	{
			var dictCount:uint = _configXML.dictionary.length();
			dictURLs = new Vector.<String>(dictCount);
			loadQueue = new Vector.<String>(dictCount);
			dictXMLs = new Array();
			var i:uint = new uint();
			for each(var dictURL:String in _configXML.dictionary){
				dictURLs[i] = dictURL;
				loadQueue[i] = dictURL;
				var xmlRequest:URLRequest = new URLRequest(dictURL);
				var xmlURLLoader:URLLoader = new URLLoader(xmlRequest);
				xmlURLLoader.addEventListener(Event.COMPLETE, function(xmlRequest:URLRequest, dictID:String):Function {
					return function(e:Event):void {
						loadQueue.splice(loadQueue.indexOf(xmlRequest.url), 1);
						dictXMLs[dictID] = XML(e.target.data);
						if(loadQueue.length == 0){
							dictsLoaded();
						}
					}
				}(xmlRequest, _configXML.dictionary[i].@id.toString()));
				i++;
			};
		}
		
		private static function dictsLoaded():void	{
		}
		
			//	
	}	
}