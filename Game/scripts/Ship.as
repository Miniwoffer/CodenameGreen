package scripts  {
	
	import scripts.GameObject;
	
	public class Ship extends GameObject {
		var shipName:String;
		var health:int;
		var armor:int;
		var speed:int;
		var mounts:Array;
		var move:Boolean;

		public function Ship(sn:String,h:int,a:int,s:int,m:Array) {
			// constructor code
			shipName = sn;
			health = h;
			armor = a;
			speed = s;
			mounts = m;
		}
		override function frameEnter(e:Event){
			super.frameEnter(e);
				if(move)
				{
					var angle =  rotation * Math.PI / 180;
					x += speed * Math.cos(angle);
					y += speed * Math.sin(angle);
				}
		}
		public function Forward()
		{

		}
		public function TurnLeft()
		{
			rotation += speed;

		}
		public funtion TurnRight()
		{
			rotation -= speed;
		}

	}
	
}
