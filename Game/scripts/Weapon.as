package scripts
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import scripts.GameObject;
	import flash.events.Event;
	import flash.geom.Point;

	public class Weapon extends MovieClip
	{
		var image:Bitmap;
		var weaponType:int;
		//-Weapon-Types-
		//1 = Projectile
		//2 = Laser
		//3 = Projectile spread?
		var rotationMovment:Number;
		var orgRot:Number;
		var bullet:Bullet;
		var targetRot:Number;
		var rotSpeed:Number;
		var weaponId:int;
		public function Weapon(weaponid:int,posX:int,posY:int,rot:Number, speed:Number, movement:Number)
		{
			weaponId = weaponid;
			rotSpeed = speed;
			var xmlData:XML = Main.getMain().getXMLLoader().getXmlData();
			xmlData = xmlData[0].weapons.weapon[weaponid];
			image = Main.getMain().getImageLoader().getImage(xmlData.imgnum);
			bullet = new Bullet(weaponid);
			var center:Number = image.height / 2;
			x = posX;
			y = posY;
			image.x =  -  center;
			image.y =  -  center;
			rotation = rot;
			orgRot = rot;
			rotationMovment = movement;
			addChild(image);
			//addEventListener(Event.ENTER_FRAME,update);
		}
		public function update(e:Event)
		{

		}
		public function setTarget(t:Point)
		{
			var p = new Point(t.x,t.y);
			var main = Main.getMain();
			p.x -= main.scrollRect.x;
			p.y -= main.scrollRect.y;
			p = parent.globalToLocal(p);
			
			var m = parent.globalToLocal(localToGlobal(new Point(x,y)));
			// find out mouse coordinates to find out the angle
			var cy:Number = p.y - m.y;
			var cx:Number = p.x - m.x;
			// find out the angle
			var Radians:Number = Math.atan2(cy,cx);
			// convert to degrees to rotate
			var Degrees:Number = Radians * 180 / Math.PI;
			// rotate
			rotation = Degrees;
		}
		public function shoot()
		{
			switch(weaponType)
			{
				case 0:
				Main.getMain().addChild(new Bullet(weaponId));
				break;
			}
		}
	}

}