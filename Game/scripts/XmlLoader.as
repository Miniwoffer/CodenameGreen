package scripts {

	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	
	public class XmlLoader {
		
		//Vi lager variabler for en URLLoader som får i oppgave å laste inn dataen i en xml-fil
		static var loader:URLLoader = new URLLoader();
		loader.addEventListener(Event.COMPLETE, Ferdig);

		static var shipUrl:URLRequest = new URLRequest("content/content.xml")
		static var shipXml:XML;
		static var weaponImages:Array;
		public static var shipImages:Array;
		
		public function XmlLoader() {
			//Vi setter lytter på lasteren slik at vi vet når denne er ferdig og putter inn xml-filen
			//sin data.
			loader.load(shipUrl);
		}
		
		static private function Ferdig (evt:Event){
			shipXml = new XML(loader.data);
			
			//imgLoader = new Loader();
			//loadImages(null);
			//imgLoader.addEventListener(Event.COMPLETE, loadImages);
	    	//imgLoader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			var mymimgLoader:ImageLoader = Main.getMain().getImageLoader();
			for(var i:int = 0; i < shipXml[0].ships.children().length(); i++)
			{
				shipXml[0].ships.ship[i].imgnum = mymimgLoader.addImage("content/images/ships/" + shipXml[0].ships.ship[i].imgname);
			}
			for(var j:int = 0; j < shipXml[0].weapons.children().length(); j++)
			{
				shipXml[0].weapons.weapon[j].imgnum = mymimgLoader.addImage(shipXml[0].weapons.weapon[j].imgname);
			}
		}
		
		static public function getShipData():XML{
			return(shipXml);
		}
		
		static var imgLoader:Loader;
		static var currentImage:int = -1;
	
		static private function ioErrorHandler(e:Event)
		{
			trace("ERROR");
		}
		
		static private function loadImages(e:Event)
		{
			trace("image number " + currentImage + " loaded");
			if(currentImage < shipXml[0].ships.children().length() && currentImage > -1)
			{
				//shipXml[0].ships.ship[currentImage].image = imgLoader.content;
				shipImages.push(imgLoader.content);
			}
			else if(currentImage < (shipXml[0].ships.children().length()+shipXml[0].weapons.children().length()) && currentImage > -1)
			{
				weaponImages.push(imgLoader.content);
			}
			currentImage++;
			if(currentImage < shipXml[0].ships.children().length())
			{
				trace("content/images/ships/" + shipXml[0].ships.ship[currentImage].imgname);
				imgLoader.load(new URLRequest("content/images/ships/" + shipXml[0].ships.ship[currentImage].imgname));
			}
			else if(currentImage < (shipXml[0].ships.children().length()+shipXml[0].weapons.children().length()))
			{
				imgLoader.load(new URLRequest(shipXml[0].weapons.weapon[currentImage-shipXml[0].ships.children().length()].imgname));
			}
			else
			{
				imgLoader.removeEventListener(Event.COMPLETE, Ferdig);
			}
		}
	}
	
}
