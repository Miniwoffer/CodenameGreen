package scripts {
	
	// Standar importing
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import scripts.Main;
	import scripts.Player;
	import scripts.MusicScript;
	
	public class Playbutton extends SimpleButton {
		
		// Lager en lytter for når knappen trykkes på og kjører funksjoner i main-klassen
		public function Playbutton() 
		{
			addEventListener(MouseEvent.CLICK, introIsPressed);
		}
		function introIsPressed (e:MouseEvent)
		{
			if(Main.getMain().getImageLoader().done)
			{
				Main.getMain().startGame();
			}
		}
	}
	
}
