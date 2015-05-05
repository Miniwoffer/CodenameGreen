package scripts {
	
	import scripts.Main;
	import flash.display.MovieClip;
	import flash.display.Bitmap;
	
	public class Quest {
		
		//Lager statiske variabler, der noen er "public" slik at de kan bli brukt utenfra
		
		static public var questGotten:Boolean = false;
		static var killQuestStarted:Boolean = false;
		static public var killCounter:int = 0;
		static var randomCashReward:int = 0;
		static public var dropGotten:Boolean = false;
		static public var dropship:Bitmap;
		static public var lastShip:MovieClip;

		//unødvendig for det vi gjør
		public function Quest() {
			// constructor code
		}
		
		//Kjøres ved hjelp av Playbutton/startknappen. Setter quest tekstfeltet til å vise det under
		static public function iniQuest() {
			Main.getMain().hud.questText.text = "Please travel to the nearest space station to recieve your quest!";
		}
		
		
		//Henter ett tilfeldig quest, enten a eller b
		static public function generateQuest() {
			var questNumber = int(Math.round(Math.random()));
			
			if(questNumber == 0){
				startKillQuest();
			}
			else if (questNumber == 1){
				startGetQuest();
			}
		}
		
		//Dersom det tilfeldige tallet blir null, aktiverer vi killquestet og endrer tekstfelt
		static public function startKillQuest(){
			Main.getMain().hud.questText.text = "We need someone to thin out some of these ships! Some of this this areas residents are thinking that it is a good idea to visit other businesses. We would love to see you take out some of them. About twenty enemies should do it. If you complete it, I may just have some spacergy lying around here for you.";
			killQuestStarted = true;
		}
		
		//Hvis vi har drept tyve fiender (informasjonen kommer fra ship.as) avslutter den questet og resetter det. Gir også en tilfeldig sum penger og viser dette i tekstfeltet
		//Hvis ikke er questet startet, men 20 fiender er ikke nådd enda, dermed viser vi hvor langt de er.
		static public function finishKillQuest(){
			if(killCounter == 20){
				killQuestStarted = false;
				questGotten = false;
				killCounter = 0;
				randomCashReward = int(Math.random()*250);
				Main.getMain().getPlayer().addMoney(randomCashReward);
				Main.getMain().hud.questText.text = "Good job pilot! Thanks for getting rid of those pesky people. Here is your reward: " + String(randomCashReward) + ".";
				Main.getMain().getPlayer().removeMarker(lastShip);
			}
			else{
				Main.getMain().hud.questText.text = "Thanks for helping us out, progress : " + String(killCounter) + "/20."
			}
		}
		
		//Dersom det tilfeldige tallet blir en, aktiverer vi hentequestet og endrer tekstfelt
		static public function startGetQuest(){
			Main.getMain().hud.questText.text = "Damn it, a recent supplyship was destroyed enroute to the facility. We need someone to pick up its resources and deliver them back here. There is a reward in it for you.";
			generateDropQuest();
		}
		
		//Questet er startet og vi genererer et skip og en boks tilfeldig på spillområdet. 
		static public function generateDropQuest(){
			
			var xmlData = Main.getMain().getXMLLoader().getXmlData();
			
			var dropShip:Bitmap = Main.getMain().getImageLoader().getImage(xmlData[0].settings.worldgen.images.questitems.item[1].imgnum);
			Main.getMain().addChildAt(dropShip,Main.getMain().getChildIndex(Main.getMain().getPlayer().getShip())-1);
			
			dropship = dropShip;
			var questCrate:QuestCrate = new QuestCrate();
			
			var questCoordinatex = Math.random() * xmlData.settings.worldgen.mapsize;
			var questCoordinatey = Math.random() * xmlData.settings.worldgen.mapsize;
			
				questCrate.rotation = Math.random() * 360;
				dropShip.rotation = Math.random() * 360;
				
				dropShip.x = questCoordinatex;
				dropShip.y = questCoordinatey;
				
				questCrate.x = questCoordinatex + 100;
				questCrate.y = questCoordinatey + 100;
		}
		
		//Kassen er funnet, vi skal levere den til shoppen
		static public function crateFound()
		{
			dropGotten = true;
			Main.getMain().hud.questText.text = "You found it? return them to the nearest spacestation to collect your reward.";
		}
		
		//Questet leveres til shoppen og sjekker om spilleren har boksen. Hvis ja, får en penger og questet resetter seg + avsluttes
		static public function finishGetQuest(){
			if(dropGotten){
				questGotten = false;
				dropGotten = false;
				randomCashReward = int(Math.random()*500);
				Main.getMain().getPlayer().addMoney(randomCashReward);
				Main.getMain().hud.questText.text = "Good job pilot! Thank you, we owe you one after getting us those supplies, they are really important for us. Like i said, here is your Spacergy : " + String(randomCashReward) + ".";
				Main.getMain().removeChild(dropship);
				dropship = null;
			}
		}

	}
	
}
