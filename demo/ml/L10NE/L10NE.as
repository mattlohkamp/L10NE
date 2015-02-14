﻿package ml.L10NE	{	//	https://github.com/mattlohkamp/L10NE	Matt Lohkamp	work@mattlohkamp.com	mattlohkamp.com/portfolio
	public class L10NE	{
				
			//	model stuff + accessors

		private static var dictionaries:Array = new Array();
		public static function getDictionaries():Array	{	return dictionaries;	}
		
		private static var $currentDictID:String;
		public static function get currentDictID():String	{	return $currentDictID;	}
		public static function set currentDictID(_currentDictID:String):void	{	$currentDictID = _currentDictID;	}
		
		public static function getDictByID(id:String):L10NEDictionary	{	return dictionaries[id];	}
		public static function getCurrentDict():L10NEDictionary	{	return getDictByID($currentDictID);	}
		
		public static function addDictionary(dictionary:L10NEDictionary):void	{
			if(!$currentDictID){	$currentDictID = dictionary.id	}
			dictionaries[dictionary.id] = dictionary;
		}
		
			//	main function
		
		public static function lionize(target:*, dictID:String = null):*	{	//	takes String or XML, returns String or XML
			return getValue(getDictionaryEntry(getLionID(target),dictID));
		}
		
			// internal dictionary interaction
		
		private static function getLionID(target:*):String	{	//	takes String or XML
			if(target is String){	//	then it's easy
				return String(target);
			}else if(target is XML){	//	get the lionid attribute and use that
				return XML(target).@lionid[0].toString();
			}
			return null;
		}
		
		private static function getDictionaryEntry(lionid:String, dictID:String = null):XML	{
			if(dictID){
				return getDictByID(dictID).getValueByID(lionid)[0];
			}
			return getCurrentDict().getValueByID(lionid)[0];
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
	}
}