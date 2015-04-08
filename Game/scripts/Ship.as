package scripts  {
	
	public class Ship {
		var shipName:String;
		var health:int;
		var armor:int;
		var speed:int;
		var mounts:Array;
		public function Ship(sn:String,h:int,a:int,s:int,m:Array) {
			// constructor code
			shipName = sn;
			health = h;
			armor = a;
			speed = s;
			mounts = m;
		}

	}
	
}
