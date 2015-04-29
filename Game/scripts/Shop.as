package scripts {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import scripts.XmlLoader;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import scripts.Player;

	public class Shop extends MovieClip {
		
		public var isShipSelected:Boolean = false; 
		var wepNumber = 0;
		var shipNumber = 0;
		var player:Player;
		public function setVisibility(bol:Boolean):void{
			visible = bol;
		}
		public function Shop() {
			Main.getMain().addFolowCamera(this);
			weaponText.addEventListener(MouseEvent.CLICK, weaponSelected);
			shipText.addEventListener(MouseEvent.CLICK, shipSelected);
			shipUp.addEventListener(MouseEvent.CLICK, shipCategoryUp);
			shipDown.addEventListener(MouseEvent.CLICK, shipCategoryDown);
		}
		
		function weaponSelected(e:MouseEvent) {
			//player = new Player();
			isShipSelected = false;
			var xmlData = Main.getMain().getXMLLoader().getXmlData();
			shipIcon.load(new URLRequest(xmlData.nativePath + "content/images/weapons/" + xmlData[0].weapons.weapon[wepNumber].imgname));
			addChild(shipIcon);
			// TWEEN SENERE ?
			shopInfoText1.text = "Damage:";
			shopInfoText2.text = "Projectile:";
			shopInfoText3.text = "Speed:";
			objectName.text = xmlData[0].weapons.weapon[wepNumber].name;
			shopValueText1.text = xmlData[0].weapons.weapon[wepNumber].damage;
			shopValueText2.text = xmlData[0].weapons.weapon[wepNumber].type;
			if(xmlData[0].weapons.weapon[wepNumber].speed > 200){
				shopValueText3.text = "Fast";
			}
			else if (xmlData[0].weapons.weapon[wepNumber].speed > 400){
				shopValueText3.text = "Medium";
			}
			else{
				shopValueText3.text = "Slow";
			}
		}
		
		function shipSelected(e:MouseEvent) {
			isShipSelected = true;
			var xmlData = Main.getMain().getXMLLoader().getXmlData();
			shipIcon.load(new URLRequest(xmlData.nativePath + "content/images/ships/" + xmlData[0].ships.ship[shipNumber].imgname));
			addChild(shipIcon);
			// TWEEN SENERE ?
			shopInfoText1.text = "Health:";
			shopInfoText2.text = "Armor:";
			shopInfoText3.text = "Speed:";
			objectName.text = xmlData[0].ships.ship[shipNumber].name;
			shopValueText1.text = xmlData[0].ships.ship[shipNumber].health;
			shopValueText2.text = xmlData[0].ships.ship[shipNumber].armor;
			if(xmlData[0].ships.ship[shipNumber].speed > 200){
				shopValueText3.text = "Fast";
			}
			else if (xmlData[0].ships.ship[shipNumber].speed > 400){
				shopValueText3.text = "Medium";
			}
			else{
				shopValueText3.text = "Slow";
			}
		}
		
		function shipCategoryUp (e:MouseEvent){
			var xmlData = Main.getMain().getXMLLoader().getXmlData();
			if (isShipSelected){
				if(shipNumber+1 < xmlData[0].ships.children().length()){
					shipNumber ++;
					shipSelected(null);
				}
				else
				{
					shipNumber = 0;
					shipSelected(null);
				}
			}
			else if (!isShipSelected){
				if(wepNumber+1 < xmlData[0].weapons.children().length()){
					wepNumber ++;
					weaponSelected(null);
				}
				else
				{
					wepNumber = 0;
					weaponSelected(null);
				}
			}
		}
		
		function shipCategoryDown (e:MouseEvent){
			var xmlData = Main.getMain().getXMLLoader().getXmlData();
			if (isShipSelected){
				if(shipNumber >  0){
					shipNumber --;
					shipSelected(null);
				}
				else
				{
					shipNumber = xmlData[0].ships.children().length()-1;
					shipSelected(null);
				}
			}
			else if (!isShipSelected){
				if(wepNumber >  0){
					wepNumber --;
					weaponSelected(null);
				}
				else
				{
					wepNumber = xmlData[0].weapons.children().length()-1;
					weaponSelected(null);
				}
			}
		}
	}	
}
