package scripts
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;

	public class AnimatedBitmap extends Bitmap
	{
		var currentFrame:int;
		var tileMap:BitmapData;
		var tileWidth:int;
		var frames:int;
		public function AnimatedBitmap(numFrames:int,tileMap:BitmapData)
		{
			// constructor code
		}
		public function nextFrame()
		{
			currentFrame++;
			updateBitmapData();
		}
		public function prevFrame()
		{
			currentFrame--;
			updateBitmapData();
		}
		function updateBitmapData()
		{
			bitmapData.setPixels(bitmapData.rect,tileMap.getPixels(new Rectangle(0,tileWidth*currentFrame,tileWidth,tileMap.height)));
		}

	}

}