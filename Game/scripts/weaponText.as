package scripts {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.events.Event;
	
	
	public class weaponText extends MovieClip {

	//	[Inspectable]
	//	public var Text:String;
		
		var whiteColor = new ColorTransform(0xFFFFFF);
		var blackColor = new ColorTransform(0x000000);

		public function weaponText() {
			//this.addEventListener(Event.INIT, onInit);
			addEventListener(MouseEvent.MOUSE_OVER, wTextEnter);
			addEventListener(MouseEvent.MOUSE_OUT, wTextExit);

		}
		
	//	public function onInit() {
	//		this.texT.text = Text;
	//	}
		
		public function wTextEnter (e:MouseEvent){
			this.width += 106;
			this.height += 20;
			this.texT.textColor = 0xDDDDDD;
		}
		
		public function wTextExit (e:MouseEvent){
			this.width -= 106;
			this.height -= 20;
			this.texT.textColor = 0x000000;
		}
	}
	
}
