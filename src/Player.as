package
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	
	public class Player extends Entity
	{
		
		[Embed(source = 'assets/player_still.jpg')]
		private const PLAYER_IMG:Class;
		
		[Embed(source = 'assets/player_num.jpg')]
		private const PLAYER_SPRITE_NUM:Class;
		
		[Embed(source = 'assets/player.jpg')]
		private const PLAYER_SPRITE:Class;
		
		public var playerSprite:Spritemap = new Spritemap(PLAYER_SPRITE, 50, 50);
		
		private const COOLDOWN:Number = 0.2;
		private var _shootTimer:Number = 0;
		
		public static const MOUSE_CONTROL:String = "mouse_control";
		public static const KEY_CONTROL:String = "key_control";
		
		public var controlType:String = Player.MOUSE_CONTROL;
		
		public function Player(x:int = 0, y:int = 0)
		{
			
			graphic = new Image(PLAYER_IMG);
			
			playerSprite.add("still",FP.frames(0,4),20,true);
			playerSprite.add("left",[5,6,7,8,9],20,true);
			playerSprite.add("right",[10,11,12,13,14],20,true);
			playerSprite.add("up",[15,16,17,18,19],20,true);
			playerSprite.add("down",[20,21,22,23,24],20,true);
			playerSprite.add("die",[25,26,27,28,29],20,true);
			graphic = playerSprite;
			
			width = 50;
			height = 50;
		}
		
		override public function update():void
		{
			
			if (controlType == Player.MOUSE_CONTROL) {
				mouseMove();
			} else if (controlType == Player.KEY_CONTROL) {
				keyMove();
			}
			
			if (Input.check("shoot") || Input.mouseDown) {
				_shootTimer += FP.elapsed;
				
				if (_shootTimer >= COOLDOWN) {
					_shootTimer -= COOLDOWN;
//					_shootTimer = COOLDOWN;
					var speed:Number = 20;
					shoot(-110, speed);
					shoot(-100, speed);
					shoot(-90, speed);
					shoot(-80, speed);
					shoot(-70, speed);
					speed = 19.5;
					shoot(-110, speed);
					shoot(-100, speed);
					shoot(-90, speed);
					shoot(-80, speed);
					shoot(-70, speed);
					speed = 20.5;
					shoot(-110, speed);
					shoot(-100, speed);
					shoot(-90, speed);
					shoot(-80, speed);
					shoot(-70, speed);
				}
			}
			if (collide("bullet", x, y)) {
				trace("player collide with bullet");
			}
		}
		
		/**
		 * motion controlled by mouse
		 */
		private function mouseMove():void
		{
			var previousX:Number = x;
			var previousY:Number = y;
			
			x = Input.mouseX - 25;
			y = Input.mouseY - 45;
			
			var xChange:int = x - previousX;
			var yChange:int = y - previousY;
			
			var xMove:int = Math.abs(xChange);
			var yMove:int = Math.abs(yChange);
			
			if (xMove > yMove) {
				if (xChange > 1) {
					playerSprite.play("right");
				} else {
					playerSprite.play("left");
				}
			} else if (xMove < yMove) {
				if (yChange > 1) {
					playerSprite.play("down");
				} else {
					playerSprite.play("up");
				}
			} else {
				playerSprite.play("still");				
			}
			
		}
		
		/**
		 * motion controlled by keyboard
		 */
		private function keyMove():void {
			var previousX:Number = x;
			var previousY:Number = y;
			
			if (Input.check("up")) 		{
				playerSprite.play("up");
				y -= 5;
			}
			if (Input.check("down")) 	{
				playerSprite.play("down");
				y += 5;
			}
			if (Input.check("left")) 	{
				playerSprite.play("left");
				x -= 5;
			}
			if (Input.check("right")) 	{
				playerSprite.play("right");
				x += 5;
			}
			
			if (x == previousX && y == previousY) {
				playerSprite.play("still");
			}
		}
		
		public function shoot(angle:Number, speed:Number):void
		{
			var  bullet:Bullet = world.create(Bullet, true) as Bullet;
			bullet.angle = Math.PI/180 * angle;
			bullet.speed = speed;
			bullet.x = x + 20;
			bullet.y = y;
			
		}
	}
}