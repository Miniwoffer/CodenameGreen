package scripts {
	
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import scripts.Main;
	import scripts.Player;
	import scripts.MusicScript;
	
	public class Playbutton extends SimpleButton {
		
		
		public function Playbutton() 
		{
			addEventListener(MouseEvent.CLICK, introIsPressed);
		}
		function introIsPressed (e:MouseEvent)
		{
			Main.getMain().gotoAndStop(2);
			Main.getMain().spawnWorld();
			Main.getMain().player = new Player();
			
			MusicScript.setCurrentTrack(MusicScript.idleSound);
		}
	}
	
}
