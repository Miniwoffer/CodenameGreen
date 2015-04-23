package scripts  {
	import flash.display.MovieClip;
	public class WeaponMount extends MovieClip  {
		var weapon:Weapon;
		public function WeaponMount(posX:int,posY:int,rot:int,movement:int)
		{
			
		}
		public function setWeapon(wep:Weapon)
		{
			weapon = wep;
		}
		public function getWeapon():Weapon
		{
			return weapon;
		}
		public function getShip():Ship{
			return Ship(this.parent);
		}
	}
	
}
