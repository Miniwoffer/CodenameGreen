package scripts  {
	
	import flash.events.Event;
	import scripts.GameObject;
	import scripts.Weapon;
	import flash.display.Bitmap;
	
	public class Ship extends GameObject {
		var shipName:String;
		var health:int;
		var armor:int;
		var speed:int;
		var mounts:Array;
		var velocity:Number;
		var rotVelocity:Number;
		var currentHealth:int;
		var move:Boolean;

		public function Ship(id:int,weapons:Array) {
			// constructor code
			trace("player created");
			var xmlData:XML = Main.getMain().getXMLLoader().getXmlData();
			xmlData = xmlData[0].ships.ship[id];
			var image:Bitmap = Main.getMain().getImageLoader().getImage(xmlData.imgnum);
			image.x = -image.width/2;
			image.y = -image.height/2;
			x = 100;
			y = 100;
			addChild(image);
			shipName = xmlData.name;
			health = xmlData.health;
			armor = xmlData.armor;
			speed = xmlData.speed;
			currentHealth = health;
			mounts = new Array();
			for(var i:int = 0;i < xmlData.mounts.children().length();i++)
			{
				velocity = 0;
				rotVelocity = 0;
				var mnt:WeaponMount = new WeaponMount(xmlData.mounts.mount[i].x,xmlData.mounts.mount[i].y,xmlData.mounts.mount[i].rot,xmlData.mounts.mount[i].movement);
				addChild(mnt);
				if(weapons[i] != null)
					mnt.setWeapon(weapons[i]);
				
				mounts.push(mnt);
			}
			Main.getMain().addChild(this);
		}
		override public function update(e:Event){
			super.update(e);
			var angle =  rotation * Math.PI / 180;
			x += velocity * Math.cos(angle);
			y += velocity * Math.sin(angle);
			rotation += rotVelocity;
			velocity -= velocity/20;
			rotVelocity -= rotVelocity/10;
			if(velocity > speed)
				velocity = speed;
			if(rotVelocity > speed/3)
				rotVelocity = speed/3;
			if(rotVelocity < -speed/3)
				rotVelocity = -speed/3;
		}
		public function forward()
		{
			velocity += speed/3;
		}
		public function turnLeft()
		{
			rotVelocity -= speed/5;

		}
		public function turnRight()
		{
			rotVelocity += speed/5;
		}
		public function getWeapon(slot:int):Weapon
		{
			return null;
		}
		public function setWeapon(slot:int, wep:Weapon)
		{
			
		}
		public function setWeaponAimLocation(posx,posy)
		{
			
		}
		public function applyDmg(amount:int)
		{
			currentHealth -= amount;
			if(currentHealth > 0)
				die();
			
			
		}
		public function die()
		{
			Main.getMain().removeChild(this);
		}
		override public function onCollision(other:GameObject)
		{
			super.onCollision(other);
			trace("wobalobadudu");
		}

	}
	
}
