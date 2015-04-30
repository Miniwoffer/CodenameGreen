package scripts  {
	
import scripts.Weapon;
import flash.display.MovieClip;
import flash.events.Event;
import flash.display.Bitmap;
	public class Bullet extends GameObject{	
		var image:Bitmap;
		var weaponType:int;
		//-Projectile-Types-
		//0 = Normal
		//1 = Laser
		var weapon:Weapon;
		var speed:Number;
		var dmg:Number;	
		var target:MovieClip;
		public function Bullet(weaponid:int)
		{
			var xmlData:XMLList = Main.getMain().getXMLLoader().getXmlData().weapons.weapon[weaponid].bullet;

			//xmlData = xmlData[0].weapons.weapon[weaponid].bullet;
			image = Main.getMain().getImageLoader().getImage(xmlData.imgnum);
			addChild(image);
			addEventListener(Event.ENTER_FRAME,enterFrame);
			weaponType = Weapon.typeNameToId(xmlData.type);
			
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
					//TODO: make "boom pow s	klaboosh" where they meet
					//TODO: play sounds
					otherShip.applyDmg(dmg);
					if(weaponType == 0)
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
