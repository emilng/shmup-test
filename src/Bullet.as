package
{
	import flash.display.BitmapData;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	public class Bullet extends Entity
	{
		public var angle:Number;
		public var speed:Number;
		
		public function Bullet(x:int = 0, y:int = 0)
		{
			graphic = Image.createRect(2,10, 0x666666, 1);
//			graphic = Image.createCircle(5, 0x666666, 1);
			this.x = x;
			this.y = y;
			setHitbox(10,10);
			type = "bullet";
		}
		
		override public function update():void
		{
			var moveX:Number = Math.cos(angle) * speed;
			var moveY:Number = Math.sin(angle) * speed;
			
			moveBy(moveX, moveY);
			
			if ((y < 0) || 
				(y > FP.height) || 
				(x < 0) || 
				(x > FP.width)) {
				die();
			}
			
			
		}
		
		private function die():void {
			if (this.world) world.recycle(this);
		}
	}
}