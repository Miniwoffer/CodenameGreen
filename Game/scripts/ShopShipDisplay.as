package scripts  {
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Shape;
	
	public class ShopShipDisplay extends MovieClip {
		private static const WIDTH:int = 500;
		
		var selectedSlot:int = 0;
		
		var currentShip:int = 0;
		
		var slots:Array = new Array;
		var shipImage:Bitmap;
		
		public function setSelectedSlot(slot:ShopWeaponSlot)
		{
			slots[selectedSlot].selected.visible = false;
			for(var i:int = 0; i < slots.length; i++)
			{
				if(slots[i] == slot){
					selectedSlot = i;
					slots[selectedSlot].selected.visible = true;
				}
			}
		}
		public function getPrice():int
		{
			var xmlData:XML = Main.getMain().getXMLLoader().getXmlData();
			xmlData = xmlData[0].ships.ship[currentShip];
			var price:int =  xmlData[0].ships.ship[currentShip].price;
			
			return price;
		}
		public function ShopShipDisplay() {
			// constructor code
		}
		
		public function setShip(id:int)
		{
			currentShip = id;
			updateShip();
		}
		public function setWeaponAtCurrentSlot(id:int)
		{
			if(slots[selectedSlot] != null)
				slots[selectedSlot].setWeapon(id);
		}
		function updateShip()
		{
			
			if(shipImage != null && contains(shipImage)){
				removeChild(shipImage);
			}
			for(var i:int = 0; i < slots.length; i++)
			{
				removeChild(slots[i]);
			}
			slots = new Array();
			var xmlData:XML = Main.getMain().getXMLLoader().getXmlData();
			xmlData = xmlData[0].ships.ship[currentShip];
			shipImage = Main.getMain().getImageLoader().getImage(xmlData.imgnum);
			addChild(shipImage);
			shipImage.x = -shipImage.width/2;
			shipImage.y = -shipImage.height/2;
			for( i = 0; i < xmlData.mounts.children().length(); i++)
			{
				var slot:ShopWeaponSlot = new ShopWeaponSlot(this,i);
				slot.scaleX = xmlData.mounts.mount[i].size;
				slot.scaleY = xmlData.mounts.mount[i].size;
				slot.x = xmlData.mounts.mount[i].x;
				slot.y = xmlData.mounts.mount[i].y;
				slots.push(slot);
			}
			width = WIDTH;
			scaleY = scaleX;
			y = 0;
			x = 100;
			rotation = -90;
			
		}

	}
	
}
