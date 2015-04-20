package scripts  {

	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.events.Event;
	
	public class XmlLoader {
		
		//Vi lager variabler for en URLLoader som får i oppgave å laste inn dataen i en xml-fil
		var loader:URLLoader = new URLLoader();
		var shipUrl:URLRequest = new URLRequest("content/ships/ships.xml")
		static var shipXml:XML = new XML();
		
		public function XmlLoader() {
			//Vi setter lytter på lasteren slik at vi vet når denne er ferdig og putter inn xml-filen
			//sin data.
			loader.addEventListener(Event.COMPLETE, Ferdig);
			loader.load(shipUrl);
		}
		
		private function Ferdig (evt:Event){
			shipXml = new XML(loader.data);
			trace(shipXml.length());
		}
		
		static public function getShipData():XML{
			return(shipXml);
		}
	}
	
}
