package scripts {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.events.Event;
	
	
	public class shipText extends MovieClip {

	//	[Inspectable]
	//	public var Text:String;
		
		var whiteColor = new ColorTransform(0xFFFFFF);
		var blackColor = new ColorTransform(0x000000);

		public function shipText() {
			//this.addEventListener(Event.INIT, onInit);
			addEventListener(MouseEvent.MOUSE_OVER, sTextEnter);
			addEventListener(MouseEvent.MOUSE_OUT, sTextExit);

		}
		
	//	public function onInit() {
	//		this.texT.text = Text;
	//	}
		
		public function sTextEnter (e:MouseEvent){
			this.width += 106;
			this.height += 20;
			this.texT.textColor = 0xDDDDDD;
		}
		
		public function sTextExit (e:MouseEvent){
			this.width -= 106;
			this.height -= 20;
			this.texT.textColor = 0x000000;
		}
	}
	
}
