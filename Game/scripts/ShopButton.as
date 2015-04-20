package scripts {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.events.Event;
	import flash.text.TextField;
	
	
	public class ShopButton extends MovieClip {

		[Inspectable]
		public var Text:String;
		
		
		var textfield:TextField;
		
		var whiteColor = new ColorTransform(0xFFFFFF);
		var blackColor = new ColorTransform(0x000000);

		public function weaponText() {
			textfield = (TextField)(getChildByName("texT"));
			loaderInfo.addEventListener(Event.INIT, onInit);
			addEventListener(MouseEvent.MOUSE_OVER, wTextEnter);
			addEventListener(MouseEvent.MOUSE_OUT, wTextExit);
		}
		
		public function onInit(e:Event) {
			textfield.text = Text;
		}
		
		public function wTextEnter (e:MouseEvent){
			width += 106;
			height += 20;
			textfield.textColor = 0xDDDDDD;
		}
		
		public function wTextExit (e:MouseEvent){
			width -= 106;
			height -= 20;
			textfield.textColor = 0x000000;
		}
	}
	
}
