package scripts {
 
	import flash.ui.Mouse;
	import flash.display.MovieClip;
 
	public class MouseHide extends MovieClip
	{
		public static var mouseToggled:Boolean = true;
 
 //Denne gjemmer musa om den står stille en liten stund, blir kalt opp fra main.as
 //Den toggler om musa er av eller på
 
		public static function mouseDownHandler() {
			if (mouseToggled){
				Mouse.hide();
			}
			else {
				Mouse.show();
				mouseToggled = !mouseToggled;
			}
			
		}
 
	}
 
}