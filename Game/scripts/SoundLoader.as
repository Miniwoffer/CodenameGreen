package scripts
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.display.LoaderInfo;
	import flash.events.IOErrorEvent;
	import fl.controls.List;
	import flash.media.Sound;

	public class SoundLoader
	{

		//en array som inholder addreser i string form som venter på å bli lastet inn
		var lasteKoo:Array;

		//en to dimmensjonal array som inhholder Set med Bitmap og addresen den ble lastet in fra
		var sounds:Array;
		var loader:Sound;

		public function SoundLoader()
		{
			lasteKoo = new Array();
			sounds = new Array();
			//loader = new Sound();
		}
		public function addSound(url:String):int
		{
			var eksists:int = -1;
			for (var i:int = 0; i < sounds.length; i++)
			{
				if (sounds[i][0] == url)
				{
					eksists = i;
				}
			}
			if (eksists >= 0)
			{
				return eksists;
			}

			lasteKoo.push(url);
			if(lasteKoo.length > 0 && loader == null)
			   startNext();
			//Legger sammen køens lengde og bildenes lengde og trekker fra en siden index starter på 0;
			return lasteKoo.length+sounds.length-1;
		}
		//Returnerer et kopi av bilde
		public function getSound(i:int):Sound
		{
			return sounds[i][1];
		}
		//en metode som blir aktivert hvis innlastningen av et blide ikke fungerer
		//vill trace feilen(hvis debug er enabla i main) og fjerne bilde fra køen
		private function failedSoundLoade(e:Event):void
		{
			if (Main.getMain().debug)
			{
				trace("ERROR:"+lasteKoo[0]+" failed to load, sound might not exsist");
			}

			//må ha denne så ikke en failet bilde vil hindre alt annet å fungere
			sounds.push([null,null]);
			lasteKoo.shift();
			startNext();
		}
		//legger til bilde i arrayen
		private function loadSound(e:Event):void
		{
			if (Main.getMain().debug) trace(lasteKoo[0]+" loaded");
			sounds.push([lasteKoo[0],loader]);
			lasteKoo.shift();
			startNext();

		}
		private function startNext():void
		{
			loader = new Sound();
			loader.addEventListener(Event.COMPLETE, loadSound);
			loader.addEventListener(IOErrorEvent.IO_ERROR, failedSoundLoade);
			if (lasteKoo.length > 0)
			{
				loader.load(new URLRequest(lasteKoo[0]));
			}

		}

	}
}