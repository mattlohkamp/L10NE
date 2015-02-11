package ml.L10NE	{
	public class L10NEDictionary	{
		private var $id:String;		
		private var $xml:XML;
		public function get xml():XML	{	return $xml;	}
		private var $dictArray:Array = new Array();
		
		public function L10NEDictionary(_xml:XML):void	{
			$xml = _xml;
			parseXML(_xml);
		}
		
		private function parseXML(_xml:XML):void	{
			if(_xml.@id.length()){	$id = _xml.@id[0].toString();	}
			for each(var entry:XML in _xml.children()){
				var lionid:String = entry.@lionid;
				if(lionid.length){	$dictArray[lionid] = entry;	}
			}
		}
		
		public function getValueByID(lionid:String):*	{
			return $dictArray[lionid];
		}
	}
}