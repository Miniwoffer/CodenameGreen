package scripts
{

	import scripts.Weapon;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.Bitmap;

	import flash.events.TimerEvent;
	import flash.media.Sound;

	public class Bullet extends GameObject
	{
		var image:Bitmap;
		protected var weaponID:int;
		var weaponType:int;
		//-Projectile-Types-
		//0 = Normal
		//1 = Laser
		protected var weapon:Weapon;
		protected var dmg:Number;
		var target:MovieClip;
		
		//Sjekker hva slags våpen det er og størrelsen slik at vi kan sette hva slags kule det skal være + hva slags størrelse.
		public function Bullet(weaponid:int, wep:Weapon,size:Number)
		{
			super();
			weaponID = weaponid;
			var xmlData:XMLList = Main.getMain().getXMLLoader().getXmlData().weapons.weapon[weaponid].bullet;
			tag = "bullet";
			ignore.push("bullet");
			weapon = wep;
			//xmlData = xmlData[0].weapons.weapon[weaponid].bullet;
			image = Main.getMain().getImageLoader().getImage(xmlData.imgnum);
			dmg = xmlData.damage;
			image.scaleX = size;
			image.scaleY = size;
			addChild(image);

		}
		// Denne sier hva som skal skje når bullet kolliderer med noe, dersom det ikke er seg selv.
		override public function onCollision(other:GameObject)
		{
			super.onCollision(other);
			var otherShip = other as Ship;
			if (otherShip != null)
			{
				if (otherShip != weapon.parent)
				{
					otherShip.applyDmg(dmg);
					var explodo = new Explosion(weaponID,scaleX);
					explodo.x = x;
					explodo.y = y;
					destroy(null);

				}
			}
		}
		
		override public function destroy(e:Event)
		{
			super.destroy(e);

		}
	}

}