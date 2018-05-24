package  {
	
	import flash.display.MovieClip;
	
	
	public class Enemy extends MovieClip {
		
		private var hit:Boolean;
		
		public function Enemy() {
			// constructor code
			hit = false;
		}
		
		public function setHit(b:Boolean):void {
			hit = b;
		}
		
		public function getHit():Boolean {
			return hit;
		}
		
		public function disappear():void {
			
			x = -500;
			hit = false;
		}
		
	}
	
}
