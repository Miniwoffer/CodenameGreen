package scripts {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import scripts.XmlLoader;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import scripts.Player;
	import flash.display.Bitmap;
	import scripts.Main;
	import scripts.ShopShipDisplay;
	import scripts.Quest;
	import flash.events.Event;

	public class Shop extends MovieClip {
		
		//setter opp variabler
		
		public var isShipSelected:Boolean = false; 
		var wepNumber = 0;
		var shipNumber = 0;
		var player:Player;
		
		
		
		var ssd:ShopShipDisplay;// O_O so fast---------
		
		
		//Setter synligheten til shoppen, samt kaller opp at spillet skal pauses om den er oppe
		public function setVisibility(bol:Boolean):void{
			visible = bol;
			Main.getMain().gamepaused = bol;
			parent.setChildIndex(this,parent.numChildren-1);
		}
		
		// Vi gir tekstfeltene lyttere, slik at de kan bli trukket på, samt setter teksten inn i tekstfeltene.
		public function Shop() {
			ssd = new ShopShipDisplay();
			addChild(ssd);
			var main:Main = Main.getMain();
			var xmldata:XML = main.getXMLLoader().getXmlData()
			
			weaponText.addEventListener(MouseEvent.CLICK, weaponSelected);
			shipText.addEventListener(MouseEvent.CLICK, shipSelected);
			SelectButton.addEventListener(MouseEvent.CLICK, select);
			exitButton.addEventListener(MouseEvent.CLICK, exit);
			buyButton.addEventListener(MouseEvent.CLICK, buy);
			questButton.addEventListener(MouseEvent.CLICK, getQuest);
			shipUp.addEventListener(MouseEvent.CLICK, shipCategoryUp);
			shipDown.addEventListener(MouseEvent.CLICK, shipCategoryDown);
			
			
			exitButton.Text = "Exit";
			exitButton.updateText();/**/
			
			SelectButton.Text = "Select";
			SelectButton.updateText();
			
			weaponText.Text = "Weapons";
			weaponText.updateText();
			
			shipText.Text = "Ships";
			shipText.updateText();
			
			buyButton.Text = "Buy";
			buyButton.updateText();
			
			
		}
		
		//Sjekker om spilleren allerede har fått et quest, om de har det skal de ikke få ett nytt. Kaller genererquest funksjonen slik at questet blir generert.
		function getQuest(e:MouseEvent){
			if (!Quest.questGotten){
				Quest.generateQuest();
				Quest.questGotten = true;
			}
		}
		
		// Hvis spiller har nok penger til å kjøpe, så fjerner vi pengene fra kontoen og gir dem det de skal ha + legger ned butikkvinduet
		function buy(e:Event)
		{
			if(Main.getMain().getPlayer().playerCurrency >= ssd.getPrice())
			{
				Main.getMain().getPlayer().removeMoney(ssd.getPrice());
				var arr:Array = new Array();
				var ship:int = ssd.getShipAndWeapons(arr);
				Main.getMain().getPlayer().setShip(ship,arr);
				setVisibility(false);
			}
		}
		//Vi får ut av shoppen
		function exit(e:Event)
		{
			setVisibility(false);
		}
		
		//Ser etter hva som er valgt/ lagt i "handlekurven", putter prisen inn i kost tekstfeltet
		function select(e:Event)
		{
			if(isShipSelected)
			{
				ssd.setShip(shipNumber);
				
			}
			else
			{
				ssd.setWeaponAtCurrentSlot(wepNumber);
			}
			
			cost.text = "Price: " + String(ssd.getPrice());
				
		}
		
		//Sjekker hvilket våpen som er valgt og deretter setter inn riktig informasjon i tekstboksene, samt loader inn bildet av gjennstanden
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
			shopInfoText4.text = "Price:";
			
			objectName.text = xmlData[0].weapons.weapon[wepNumber].name;
			shopValueText1.text = xmlData[0].weapons.weapon[wepNumber].damage;
			shopValueText2.text = xmlData[0].weapons.weapon[wepNumber].type;
			shopValueText4.text = xmlData[0].weapons.weapon[wepNumber].price;
			
			if(xmlData[0].weapons.weapon[wepNumber].speed > 200){
				shopValueText3.text = "Slow";
			}
			else if (xmlData[0].weapons.weapon[wepNumber].speed > 400){
				shopValueText3.text = "Medium";
			}
			else{
				
				shopValueText3.text = "Fast";
			}
		}
		//Sjekker hvilket skip som er valgt og deretter setter inn riktig informasjon i tekstboksene, samt loader inn bildet av gjennstanden
		function shipSelected(e:MouseEvent) {
			isShipSelected = true;
			var xmlData = Main.getMain().getXMLLoader().getXmlData();
			shipIcon.load(new URLRequest(xmlData.nativePath + "content/images/ships/" + xmlData[0].ships.ship[shipNumber].imgname));
			addChild(shipIcon);
			// TWEEN SENERE ?
			shopInfoText1.text = "Health:";
			shopInfoText2.text = "Armor:";
			shopInfoText3.text = "Speed:";
			shopInfoText4.text = "Price:";
			objectName.text = xmlData[0].ships.ship[shipNumber].name;
			shopValueText1.text = xmlData[0].ships.ship[shipNumber].health;
			shopValueText2.text = xmlData[0].ships.ship[shipNumber].armor;
			shopValueText4.text = xmlData[0].ships.ship[shipNumber].price;
			
			if(xmlData[0].ships.ship[shipNumber].speed > 4){
				shopValueText3.text = "Fast";
			}
			else if (xmlData[0].ships.ship[shipNumber].speed > 2){
				shopValueText3.text = "Medium";
			}
			else{
				shopValueText3.text = "Slow";
			}
			
		}
		
		//Her fikser vi skrolle funksjonen i menyen. Dersom vi er på skip-delen kan vi skrolle innenfor den, hvis ikke skroller vi igjennom våpenene.
		//Denne er for å skrolle opp
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
		//Denne er for å skrolle ned
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
