
package {

	import flash.display.*;
	import flash.events.*;
	import flash.ui.Keyboard;

	public class MovablePoint13 {
	
		private var dbl距離:Number = 2.0;
		private var dbl方向:Number = 0.0;  // 0 → 360
		private var dblX:Number = 0.0;
		private var dblY:Number = 0.0;
	
		public function getDblX():Number {
			return dblX;
		}
		
		public function setDblX(dblX:Number):void {
			this.dblX = dblX;
		}
		
		public function getDblY():Number {
			return dblY;
		}
		
		public function setDblY(dblY:Number):void {
			this.dblY = dblY;
		}
		
		public function getDbl距離():Number {
			return dbl距離;
		}
		
		public function setDbl距離(dbl距離:Number):void {
			this.dbl距離 = dbl距離;
		}
		
		public function getDbl方向():Number {
			return dbl方向;
		}
		
		public function setDbl方向(int方向:Number):void {
			this.dbl方向 = int方向;
		}
	
		public function move():void {
			dblX = dblX + dbl距離 * Math.cos( getRadian(dbl方向) );
			dblY = dblY + dbl距離 * Math.sin( getRadian(dbl方向) );
		}
	
		// ---------------------------------------------------------------------
		// - 角度からラジアンに変換する関数
		// ---------------------------------------------------------------------
		private function getRadian(dblDegree:Number):Number {
			return dblDegree * (Math.PI / 180);
		}

	}

}