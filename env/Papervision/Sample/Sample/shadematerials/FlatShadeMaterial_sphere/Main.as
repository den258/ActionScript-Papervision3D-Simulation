﻿package {	import flash.display.*;	import flash.events.*;	import flash.utils.*;		import org.papervision3d.scenes.Scene3D;	import org.papervision3d.objects.DisplayObject3D;	import org.papervision3d.objects.primitives.*;	import org.papervision3d.cameras.*;	import org.papervision3d.view.Viewport3D;	import org.papervision3d.render.BasicRenderEngine;	import org.papervision3d.materials.*;	import org.papervision3d.materials.utils.MaterialsList;	import org.papervision3d.lights.PointLight3D;	import org.papervision3d.materials.shadematerials.*;	[SWF(width="1024", height="568", backgroundColor="#111111", frameRate="50")]	public class Main extends Sprite {			private var scene:Scene3D;		private var camera:Camera3D;		private var viewport:Viewport3D;		private var renderer:BasicRenderEngine;		private var light:PointLight3D;		private var sphere:Sphere;				private var stageW:Number;		private var stageH:Number;		private var vpX:Number;		private var vpY:Number;				private var cameraInfo:CameraInfo;			private var time:Number = 0;		private var secondTime:Number = 0;		private var previousSecondTime:Number = 0;		private var frameNum:Number = 0;		private var fps:String = "...";				private var isDragging:Boolean;		private var mouseDownX:Number;		private var mouseDownY:Number;		private var cameraPitch:Number;		private var cameraYaw:Number;				public function Main () {			init();		}			private function init():void {			setStage();			setScene();			setLight();			setCamera();			setDO3D();			setCameraInfo();						addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);			stage.addEventListener(Event.RESIZE, onStageResizeHandler);			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownHandler);			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveHandler);			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUpHandler);		}				private function setStage():void {			stage.quality = StageQuality.MEDIUM;			stage.scaleMode = StageScaleMode.NO_SCALE;			stage.align = StageAlign.TOP_LEFT;			stageW = stage.stageWidth;			stageH = stage.stageHeight;			vpX = stageW / 2;			vpY = stageH / 2;		}				private function setCameraInfo():void {			cameraInfo = new CameraInfo();			addChild(cameraInfo);			stageW = stage.stageWidth;			stageH = stage.stageHeight;			vpX = stageW / 2;			vpY = stageH / 2;			cameraInfo.x = stageW;			cameraInfo.y = stageH;		}				private function setScene():void{			renderer = new BasicRenderEngine();			scene = new Scene3D();			viewport  = new Viewport3D(0, 0, true, true);			addChild(viewport);		}				private function setLight():void {			light = new PointLight3D(true);			light.x = 300;			light.y = 0;			light.z = -300;			scene.addChild(light);		}				private function setCamera():void {			camera = new Camera3D();			camera.x = 400;			camera.y = 600;			camera.z = -1000;			camera.zoom = 30;			camera.focus = 30;		}				private function setDO3D():void {			var material:FlatShadeMaterial = new FlatShadeMaterial(light, 0xFFFFFF, 0x000000, 20);			sphere = new Sphere(material, 200, 28, 22);			sphere.rotationX = 25;			scene.addChild(sphere);			camera.target = sphere;						var cameraXfromTarget:Number = camera.x - camera.target.x;			var cameraYfromTarget:Number = camera.y - camera.target.y;			var cameraZfromTarget:Number = camera.z - camera.target.z;			cameraYaw = Math.atan2(cameraZfromTarget, cameraXfromTarget) * 180 / Math.PI;			cameraPitch = Math.atan2(-cameraZfromTarget, cameraYfromTarget) * 180 / Math.PI;		}				private function getFPS():void {			time = getTimer();			secondTime = time - previousSecondTime;			if(secondTime >= 1000) {				fps = frameNum.toString();				frameNum = 0;				previousSecondTime = time;			} else {				frameNum++;			}			cameraInfo.fpsText.text = fps+"FPS";			cameraInfo.cameraRotationX.text = camera.rotationX.toString();			cameraInfo.cameraRotationY.text = camera.rotationY.toString();			cameraInfo.cameraRotationZ.text = camera.rotationZ.toString();			cameraInfo.cameraX.text = camera.x.toString();			cameraInfo.cameraY.text = camera.y.toString();			cameraInfo.cameraZ.text = camera.z.toString();		}			private function onEnterFrameHandler(event:Event):void {			if(!isDragging) {				motionDO3D();			}			motionLight();			renderer.renderScene(scene, camera, viewport);			getFPS();		}				private function onStageResizeHandler(event:Event):void {			stageW = stage.stageWidth;			stageH = stage.stageHeight;			vpX = stageW / 2;			vpY = stageH / 2;			cameraInfo.x = stageW;			cameraInfo.y = stageH;		}				private function motionDO3D():void {			sphere.yaw(-1);		}				private function motionLight():void {			lightRotateY(light, 2);		}				private function lightRotateY(lightObj:PointLight3D, angleY:Number):void {			var rad:Number = angleY * Math.PI / 180;			var pX:Number = lightObj.x;			var pZ:Number = lightObj.z;			var cosY:Number = Math.cos(rad);			var sinY:Number = Math.sin(rad);			lightObj.x = pX * cosY + pZ * sinY;			lightObj.z = pZ * cosY - pX * sinY;		}				private function onMouseDownHandler(event:MouseEvent):void {			isDragging = true;			mouseDownX = mouseX;			mouseDownY = mouseY;		}				private function onMouseMoveHandler(event:MouseEvent):void {			var X:Number = (mouseX - mouseDownX) * 0.5;			var Y:Number = (mouseY - mouseDownY) * 0.5;			if(isDragging) {				cameraPitch -= Y;				cameraYaw -= X;				cameraPitch %= 360;				cameraYaw %= 360;				if(cameraPitch <= 0) {					cameraPitch = 0.1;				} else if(cameraPitch >= 180) {					cameraPitch = 179.9				}				camera.orbit(cameraPitch, cameraYaw, true, camera.target);				mouseDownX = mouseX;				mouseDownY = mouseY;			}		}				private function onMouseUpHandler(event:MouseEvent):void {			isDragging = false;		}	}}