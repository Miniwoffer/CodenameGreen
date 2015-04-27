package scripts  {
	
import scripts.Weapon;
import flash.display.MovieClip;
import flash.events.Event;
import flash.display.Bitmap;
	public class Bullet extends GameObject{
		var image:Bitmap;
		var projectiletype:int;
		//-Projectile-Types-
		//1 = Normal
		//2 = Laser
		var weapon:Weapon;
		var speed:Number;
		var dmg:Number;
		var target:MovieClip;
		public function Bullet(weaponid:int)
		{
			addEventListener(Event.ENTER_FRAME,enterFrame);
		}
		public function enterFrame(e:Event)
		{
			switch(speed)
			{
				case 1:
					var angle =  rotation * Math.PI / 180;
					x += speed * Math.cos(angle);
					y += speed * Math.sin(angle);
					break;
				case 2:
					x = weapon.x;
					y = weapon.y;
					rotation = weapon.rotation;
					break;
			}
		}
		override public function onCollision(other:GameObject)
		{
			super.onCollision(other);
			if(other != weapon.parent)
			{
				var otherShip = (Ship)(other);
				if(otherShip != null)
				{
					//TODO: make "boom pow sklaboosh" where they meet
					//TODO: play sounds
					otherShip.applyDmg(dmg);
					if(projectiletype == 1)
						destroy();
				}
			}
		}
		public function destroy()
		{
			removeEventListener(Event.ENTER_FRAME,enterFrame);
			parent.removeChild(this);
		}
	}
	
}
