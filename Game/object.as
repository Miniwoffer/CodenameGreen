package  {
	
	import flash.display.MovieClip;
	import scripts.GameObject;
	
	public class object extends GameObject {
		
		
		public function object() {
			// constructor code
		}
		override public function onCollision(other:GameObject)
		{
			super.onCollision(other);
			trace("wobalobadudu");
		}
	}
	
}
