package
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	
	public class Enemy extends Entity
	{
		public var player:Player;
		
//		private const COOLDOWN:Number = 0.6;
		private const COOLDOWN:Number = 0.1;
		
		private var _shootTimer:Number = 0;
		
		public var startX:Number;
		private var _moveWidth:Number = 100;
		private var _xAngle:Number = 0;
		
		public function Enemy(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			this.graphic = Image.createRect(50, 50, 0x000000, 1);
			this.x = x;
			this.y = y;
			
			setHitbox(50, 50);
		}
		
		override public function update():void {
//			if (x > FP.width + width) {
//				x = -width;
//			}
			
			_xAngle += 0.05;
			if (_xAngle > 360) {
				_xAngle = 0;
			}
			
			moveTo(startX + Math.sin(_xAngle)*_moveWidth, y + 2);
			
			if (y > FP.height) {
				die();
			}
			_shootTimer += FP.elapsed;
			if (_shootTimer >= COOLDOWN) {
				_shootTimer -= COOLDOWN;
				shoot();
			}
		}
		
		private function shoot():void {
			var  bullet:EnemyBullet = world.create(EnemyBullet, true) as EnemyBullet;
			bullet.angle = FP.RAD * FP.angle(x, y, player.x, player.y);
			bullet.speed = 4;
			bullet.x = x;
			bullet.y = y;
		}
		
		private function die():void {
			if (this.world) world.recycle(this);
		}
	}
}