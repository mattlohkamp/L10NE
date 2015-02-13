package ml.L10NE	{
	public class L10NEDictionary	{
		
			//	data
		
		private var $id:String;
		public function get id():String	{	return $id;	}
		
		private var $xml:XML;
		public function get xml():XML	{	return $xml;	}
		
		private var $dictArray:Array = new Array();
		
			//	construct
		
		public function L10NEDictionary(_xml:XML):void	{
			$xml = _xml;
			parseXML(_xml);
		}
		
		private function parseXML(_xml:XML):void	{
			if(_xml.@id.length()){	$id = _xml.@id[0].toString();	}
			for each(var entry:XML in _xml.children()){
				var lionid:String = entry.@lionid[0].toString();
				if(lionid.length){	$dictArray[lionid] = entry;	}
			}
		}
		
			//	accessors
		
		public function getValueByID(lionid:String):*	{
			return $dictArray[lionid];
		}
	}
}