package scripts {

	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.events.Event;
	
	public class XmlLoader {
		
		//Vi lager variabler for en URLLoader som får i oppgave å laste inn dataen i en xml-fil
		static var loader:URLLoader = new URLLoader();
		loader.addEventListener(Event.COMPLETE, Ferdig);

		static var shipUrl:URLRequest = new URLRequest("content/content.xml")
		static var shipXml:XML;
		
		public function XmlLoader() {
			//Vi setter lytter på lasteren slik at vi vet når denne er ferdig og putter inn xml-filen
			//sin data.
			loader.load(shipUrl);
		}
		
		static private function Ferdig (evt:Event){
			shipXml = new XML(loader.data);
		}
		
		static public function getShipData():XML{
			return(shipXml);
		}
	}
	
}
