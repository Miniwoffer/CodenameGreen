package scripts  {
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import scripts.GameObject;
	
	public class Weapon extends MovieClip {
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
	
}
