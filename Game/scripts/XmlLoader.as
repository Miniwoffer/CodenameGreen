package scripts {

	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	
	public class XmlLoader {
		
		//Vi lager variabler for en URLLoader som får i oppgave å laste inn dataen i en xml-fil
		 var xmlLoader:URLLoader = new URLLoader();
		 var xmlData:XML;
		
		public function XmlLoader(dir:String) {
			//Vi setter lytter på lasteren slik at vi vet når denne er ferdig og putter inn xml-filen
			//sin data.
			xmlLoader.addEventListener(Event.COMPLETE, Ferdig);
			xmlLoader.load(new URLRequest(dir));
		}
		
		private function Ferdig (evt:Event){
			
			
			xmlData = new XML(xmlLoader.data);
			var mymimgLoader:ImageLoader = Main.getMain().getImageLoader();
			
			//ber imageLoader laste in alle bilder under Ships
			for(var i:int = 0; i < xmlData[0].ships.children().length(); i++){
				xmlData[0].ships.ship[i].imgnum = mymimgLoader.addImage(String(xmlData[0].settings.imgfolders.ships) + xmlData[0].ships.ship[i].imgname);
			}
			//ber imageLoader laste in alle bilder under Weapons
			for(var j:int = 0; j < xmlData[0].weapons.children().length(); j++){
				xmlData[0].weapons.weapon[j].imgnum = mymimgLoader.addImage(String(xmlData[0].settings.imgfolders.weapons) + xmlData[0].weapons.weapon[j].imgname);
			}
		}
		
		public function getXmlData():XML{
			return(xmlData);
		}
	}
	
}
