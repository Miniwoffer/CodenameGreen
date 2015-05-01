package scripts  {
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.events.Event;
	import flash.display.Bitmap;
	import flash.text.TextFormatAlign;
	import flash.geom.Point;
	import scripts.Utilities;
	
	public class SpaceStation extends MovieClip {
		var dispText:TextField;
		var dispRing:Bitmap;
		public function SpaceStation(locX:int,locY:int,stationid:int) {
			dispText = new TextField();
			dispText.width = 500;
			dispText.defaultTextFormat.align = TextFormatAlign.CENTER;
			dispText.textColor = 0xFFFFFF;
			dispText.text = "Press F to enter spacestation" 
			var xmlData:XML = Main.getMain().getXMLLoader().getXmlData();
			xmlData = xmlData[0].settings.worldgen.images.stations.station[stationid];
			var image:Bitmap = Main.getMain().getImageLoader().getImage(xmlData.imgnum);
			//image.x = -image.width/2;
			addChild(image);
			addChild(dispText);
			addEventListener(Event.ENTER_FRAME,update);
			image.x = -image.width/2;
			image.y = -image.height/2;
			dispText.y = (-image.height/2)-30;
			x =locX;
			y =locY;
		}
		function update(e:Event)
		{
			
			var player:Player = Main.getMain().getPlayer();
			var playerLocation:Point = new Point(player.getShip().x,player.getShip().y);
			var myLocation:Point = new Point(x,y);
			if(Utilities.distahceTwoPoints(myLocation,playerLocation) < 200)
			{
				dispText.visible = true;  
				player.closeToShop = true;
			}
			else
			{
				dispText.visible = false;
			}
		}

	}
	
}
