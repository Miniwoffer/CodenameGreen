package scripts {
	
	import scripts.Main;
	
	public class Quest {
		
		static public var questGotten:Boolean = false;
		static var killQuestStarted:Boolean = true;
		static public var killCounter:int = 0;
		static var randomCashReward:int = 0;

		public function Quest() {
			// constructor code
		}
		
		static public function iniQuest() {
			Main.getMain().hud.questText.text = "Please travel to the nearest space station to recieve your quest!";
		}
		
		static public function generateQuest() {
			var questNumber = int(Math.random());
			
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
				randomCashReward = int(Math.random()*250);
				Main.getMain().hud.questText.text = "Good job pilot! Thanks for getting rid of those pesky people. Here is your reward - Cash: " + String(randomCashReward) + ".";
			}
			else{
				Main.getMain().hud.questText.text = "Thanks for helping us out. Progress : " + String(killCounter) + "/20."
			}
		}
		
		static public function startGetQuest(){
			Main.getMain().hud.questText.text = "Damn it, a recent supplyship was destroyed enroute to the facility. We need someone to pick up its resources and deliver them back here. If you complete the task, we will give you a 2% cut from the total supply drop price.";
		}
		
		static public function finishGetQuest(){
			
		}

	}
	
}
