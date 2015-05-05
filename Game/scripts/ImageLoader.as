package scripts  {
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.display.Bitmap;
	import flash.display.LoaderInfo;
	import flash.events.IOErrorEvent;
	import fl.controls.List;

	public class ImageLoader {
		
		//en array som inholder addreser i string form som venter på å bli lastet inn
		var lasteKoo:Array;
		
		//en to dimmensjonal array som inhholder Set med Bitmap og addresen den ble lastet in fra
		var images:Array;
		var loader:Loader;
		public var done:Boolean = true;
		
		// Vi laster inn bildene og gir et error om den ikke klarer det.
		public function ImageLoader() {
			lasteKoo = new Array();
			images = new Array();
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadImage);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, failedImageLoade);
		}
		
		//Finner ut hvilke bilder som kan lastes inn fra XML-filen. Altså om den eksisterer eller ikke
		public function addImage(url:String):int{
			var eksists:int = -1;
			for(var i:int = 0; i < images.length;i++)
			{
				if(images[i][0] == url)
					eksists = i;
			}
			if(eksists >= 0)
				return eksists;
			
			startNext();
			lasteKoo.push(url)
			done = false;
			//Legger sammen køens lengde og bildenes lengde og trekker fra en siden index starter på 0
			return lasteKoo.length+images.length-1;
		}
		
		//Returnerer bilde som ligger lagra, det er viktig å ikke bruke dette til å tegne med siden dens trengs for lagrning
		public function getImageRefrence(i:int):Bitmap
		{
			return images[i];
		}
		//Returnerer et kopi av bilde
		public function getImage(i:int):Bitmap
		{
			return new Bitmap(images[i][1].bitmapData);
		}
		//en metode som blir aktivert hvis innlastningen av et blide ikke fungerer
		//vill trace feilen(hvis debug er enabla i main) og fjerne bilde fra køen
		private function failedImageLoade(e:Event):void
		{
			if(Main.getMain().debug)
				trace("ERROR:"+lasteKoo[0]+" failed to load, image might not exsist");
			
			//må ha denne så ikke en failet bilde vil hindre alt annet å fungere
			images.push([null,null]);
			lasteKoo.shift();
			startNext();
		}
		
		//legger til bilde i arrayen
		private function loadImage(e:Event):void
		{  
			if (Main.getMain().debug) trace(lasteKoo[0]+" loaded");
			images.push([lasteKoo[0],Bitmap(LoaderInfo(e.target).content)]);
			lasteKoo.shift();
			startNext();
			
		}
		
		private function startNext():void
		{
			if(lasteKoo.length > 0){
				loader.load(new URLRequest(lasteKoo[0]));
			}else done = true;
		}

	}
	
}
