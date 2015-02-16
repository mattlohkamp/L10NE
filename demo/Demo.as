package  {
	
	import flash.display.MovieClip;
	import ml.L10NE.*;
	import flash.text.TextField;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	
	
	public class Demo extends MovieClip {
		
		public function Demo() {
			
				//	keep track of some events
			
			L10NE.addEventListener(Event.ADDED, function(e:Event):void	{	trace('dictionary added.');	});
			L10NE.addEventListener(Event.CHANGE, function(e:Event):void	{	trace('dictionary set:', L10NE.currentDictID);	});
			
				//	localize a simple string:
			
			L10NE.addDictionary(new L10NEDictionary(<dictionary id="dict1">
				<string lionid="str1">Hello, World!</string>
			</dictionary>));
			trace(L10NE.lionize('str1'));	//	returns 'Hello, World!'
			
				//	localize an entire XML node and its children:
			
			L10NE.addDictionary(new L10NEDictionary(<dictionary id="dict2">
				<node lionid="list1">
					<word content="Hello," />
					<word content="World!" />
				</node>
			</dictionary>));
			trace(L10NE.lionize('list1','dict2').toXMLString());	//	note that we're selecting the newly-added 'dict2' L10NEDictionary here
				/*	returns
						<node lionid="list1">
							<word content="Hello," />
							<word content="World!" />
						</node>	*/
						
				//	swapping dictionaries
				
			L10NE.addDictionary(new L10NEDictionary(<dictionary id="en">
				<string lionid="greet1">Good morning!</string>
			</dictionary>));
			
			L10NE.addDictionary(new L10NEDictionary(<dictionary id="de">
				<string lionid="greet1">Guten Morgen!</string>
			</dictionary>));
			
			L10NE.currentDictID = 'en';	//	localize from english dictionary by default
			
			trace(L10NE.lionize('greet1'));	//	returns 'Good morning!'
			
			L10NE.currentDictID = 'de';	//	localize from english dictionary by default
			
			trace(L10NE.lionize('greet1'));	//	returns 'Guten Morgen!'
			
				//	use external dictionary XML
				
			var xmlLoader:URLLoader = new URLLoader(new URLRequest('spanish-dictionary-example.xml'));
			xmlLoader.addEventListener(Event.COMPLETE, function(e:Event):void	{
				L10NE.addDictionary(new L10NEDictionary(XML(e.target.data)));
				L10NE.currentDictID = 'spa';
				trace(L10NE.lionize('phrase1'));	//	returns '¿Cómo está usted?'
			});
		}
	}
}