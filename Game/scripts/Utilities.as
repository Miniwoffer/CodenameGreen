package scripts  {
	import flash.display.MovieClip;
	import flash.geom.Point;
	/*
	a class containg alle the utility functions not fit to be anywhere else
	*/
	public class Utilities {

		public static function distahceTwoPoints(p1:Point,p2:Point):Number
		{
			var dist:Point = new Point(p1.x-p2.x,p1.y-p2.y);		
			return Math.sqrt(dist.x *dist.x + dist.y *dist.y);
		}
		public static function getRotationTwoPoints(pointer:Point, target:Point):Number
		{
				var cy:Number = target.y - pointer.y;
				var cx:Number = target.x - pointer.x;
				// find out the angle
				var Radians:Number = Math.atan2(cy,cx);
				// convert to degrees to rotate
				return Radians * 180 / Math.PI;
		}
		public static function shortestClockDirection(rot1:Number,rot2:Number):Boolean//CW is true, CCW is false
		{
			var dif = rot1 -  rot2;
			if(dif > 0 && Math.abs(dif) <= 180) return false;
			if (dif > 0 && Math.abs(dif) > 180) return true;
			if (dif < 0 && Math.abs(dif) <= 180) return true;
			if (dif < 0 && Math.abs(dif) > 180) return false;
			
			return false;
		}
	}
	
}
