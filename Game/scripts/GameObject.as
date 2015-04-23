package scripts  {
	import flash.events.Event;
	import flash.display.MovieClip;

	public class GameObject extends MovieClip {
		private var isInCol:Boolean = false;
		private var lastisCol:Boolean = false;
		private var otherCol:GameObject;
		
		public function GameObject() {
			// constructor code
			addEventListener(Event.ENTER_FRAME,update);
		}
		
		
		//Gets called each fram, its immportatnt to use super.framEnter() if you override this.
		public function update(e:Event){
			if(lastisCol == false && isInCol == true)
				onExitCollision(otherCol);
			lastisCol = false;
		}
		public function onCollision(other:GameObject){
			if(!isInCol)
			{
				onEnterCollision(other);
				otherCol = other;
				isInCol = true;
			}
			lastisCol = true;
		}
		public function onEnterCollision(other:GameObject){
			
		}
		public function onExitCollision(other:GameObject){
			
		}
	}
	
}
