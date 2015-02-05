package ml	{
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.utils.describeType;
	import flash.events.Event;

	public class L10NE	{
				
			//	model stuff

		private static var dictURLs:Vector.<String>;
		private static var dictXMLs:Array;
		private static var $currentDict:String;
		public static function get currentDict():String	{	return $currentDict;	}
		
		private static var configURL:String;
		private static var $configXML:XML;
		private static function get configXML():XML	{	return $configXML;	}
		private static function set configXML(_configXML:XML):void	{	$configXML = _configXML;	}
		
		private static var onDictsLoaded:Function = function():void	{};
		
			//	init + internals
		
		public static function init(_configURL:String, _onDictsLoaded:Function = null):void	{
			onDictsLoaded = (_onDictsLoaded is Function) ? _onDictsLoaded : onDictsLoaded;
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
				xmlURLLoader.addEventListener(Event.COMPLETE, function(xmlRequest:URLRequest, dictNode:XML):Function {
					return function(e:Event):void {
						var dictID:String = dictNode.@id.toString();
						loadQueue.splice(loadQueue.indexOf(xmlRequest.url), 1);
						dictXMLs[dictID] = XML(e.target.data);
						if(!!dictNode.@active.toString()){	$currentDict = dictID;	}
						if(loadQueue.length == 0){	dictsLoaded();	}
					}
				}(xmlRequest, _configXML.dictionary[i]));
				i++;
			}
		}
		
		private static function dictsLoaded():void	{
			onDictsLoaded();
		}
		
		public static function lionize(lionid:String):*	{
			return dictXMLs[currentDict].entry.(@id==lionid).toString();
		}
	}
}