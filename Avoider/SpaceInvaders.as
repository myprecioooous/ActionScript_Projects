package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	
	public class SpaceInvaders extends MovieClip {
		
		//declare our instance variables
		private var player: Player;
		private var bullets:Vector.<Bullet>;
		private var bulletCount:Number;
		
		private var enemies:Vector.<Enemy>;
		private var enemyCount:Number;
		
		private var playerScore:Number;
		private var enemyScore:Number;
		private var playerScoreTxt: TextField;
		
		private var lifeBar:LifeBar2;
		private var resetButton:ResetButton;
		
		public function SpaceInvaders() {
			// constructor code
			//instantiate our instance variables
			player = new Player();
			player.x = stage.stageWidth/2;
			player.y = stage.stageHeight - player.height;
			stage.addChild(player);
			
			//instatiating our carrot variables
			bullets = new Vector.<Bullet>();
			for(var i:Number = 0; i < 20; i++)  {
				var c:Bullet = new Bullet();
				c.x = -300;
				bullets.push(c);
			}
			bulletCount = 0;
			
			//instatiating our carrot variables
			enemies = new Vector.<Enemy>();
			for(i = 0; i < 20; i++)  {
				var p:Enemy = new Enemy();
				enemies.push(p);
			}
			enemyCount = 0;
			
			playerScore = 0;
			enemyScore = 0;
			
			lifeBar = new LifeBar2();
			lifeBar.x = 400;
			lifeBar.y = 50;
			stage.addChild(lifeBar);
			
			playerScoreTxt = new TextField();//instantiation
			playerScoreTxt.autoSize = TextFieldAutoSize.LEFT;
			playerScoreTxt.background = true;
			playerScoreTxt.backgroundColor = 0x0099CC;
			playerScoreTxt.border = true;
			playerScoreTxt.x = 75;
			playerScoreTxt.y = 25;
			
			var format:TextFormat = new TextFormat();
			//format.bold = true;
			format.font = "Verdana";
			format.color = 0x663300;
			format.size = 25;
			
			playerScoreTxt.defaultTextFormat = format;
			playerScoreTxt.text = "Score: " + playerScore;
			stage.addChild(playerScoreTxt);
			
			resetButton = new ResetButton();
			resetButton.x = -900;//stage.stageWidth/2;
			resetButton.y = stage.stageHeight/2;
			stage.addChild(resetButton);
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMoved);
			stage.addEventListener(MouseEvent.CLICK, fireBullet);
			stage.addEventListener(Event.ENTER_FRAME, onFrameEntered);
			
		}//end constructor
		
		public function onMouseMoved(e: MouseEvent):void {
			
			player.x = e.stageX;
			
		}//end onMouseMoved
		
		public function fireBullet(e: MouseEvent):void {
			bullets[bulletCount].x = player.x;
			bullets[bulletCount].y = player.y;
			stage.addChild(bullets[bulletCount]);
			
			bulletCount++;
			if(bulletCount == 20)
				bulletCount = 0;
			
		}//end fireBullet
		
		public function onFrameEntered(e:Event):void  {
			//loop to move bullets up the screen
			for(var i:Number = 0; i < 20; i++)  {
				//bullets[i].y = bullets[i].y - 3;
				bullets[i].y -= 5;
				
			}//end for loop
			
			//make new enemies on the screen and move them up
			//make a new enemy randomly appear
			var num:Number = Math.random() * 20;
			if(num <= 1) { //add enemy 10% of the time
				var xPos:Number = Math.random() * stage.stageWidth;
				enemies[enemyCount].x = xPos;
				enemies[enemyCount].y = 0;
				stage.addChild(enemies[enemyCount]);
				enemyCount++;
				if(enemyCount == 20)
					enemyCount = 0;
			}
			
			//loop to move enemies down the screen
			for(i = 0; i < 20; i++)  {
				//enemies[i].y = enemies[i].y + 5;
				enemies[i].y += 5;
				
				//check to see if a enemy at index i is hitting the player
				if(enemies[i].hitTestObject(player)) {
					enemyScore++;
						
					//check the enemyScore to see if we need to reset the game
					trace("enemyScore " + enemyScore);
					if(enemyScore > 12)
						reset();
					
					enemies[i].x = -900;
					lifeBar.gotoAndPlay("hit" + enemyScore);
				}
				
				//check to see if the enemies have hit a bullet
				for(var j:Number = 0; j < 20; j++)  {
					//trace("hit is " + enemies[i].getHit());
					if (enemies[i].hitTestObject(bullets[j]) && !enemies[i].getHit()) {
						enemies[i].gotoAndPlay("explode");
						enemies[i].setHit(true);
						//enemies[i].x = -500;
						bullets[j].x = -700;
						
						//add one to the player score and display it
						playerScore++;
						playerScoreTxt.text = "Score: " + playerScore;
					}//end if statement
				}//end inner for loop
				
			}//end outer for loop
			
		}//end onFrameEntered
		
		public function reset():void  {
			
			resetButton.x = stage.stageWidth/2;
			resetButton.addEventListener(MouseEvent.CLICK, resetGame);
			
			stage.removeEventListener(Event.ENTER_FRAME, onFrameEntered);
			
			for(var j:Number = 0; j < 20; j++)  {
				enemies[j].x = -1100;
			}//end for
			
		}//end ResetButton
		
		public function resetGame(e: MouseEvent):void {
			playerScore = 0;
			playerScoreTxt.text = "Score: " + playerScore;
			
			enemyScore = 0;
			
			resetButton.x = -900;
			stage.addEventListener(Event.ENTER_FRAME, onFrameEntered);
			
		}//end resetGame
		
	}//end class
	
}//end package
