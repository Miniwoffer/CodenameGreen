package scripts  {
	
	import flash.events.Event;
	import scripts.GameObject;
	import scripts.Weapon;
	import flash.display.Bitmap;
	import flash.geom.Rectangle;
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	public class Ship extends GameObject {
		var shipName:String;
		var health:int;
		var armor:int;
		var speed:int;
		var weapons:Array;
		var velocity:Number;
		var rotVelocity:Number;
		var currentHealth:int;
		var move:Boolean;
		
		var flames:Array;

		public function Ship(id:int,weps:Array) {
			// constructor code
			tag = "ship";
			ignore.push("ship");
			
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
			weapons = new Array();
			flames = new Array();
			/*
			for(var i:int = 0;i < xmlData.flames.children().length();i++)
			{
				flames.push(new Object());
				flames[i].x = xmlData.flames.flame[i].x;
				flames[i].y = xmlData.flames.flame[i].y;
				flames[i].currentFrame = 0;
				flames[i].orgImg = Main.getMain().getImageLoader().getImage(xmlData.flames.flame[i].imgnum);
				flames[i].numFrames = xmlData.flames.flame[i].numframes;
				flames[i].frames = new Array();
				
				var frameHeight = flames[i].orgImg.height/flames[i].numFrames;
				for(var j:int = 0; j < flames[i].numFrames;j++)
				{
					var bit:Bitmap;
					var frameRect = new Rectangle(0,frameHeight*j,flames[i].orgImg.width,frameHeight)
					var bitr:BitmapData;
					//bitr.setPixels(
					flames[i].frames.push(new Bitmap(flames[i].orgImg.bitmapData.getPixels(frameRect)));
				}
					
			}
			*/
			for(var i:int = 0;i < weps.length && i < xmlData.mounts.children().length();i++)
			{
				velocity = 0;
				rotVelocity = 0;
				var wep:Weapon = new Weapon(weps[i],xmlData.mounts.mount[i].x,xmlData.mounts.mount[i].y,xmlData.mounts.mount[i].rot,xmlData.mounts.mount[i].speed,xmlData.mounts.mount[i].movement);
				addChild(wep);
				weapons.push(wep);
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
		public function setWeaponAimLocation(p:Point)
		{
			for(var i:int = 0; i < weapons.length;i++)
			{
				weapons[i].setTarget(p);
			}
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
		}

	}
	
}
