package scripts  {
	import flash.events.Event;
	import scripts.Ship;
	import scripts.Utilities;
	import scripts.Player;
	import scripts.Main;
	import flash.geom.Point;

	public class Ai  {
		var aiStatus:int;
		/*
		0 - idle alert
		1 - roaming
		2 - destroy
		3 - run away
		4 - disabled
		*/
		var detectRange:int;
		var attackRange:int;
		var stopRange:int;
		var looseRange:int;
		
		var ship:Ship;
		public function Ai(shipID:int, weapons:Array, stat:int = 4,locX:int = 0,locY:int = 0, detectRng:int = 600,attackRng:int = 500,stopRng:int = 300, loseRng:int = 1000) {
			// constructor code
			looseRange = loseRng;
			detectRange = detectRng;
			attackRange = attackRng;
			stopRange = stopRng;
			ship = new Ship(shipID,weapons);
			ship.addEventListener(Event.ENTER_FRAME,update);
			ship.x = locX;
			ship.y = locY;
			//range = range;
			aiStatus = stat;
		}
		public function update(e:Event)
		{
			var playerShip:Ship = Main.getMain().getPlayer().getShip();
			var playerLocation:Point = new Point(playerShip.x,playerShip.y);
			var myLocation:Point = new Point(ship.x,ship.y);
			switch(aiStatus)
			{
				case 0:
					lookForPlayer(playerLocation);
				break;
				case 1:
				break;
				case 2:
					ship.setWeaponAimLocation(playerLocation);
					var rangeTtoPlayer:Number = Utilities.distahceTwoPoints(myLocation,playerLocation); 
					var targetRot:Number = Utilities.getRotationTwoPoints(myLocation,playerLocation);
					var diffrence:Number = targetRot-ship.rotation;
					if(Utilities.shortestClockDirection(ship.rotation,targetRot))
					{
						ship.turnRight();
					}
					else
					{
						ship.turnLeft();
					}
					if(rangeTtoPlayer > stopRange)
					{
						ship.forward();
					}
					if(rangeTtoPlayer < attackRange)
					{
						ship.shoot();
					}
					if(looseRange < rangeTtoPlayer)
					{
						aiStatus = 0;
					}
				break;
				case 3:
				
				break;  
			}
			if(ship.health < 50)
			{
				aiStatus = 3;
			}
		}
		public function newRoamingDirection()
		{
			
		}
		public function lookForPlayer(playerLocation:Point)
		{
			if(Utilities.distahceTwoPoints(playerLocation,new Point(ship.x,ship.y)) < detectRange)
			{
				aiStatus = 2;
			}
		}

	}
	
}
