package scripts {
	
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	
	public class Playbutton extends SimpleButton {
		
		
		public function Playbutton() 
		{
			addEventListener(MouseEvent.CLICK, introIsPressed);
		}
		function introIsPressed (e:MouseEvent)
		{
			gotoAndPlay(2);
		}
	}
	
}
