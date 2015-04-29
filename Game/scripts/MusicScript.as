package scripts {
	
	import flash.net.URLRequest;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.MovieClip;
	import scripts.Main;
	
	
	public class MusicScript {

		static public var introSound:Sound = new Sound(new URLRequest("content/sound/Relaxing.mp3"));
		static public var idleSound:Sound = new Sound(new URLRequest("content/sound/Newdawn.mp3"));
		static public var epicSound:Sound = new Sound(new URLRequest("content/sound/Epic.mp3"));
		
		static public var musicChannel:SoundChannel;
		static public var lastPosition:Number = 0;
		static public var lastPositionBattle:Number = 0;
		
		static public var currentTrack:Sound = introSound;
		
		Main.getMain().soundMC.playButton.visible = false;
		Main.getMain().soundMC.pauseButton.visible = true;
		Main.getMain().soundMC.pauseButton.addEventListener(MouseEvent.CLICK, pause);
		Main.getMain().soundMC.playButton.addEventListener(MouseEvent.CLICK, resume);

		
		public function MusicScript() {
			
		}
		
		static public function setCurrentTrack (soundTrack:Sound){
			musicChannel.stop();
			currentTrack = soundTrack;
			lastPosition = 0;
			if (Main.getMain().soundMC.pauseButton.visible){
				start(null);
			}
		}

		static function start (e:Event){
			musicChannel = currentTrack.play();
			musicChannel.addEventListener(Event.SOUND_COMPLETE, start);
		}

	
		static public function pause(e:MouseEvent){
			lastPosition = musicChannel.position;
			musicChannel.stop();
			Main.getMain().soundMC.playButton.visible = true;
			Main.getMain().soundMC.pauseButton.visible = false;
		}

		static public function resume (e:MouseEvent){
			musicChannel = currentTrack.play(lastPosition);
			Main.getMain().soundMC.playButton.visible = false;
			Main.getMain().soundMC.pauseButton.visible = true;
			musicChannel.addEventListener(Event.SOUND_COMPLETE, start);
		}
		 
	}
	
}
