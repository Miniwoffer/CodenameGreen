package scripts {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import scripts.XmlLoader;

	public class ShopMC extends MovieClip {
		
		public function ShopMC() {
			weaponText.addEventListener(MouseEvent.CLICK, weaponSelected);
			shipText.addEventListener(MouseEvent.CLICK, shipSelected);
		}
		
		function weaponSelected(e:MouseEvent) {
			
		}
		
		function shipSelected(e:MouseEvent) {
			var xmlData = XmlLoader.getShipData();
			if(xmlData)
			{
			shipName.text = xmlData[0].ship[0].name;
			}
		}
		
	}
	
}
