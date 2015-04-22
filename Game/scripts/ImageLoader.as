package scripts  {
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.display.Bitmap;
	import flash.display.LoaderInfo;
	import flash.events.IOErrorEvent;
	import fl.controls.List;

	public class ImageLoader {
		
		var lasteKoo:Array;
		var images:Array;
		var loader:Loader;
		public function ImageLoader() {
			lasteKoo = new Array();
			images = new Array();
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadImage);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, failedImageLoade);
		}
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
			return lasteKoo.push(url);
		}
		public function getImageRefrence(i:int):Bitmap
		{
			return images[i];
		}
		public function getImage(i:int):Bitmap
		{
			return new Bitmap(images[i][1].bitmapData);
		}
		private function failedImageLoade(e:Event):void
		{
			if(Main.getMain().debug)
				trace("ERROR:"+lasteKoo[0]+" failed to load, image might not exsist");
			
			lasteKoo.shift();
			startNext();
		}
		private function loadImage(e:Event):void
		{  
			images.push([lasteKoo[0],Bitmap(LoaderInfo(e.target).content)]);
			lasteKoo.shift();
			startNext();
			
		}
		private function startNext():void
		{
			if(lasteKoo.length > 0)
				loader.load(new URLRequest(lasteKoo[0]));
		}

	}
	
}
