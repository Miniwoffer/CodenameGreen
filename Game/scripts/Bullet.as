package scripts
{

	import scripts.Weapon;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.Bitmap;
	import flash.utils.Timer;
	import flash.events.TimerEvent;

	public class Bullet extends GameObject
	{
		var image:Bitmap;
		var weaponType:int;
		//-Projectile-Types-
		//0 = Normal
		//1 = Laser
		var weapon:Weapon;
		var speed:Number;
		var dmg:Number;
		var target:MovieClip;
		var deathTimer:Timer;
		public function Bullet(weaponid:int, wep:Weapon,size:Number)
		{
			Main.getMain().addChild(this);
			var xmlData:XMLList = Main.getMain().getXMLLoader().getXmlData().weapons.weapon[weaponid].bullet;
			tag = "bullet";
			ignore.push("bullet");
			weapon = wep;
			//xmlData = xmlData[0].weapons.weapon[weaponid].bullet;
			image = Main.getMain().getImageLoader().getImage(xmlData.imgnum);
			speed = xmlData.speed;
			dmg = xmlData.damage;
			image.scaleX = size;
			image.scaleY = size;
			addChild(image);
			addEventListener(Event.ENTER_FRAME,enterFrame);
			deathTimer = new Timer(xmlData.lifetime,1);
			deathTimer.addEventListener(TimerEvent.TIMER_COMPLETE,destroy);
			deathTimer.start();

		}
		public function enterFrame(e:Event)
		{
			var angle = rotation * Math.PI / 180;
			x +=  speed * Math.cos(angle);
			y +=  speed * Math.sin(angle);
		}
		override public function onCollision(other:GameObject)
		{
			super.onCollision(other);
			var otherShip = other as Ship;
			if (otherShip != null)
			{
				if (otherShip != weapon.parent)
				{
					//TODO: make "boom pow sklaboosh" where they meet
					//TODO: play sounds
					otherShip.applyDmg(dmg);
					destroy(null);

				}
			}
		}
		override public function destroy(e:Event)
		{
			super.destroy(e);
			deathTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,destroy);
			Main.getMain().removeChild(this);
		}
	}

}