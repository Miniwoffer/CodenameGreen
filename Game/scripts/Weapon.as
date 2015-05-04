package scripts
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.Sound;

	import scripts.GameObject;
	import flash.utils.Timer;
	import flash.media.SoundTransform;

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
		var targetRot:Number;
		var rotSpeed:Number;
		var weaponId:int;
		var staticMount:Boolean;
		var reloadTimer:Timer;
		var sound:Sound;
		var soundTrans:SoundTransform;
		public function Weapon(size:Number,weaponid:int,posX:int,posY:int,rot:Number, speed:Number, movement:Number, staticmount:String)
		{
			staticMount = staticmount == "true";
			weaponId = weaponid;
			rotSpeed = speed;
			var xmlData:XML = Main.getMain().getXMLLoader().getXmlData();
			xmlData = xmlData[0].weapons.weapon[weaponid];
			
			sound = Main.getMain().getSoundLoader().getSound(xmlData.soundnum);
			soundTrans = new SoundTransform(xmlData.soundvolum);
			weaponType = typeNameToId(xmlData.type);

			image = Main.getMain().getImageLoader().getImage(xmlData.imgnum);
			image.scaleX = size;
			image.scaleY = size;
			var center:Number = image.height / 2;
			x = posX;
			y = posY;
			image.x =  -  center;
			image.y =  -  center;
			rotation = rot;
			orgRot = rot;
			rotationMovment = movement;
			reloadTimer = new Timer(xmlData.firerate,1);
			addChild(image);
			//addEventListener(Event.ENTER_FRAME,update);
		}
		public function update(e:Event)
		{

		}
		public function setTarget(t:Point)
		{
			if (!staticMount)
			{
				var p = new Point(t.x,t.y);
				var main = Main.getMain();
				p.x -=  main.scrollRect.x;
				p.y -=  main.scrollRect.y;
				p = p;

				var myRect:Rectangle = getBounds(stage);
				var m = new Point(myRect.x,myRect.y);
				// find out mouse coordinates to find out the angle
				var cy:Number = p.y - m.y;
				var cx:Number = p.x - m.x;
				// find out the angle
				var Radians:Number = Math.atan2(cy,cx);
				// convert to degrees to rotate
				var Degrees:Number = Radians * 180 / Math.PI;
				// rotate
				rotation = Degrees - parent.rotation;
			}
		}
		public function shoot()
		{
			if (! reloadTimer.running)
			{
				var bullet:Bullet;
				sound.play(0,0,soundTrans);
				switch (weaponType)
				{
					case 0 :
						bullet = new Projectile(weaponId,this,image.scaleX);
						break;
				}
				var center:Number = image.height / 2;
				var wepPos:Point = Main.getMain().globalToLocal(localToGlobal(new Point(image.x+image.width,image.y+image.height/2)));
				bullet.x = wepPos.x;
				bullet.y = wepPos.y;
				bullet.rotation = parent.rotation + rotation;
				reloadTimer.reset();
				reloadTimer.start();
			}
		}
		public static function typeNameToId(weaponTypeName:String):int
		{
			var ret:int = -1;
			switch (weaponTypeName)
			{
				case "Projectile" :
					ret = 0;
					break;
				default :
					if (Main.getMain().debug)
					{
						trace("Unknown weapon name \"" + weaponTypeName+"\"");
					}
					break;

			}
			return ret;
		}
	}

}