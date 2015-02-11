package ml.L10NE	{
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.utils.describeType;
	import flash.events.Event;
	import ml.Utils;

	public class L10NE	{
				
			//	model stuff

		private static var dictURLs:Vector.<String>;
		private static var dictXMLs:Array;
		private static var $currentDict:String;
		public static function get currentDict():String	{	return $currentDict;	}
		
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

						var dictObj:L10NEDictionary = new L10NEDictionary(XML(e.target.data));
						trace(dictObj);
						
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
		
		private static function getLionID(target:*):String	{	//	takes String or XML
			if(target is String){	//	then it's easy
				return String(target);
			}else if(target is XML){	//	get the lionid attribute and use that
				return XML(target).@lionid[0].toString();
			}
			return null;
		}
		
		private static function getDictionaryEntry(lionid:String):XML	{
			return dictXMLs[currentDict].children().(@lionid==lionid)[0];
		}
		
		private static function getValue(dictEntry:XML):*	{	//	returns String or XML
			switch(dictEntry.localName()){
				case 'node':
					return dictEntry;
				break;
				case 'string':
				default:
					return dictEntry.toString();
				break;
			}
			
			return null;
		}
		
		public static function lionize(target:*):*	{	//	takes String or XML, returns String or XML
			return getValue(getDictionaryEntry(getLionID(target)));
		}
	}
}