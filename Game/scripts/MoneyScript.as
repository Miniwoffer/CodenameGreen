package scripts {
	
	import flash.net.URLRequest;
	import flash.media.Sound;
	import scripts.Main;
	
	
	public class MoneyScript {
		
		public var playerCurrency:Number = 0;


		public function MoneyScript() {
			
		}
		
		public static function moneyLose(amount:int) {
			playerCurrency -= amount;
			
			if(playerCurrency < 0){
				playerCurrency = 0;
			}
			
		}
		
		public static function moneyGain(amount:int) {
			playerCurrency += amount;
		}
		
	}
	
}
