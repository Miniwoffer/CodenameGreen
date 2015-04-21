package scripts  {
	import flash.display.Bitmap;
	import scripts.GameObject;
	
	public class Weapon : MovieClip {
		var image:Bitmap;
		var weaponType:int;
		//-Weapon-Types-
		//1 = Projectile
		//2 = Laser
		//3 = Projectile spread?
		public var mount:WeaponMount;
		
		var bullet:Bullet;
		public function Weapon(weaponid:int) {
			bullet = new Bullet(weaponid);
			
			addChild(image);
			// constructor code
		}

	}
import scripts.Weapon;
import flash.display.MovieClip;
import flash.events.Event;

	public class Bullet : GameObject{
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
			if(other != weapon.mount.spaceShip)
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
	public class WeaponMount{
		public var spaceShip:GameObject;
	}
	
}
