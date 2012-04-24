
package {

	import flash.display.*;
	import flash.events.*;
	import flash.ui.Keyboard;

	import org.papervision3d.core.geom.Lines3D;
	import org.papervision3d.materials.special.LineMaterial;
	import org.papervision3d.core.geom.renderables.Vertex3D;
	import org.papervision3d.core.geom.renderables.Line3D;

	import org.papervision3d.scenes.Scene3D;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.objects.primitives.Cube;
	import org.papervision3d.cameras.Camera3D;
	import org.papervision3d.view.Viewport3D;
	import org.papervision3d.render.BasicRenderEngine;
	import org.papervision3d.materials.WireframeMaterial;
	import org.papervision3d.materials.utils.MaterialsList;
	
	[SWF(width="1024", height="568", backgroundColor="#FFFFFF", frameRate="50")]

	public class Main extends Sprite {
	
		private var scene:Scene3D;
		private var camera:Camera3D;
		private var viewport:Viewport3D;
		private var renderer:BasicRenderEngine;
		
		private var lines3D:Lines3D;
		
		private var intMaxCount:Number = 1000;
	
		private var objPoints:Array = new Array();

		public function Main () {			
			init();
		}

		private function init():void {
			setStage();
			setScene();
			setCamera();
			setDO3D();
			setMovablePoints();
			addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
		}
		
		private function setMovablePoints():void {

			objPoints = new Array();

			for(var intIndex:Number=0; intIndex<intMaxCount; intIndex++){

				var dblDegree:Number = (intIndex / intMaxCount) * 360;

				var objPoint:MovablePoint13 = new MovablePoint13();

				objPoint.setDbl方向(dblDegree);

				objPoints.push(objPoint);

			}

		}

		// ---------------------------------------------------------------------
		// - 角度からラジアンに変換する関数
		// ---------------------------------------------------------------------
		private function getRadian(dblDegree:Number):Number {
			return dblDegree * (Math.PI / 180);
		}

		// ---------------------------------------------------------------------
		// - 球型 : ドットで構成される球
		// ---------------------------------------------------------------------
		private function DrawMoveablePointsOnSphere():void {
	
			var dbl半径:Number = 70.0;
			var dbl仰角:Number = 0.0;   //  0.0  →  360.0
			var dbl俯角:Number = 0.0;   //  0.0  →  360.0
	
			for(var intCount:Number=0; intCount<intMaxCount; intCount++) {
				
				dbl俯角 = MovablePoint13(objPoints[intCount]).getDblX();
				dbl仰角 = MovablePoint13(objPoints[intCount]).getDblY();
	
				var dblX:Number = dbl半径 * Math.cos(getRadian(dbl仰角)) * Math.sin(getRadian(dbl俯角));
				var dblY:Number = dbl半径 * Math.sin(getRadian(dbl仰角));
				var dblZ:Number = dbl半径 * Math.cos(getRadian(dbl仰角)) * Math.cos(getRadian(dbl俯角));

				Line3D(lines3D.lines[intCount]).v0.x = dblX;
				Line3D(lines3D.lines[intCount]).v0.y = dblY;
				Line3D(lines3D.lines[intCount]).v0.z = dblZ;
				Line3D(lines3D.lines[intCount]).v1.x = dblX + 1.0;
				Line3D(lines3D.lines[intCount]).v1.y = dblY + 1.0;
				Line3D(lines3D.lines[intCount]).v1.z = dblZ + 1.0;

				MovablePoint13(objPoints[intCount]).move();

			}

		}

		private function setStage():void {
			stage.quality = StageQuality.MEDIUM;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDownHandler);
		}
		
		private function setScene():void{
			renderer = new BasicRenderEngine();
			scene = new Scene3D();
			viewport  = new Viewport3D(0, 0, true, true);
			addChild(viewport);
		}
		
		private function setCamera():void {
			camera = new Camera3D();
			camera.x = 0;
			camera.y = 0;
			camera.z = -800;
			camera.zoom = 30;
			camera.focus = 30;
			camera.target = DisplayObject3D.ZERO;
		}
		
		private function setDO3D():void {

			var lm:LineMaterial = new LineMaterial(0x000000, 1.0);

			lm.interactive = true;
	
			lines3D = new Lines3D(lm,"Lines3d");
			
			for(var intIndex:Number=0; intIndex<intMaxCount; intIndex++){
				lines3D.addNewLine(1, 0, 0, 0, 1, 1, 1);
			}

			lines3D.addNewLine(1, 80, 80, 80, 80,-80, 80);
			lines3D.addNewLine(1, 80,-80, 80,-80,-80, 80);
			lines3D.addNewLine(1,-80,-80, 80,-80, 80, 80);
			lines3D.addNewLine(1,-80, 80, 80, 80, 80, 80);

			lines3D.addNewLine(1, 80, 80,-80, 80,-80,-80);
			lines3D.addNewLine(1, 80,-80,-80,-80,-80,-80);
			lines3D.addNewLine(1,-80,-80,-80,-80, 80,-80);
			lines3D.addNewLine(1,-80, 80,-80, 80, 80,-80);

			lines3D.addNewLine(1, 80, 80, 80, 80, 80,-80);
			lines3D.addNewLine(1, 80,-80, 80, 80,-80,-80);
			lines3D.addNewLine(1,-80,-80, 80,-80,-80,-80);
			lines3D.addNewLine(1,-80, 80, 80,-80, 80,-80);
			
			scene.addChild(lines3D);

		}
			
		private function onEnterFrameHandler(event:Event):void {
			
			DrawMoveablePointsOnSphere();

			renderer.renderScene(scene, camera, viewport);

		}

		private function onKeyDownHandler(event:KeyboardEvent):void {

			switch(event.keyCode) {

				case Keyboard.F12:
					setMovablePoints();
					break;

				case Keyboard.LEFT:
					lines3D.rotationY += 5;
					break;

				case Keyboard.RIGHT:
					lines3D.rotationY -= 5;
					break;

				case Keyboard.UP:
					lines3D.rotationX += 5;
					break;

				case Keyboard.DOWN:
					lines3D.rotationX -= 5;
					break;

			}

		}

	}

}
