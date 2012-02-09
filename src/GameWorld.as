package
{
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class GameWorld extends World
	{
		
		private var _player:Player;
		private var _enemy:Enemy;
		
		private const COOLDOWN:Number = 1;
		
		private var _enemyTimer:Number = 0;
		
		public function GameWorld()
		{
			_player = new Player();
			add(_player);
			
//			_enemy = new Enemy(FP.halfWidth, 30);
//			_enemy.player = _player;
//			add(_enemy);
			
			Input.define("up", Key.UP, Key.W);
			Input.define("down", Key.DOWN, Key.S);
			Input.define("left", Key.LEFT, Key.A);
			Input.define("right", Key.RIGHT, Key.D);
			
			Input.define("shoot", Key.Z);
		}
		
		override public function update():void
		{
			super.update();
			
			_enemyTimer += FP.elapsed;
			if (_enemyTimer >= COOLDOWN) {
				_enemyTimer -= COOLDOWN;
				
				var enemy:Enemy = create(Enemy, true) as Enemy;
				enemy.startX = Math.random() * FP.width;
				enemy.y = 0;
				enemy.player = _player;
			}
		}
	}
}