﻿package {
	import flash.display.*;
	import flash.events.*;
	
	import org.papervision3d.scenes.Scene3D;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.objects.primitives.Cube;
	import org.papervision3d.cameras.Camera3D;
	import org.papervision3d.view.Viewport3D;
	import org.papervision3d.render.BasicRenderEngine;
	import org.papervision3d.materials.WireframeMaterial;
	import org.papervision3d.materials.utils.MaterialsList;

	[SWF(width="1024", height="568", backgroundColor="#333333", frameRate="50")]

	public class Main extends Sprite {
	
		private var scene:Scene3D;
		private var camera:Camera3D;
		private var viewport:Viewport3D;
		private var renderer:BasicRenderEngine;
		
		private var stageW:Number;
		private var stageH:Number;
		private var vpX:Number;
		private var vpY:Number;
	
		public function Main () {			
			init();
		}
	
		private function init():void {
			setStage();
			setScene();
			setCamera();
			setDO3D();
			
			addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
		}
		
		private function setStage():void {
			stage.quality = StageQuality.MEDIUM;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stageW = stage.stageWidth;
			stageH = stage.stageHeight;
			vpX = stageW / 2;
			vpY = stageH / 2;
//			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDownHandler);
//			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUpHandler);
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
			camera.y = 100;
			camera.z = -600;
			camera.zoom = 30;
			camera.focus = 30;
			camera.target = DisplayObject3D.ZERO;
		}
		
		private function setDO3D():void {
			var material:WireframeMaterial = new WireframeMaterial(0xCCCCCC, 1);
			var materialList:MaterialsList = new MaterialsList({all: material});
			material.oneSide = false;
			var cube:Cube = new Cube(materialList, 300, 300, 300, 4, 4, 4);
			scene.addChild(cube);
		}
		
		private function moveCameraX(angleX:Number):void {
			var cosX:Number = Math.cos(angleX);
			var sinX:Number = Math.sin(angleX);
			camera.x = camera.x * cosX - camera.z * sinX;
		}
		
		private function moveCameraY(angleY:Number):void {
			var cosY:Number = Math.cos(angleY);
			var sinY:Number = Math.sin(angleY);
			camera.y = camera.y * cosY - camera.z * sinY;
		}
	
		private function onEnterFrameHandler(event:Event):void {
			var angleX:Number = (mouseX - vpX) * 0.0001;
			var angleY:Number = (mouseY - vpY) * 0.0001;
			moveCameraX(angleX);
			moveCameraY(angleY);
			renderer.renderScene(scene, camera, viewport);
		}
	}
}