package scripts {
 
	import flash.ui.Mouse;
	import flash.display.MovieClip;
 
	public class MouseHide extends MovieClip
	{
		public static var mouseToggled:Boolean = true;
 
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