package scripts {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import scripts.XmlLoader;

	public class ShopMC extends MovieClip {
		
		public function ShopMC() {
			weaponText.addEventListener(MouseEvent.CLICK, weaponSelected);
			shipText.addEventListener(MouseEvent.CLICK, shipSelected);
			var xmlData = XmlLoader.getShipData();
			trace(xmlData.ships.length());
		}
		
		function weaponSelected(e:MouseEvent) {
			
		}
		
		function shipSelected(e:MouseEvent) {
			var xmlData = XmlLoader.getShipData();
			shipName.text = xmlData.ships.ship[0].name;
		}
		
	}
	
}
