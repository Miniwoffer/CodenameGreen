﻿package scripts  {
	import flash.events.Event;
	import flash.display.MovieClip;
	
	// GameObject.as er filen som sjekker kollisjoner, både når de starter å skje og når de slutter å skje. Ikke noe fancy.

	public class GameObject extends MovieClip {
		private var isInCol:Boolean = false;
		private var lastisCol:Boolean = false;
		private var otherCol:GameObject;
		public var tag:String = "GameObject";
		public var ignore:Array = new Array();
		
		public function GameObject() {
			// constructor code 
			Main.getMain().addChild(this);
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
		public function destroy(e:Event)
		{
			if(Main.getMain().contains(this))
				Main.getMain().removeChild(this);
		}
	}
	
}
