package scripts  {
	import scripts.Bullet;
	import scripts.Weapon;
	import scripts.GameObject;
	import scripts.Main;
	import scripts.Ship;
	import scripts.Explosion;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	public class Projectile extends Bullet {
		var speed:Number;
		var deathTimer:Timer;
		var explodeOnDeath:Boolean;
		public function Projectile(weaponid:int,wep:Weapon,size:Number) {
			super(weaponid,wep,size);
			var xmlData:XMLList = Main.getMain().getXMLLoader().getXmlData().weapons.weapon[weaponid].bullet;
			
			speed = xmlData.speed;
			explodeOnDeath = false;
			if(xmlData.explodeondeath == "true")
				explodeOnDeath = true;
			
			deathTimer = new Timer(xmlData.lifetime,1);
			deathTimer.addEventListener(TimerEvent.TIMER_COMPLETE,destroy);
			deathTimer.start();

		}

		override public function onCollision(other:GameObject)
		{
			super.onCollision(other);
			var otherShip = other as Ship;
			if (otherShip != null)
			{
				if (otherShip != weapon.parent)
				{

					otherShip.applyDmg(dmg);
					if(!explodeOnDeath)
					{
					var explodo = new Explosion(weaponID,scaleX);
					explodo.x = x;
					explodo.y = y;
					}
					destroy(null);

				}
			}
		}
		override public function update(e:Event){
			if(!Main.getMain().gamepaused){
			if(!deathTimer.running)
				deathTimer.start();
			super.update(e);
			var angle = rotation * Math.PI / 180;
			x +=  speed * Math.cos(angle);
			y +=  speed * Math.sin(angle);
			}else
			{
				if(deathTimer.running)
					deathTimer.stop();
			}
		}
		override public function destroy(e:Event)
		{
			if(explodeOnDeath)
			{
					var explodo = new Explosion(weaponID,scaleX);
					explodo.x = x;
					explodo.y = y;
			}
			super.destroy(e);
			deathTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,destroy);
		}

	}
	
}
