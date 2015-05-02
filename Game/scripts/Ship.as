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
		var maxHealth:int;
		var armor:int;
		var speed:int;
		var weapons:Array;
		var velocity:Number;
		var rotVelocity:Number;
		var move:Boolean;
		
		var flames:Array;
		public var hpBar:hpbarsmall;
		public function Ship(id:int,weps:Array) {
			// constructor code
			addEventListener(Event.EXIT_FRAME,exitUpdate);
			scaleX = 0.6;
			scaleY = 0.6;
			tag = "ship";
			ignore.push("ship");
			hpBar = new hpbarsmall();
			hpBar.scaleX = 0.15;
			hpBar.scaleY = 0.15;
			Main.getMain().addChild(hpBar);
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
			maxHealth = health;
			armor = xmlData.armor;
			speed = xmlData.speed;
			weapons = new Array();
			flames = new Array();
			for(var i:int = 0;i < weps.length && i < xmlData.mounts.children().length();i++)
			{
				velocity = 0;
				rotVelocity = 0;
				var wep:Weapon = new Weapon(xmlData.mounts.mount[i].size,weps[i],xmlData.mounts.mount[i].x,xmlData.mounts.mount[i].y,xmlData.mounts.mount[i].rot,xmlData.mounts.mount[i].speed,xmlData.mounts.mount[i].movement,xmlData.mounts.mount[i].static);
				addChild(wep);
				weapons.push(wep);
			}
			Main.getMain().addChildAt(this,1);
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
		public function exitUpdate(e:Event)
		{
			var main:Main =  Main.getMain();
			hpBar.x = x;
			hpBar.y = y-60;
			hpBar.smallHpBarVisual.width = (440/maxHealth)*health;
		}
		public function shoot()
		{
			for(var i:int; i < weapons.length;i++)
				weapons[i].shoot();
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
			var doDmg:int = (amount)-(Math.random()*armor);
			if(doDmg > 0)
			{
			health -= amount;
			if(health <= 0)
				die();
			}
			
			
		}
		public function die()
		{
			super.destroy(null);
			Main.getMain().removeChild(hpBar);
			Ai.checkForEnemies(null);
			Main.getMain().getPlayer().addMoney(100);
		}
		override public function onCollision(other:GameObject)
		{
			super.onCollision(other);
		}

	}
	
}
