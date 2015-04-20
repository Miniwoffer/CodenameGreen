package scripts {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import scripts.XmlLoader;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class ShopMC extends MovieClip {
		
		public function ShopMC() {
			weaponText.addEventListener(MouseEvent.CLICK, weaponSelected);
			shipText.addEventListener(MouseEvent.CLICK, shipSelected);
		}
		
		function weaponSelected(e:MouseEvent) {
			
		}
		
		function shipSelected(e:MouseEvent) {
			var i = 0;
			
			var xmlData = XmlLoader.getShipData();
			shipIcon.load(new URLRequest(xmlData.nativePath + "content/ships/images/" + xmlData[0].ship[i].imgname));
			addChild(shipIcon);
			// TWEEN SENERE ?
			healthValue.text = xmlData[0].ship[i].health
			armorValue.text = xmlData[0].ship[i].armor
			speedValue.text = xmlData[0].ship[i].speed
			sizeValue.text = xmlData[0].ship[0].size
		}
		
	}
	
}
