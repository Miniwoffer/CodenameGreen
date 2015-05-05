package scripts {
	
	import scripts.Main;
	import flash.display.MovieClip;
	import flash.display.Bitmap;
	
	public class Quest {
		
		static public var questGotten:Boolean = false;
		static var killQuestStarted:Boolean = false;
		static public var killCounter:int = 0;
		static var randomCashReward:int = 0;
		static public var dropGotten:Boolean = false;
		static public var dropship:Bitmap;
		static public var lastShip:MovieClip;

		public function Quest() {
			// constructor code
		}
		
		static public function iniQuest() {
			Main.getMain().hud.questText.text = "Please travel to the nearest space station to recieve your quest!";
		}
		
		static public function generateQuest() {
			var questNumber = int(Math.round(Math.random()));
			
			if(questNumber == 0){
				startKillQuest();
			}
			else if (questNumber == 1){
				startGetQuest();
			}
		}
		
		static public function startKillQuest(){
			Main.getMain().hud.questText.text = "We need someone to thin out some of these ships! Some of this this areas residents are thinking that it is a good idea to visit other businesses. We would love to see you take out some of them. About twenty enemies should do it. If you complete it, I may just have some spacergy lying around here for you.";
			killQuestStarted = true;
		}
		
		static public function finishKillQuest(){
			if(killCounter == 20){
				killQuestStarted = false;
				questGotten = false;
				killCounter = 0;
				randomCashReward = int(Math.random()*250);
				Main.getMain().getPlayer().addMoney(randomCashReward);
				Main.getMain().hud.questText.text = "Good job pilot! Thanks for getting rid of those pesky people. Here is your reward - Spacergy: " + String(randomCashReward) + ".";
				Main.getMain().getPlayer().removeMarker(lastShip);
			}
			else{
				Main.getMain().hud.questText.text = "Thanks for helping us out, progress : " + String(killCounter) + "/20."
			}
		}
		
		static public function startGetQuest(){
			Main.getMain().hud.questText.text = "Damn it, a recent supplyship was destroyed enroute to the facility. We need someone to pick up its resources and deliver them back here. There is a reward in it for you.";
			generateDropQuest();
		}
		
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
		static public function crateFound()
		{
			dropGotten = true;
			Main.getMain().hud.questText.text = "You found it? return them to the nearest spacestation to collect your reward.";
		}
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

	}
	
}
