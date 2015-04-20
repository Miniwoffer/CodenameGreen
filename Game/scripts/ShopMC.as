package scripts {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import scripts.XmlLoader;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class ShopMC extends MovieClip {
		
		public var isShipSelected:Boolean = false; 
		
		var shipNumber = 0;
		
		public function ShopMC() {
			weaponText.addEventListener(MouseEvent.CLICK, weaponSelected);
			shipText.addEventListener(MouseEvent.CLICK, shipSelected);
			shipUp.addEventListener(MouseEvent.CLICK, shipCategoryUp);
			shipDown.addEventListener(MouseEvent.CLICK, shipCategoryDown);
		}
		
		function weaponSelected(e:MouseEvent) {
			isShipSelected = false;
		}
		
		function shipSelected(e:MouseEvent) {
			isShipSelected = true;
			
			var xmlData = XmlLoader.getShipData();
			shipIcon.load(new URLRequest(xmlData.nativePath + "content/ships/images/" + xmlData[0].ship[shipNumber].imgname));
			addChild(shipIcon);
			// TWEEN SENERE ?
			healthValue.text = xmlData[0].ship[shipNumber].health
			armorValue.text = xmlData[0].ship[shipNumber].armor
			speedValue.text = xmlData[0].ship[shipNumber].speed
		}
		
		function shipCategoryUp (e:MouseEvent){
			if (isShipSelected){
				var xmlData = XmlLoader.getShipData();
				
				if(shipNumber <= xmlData[0].ship.length){
					shipNumber ++;
					shipSelected(null);
				}
			}
		}
		
		function shipCategoryDown (e:MouseEvent){
			if (isShipSelected){
				if(shipNumber >  0){
					shipNumber --;
					shipSelected(null);
				}
			}
		}
	}
	
}
