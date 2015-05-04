package scripts
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class ShopWeaponSlot extends MovieClip
	{
		var weaponImage:Bitmap;
		var weaponId:int = -1;
		var mySSD:ShopShipDisplay;
		public function ShopWeaponSlot(ssd:ShopShipDisplay,slotid:int)
		{
			selected.visible = false;
			mySSD = ssd;
			mySSD.addChild(this);
			addEventListener(MouseEvent.CLICK,clicked);
		}
		function clicked(e:Event)
		{
			mySSD.setSelectedSlot(this);
		}
		
		public function getWeapon():int
		{
			return weaponId;
		}
		
		public function setWeapon(id:int)
		{
			weaponId = id;
			if (weaponImage != null && contains(weaponImage))
			{
				removeChild(weaponImage);
			}
			if (weaponId != -1)
			{
				var xmlData:XML = Main.getMain().getXMLLoader().getXmlData();
				xmlData = xmlData[0].weapons.weapon[weaponId];
				weaponImage = Main.getMain().getImageLoader().getImage(xmlData.imgnum);
				weaponImage.x = -weaponImage.height/2;
				weaponImage.y = -weaponImage.height/2;
				addChild(weaponImage);
			}
		}
		public function destroy()
		{
			mySSD.removeChild(this);
		}

	}

}