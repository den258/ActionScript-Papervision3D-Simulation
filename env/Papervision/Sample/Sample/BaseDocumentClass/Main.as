﻿package {	import flash.display.*;	import flash.events.*;	import flash.utils.*;		import org.papervision3d.scenes.Scene3D;	import org.papervision3d.objects.DisplayObject3D;	import org.papervision3d.objects.primitives.*;	import org.papervision3d.cameras.*;	import org.papervision3d.view.Viewport3D;	import org.papervision3d.render.BasicRenderEngine;	import org.papervision3d.materials.*;	import org.papervision3d.materials.utils.MaterialsList;	[SWF(width="1024", height="568", backgroundColor="#CCCCCC", frameRate="50")]	public class Main extends Sprite {			private var scene:Scene3D;		private var camera:Camera3D;		private var viewport:Viewport3D;		private var renderer:BasicRenderEngine;				private var stageW:Number;		private var stageH:Number;		private var vpX:Number;		private var vpY:Number;				private var cameraInfo:CameraInfo;			private var time:Number = 0;		private var secondTime:Number = 0;		private var previousSecondTime:Number = 0;		private var frameNum:Number = 0;		private var fps:String = "...";				// -- SWC書き出しのためのインスタンス化 Start -- //		private var m_1:Back = new Back();		private var m_2:Bottom = new Bottom();		private var m_3:Front = new Front();		private var m_4:Left = new Left();		private var m_5:Right = new Right();		private var m_6:Top = new Top();		// -- SWC書き出しのためのインスタンス化 End -- //				public function Main () {						init();		}			private function init():void {			setStage();			setScene();			setCamera();			setDO3D();			setCameraInfo();						addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);			stage.addEventListener(Event.RESIZE, onStageResizeHandler);		}				private function setStage():void {			stage.quality = StageQuality.MEDIUM;			stage.scaleMode = StageScaleMode.NO_SCALE;			stage.align = StageAlign.TOP_LEFT;			stageW = stage.stageWidth;			stageH = stage.stageHeight;			vpX = stageW / 2;			vpY = stageH / 2;		}				private function setCameraInfo():void {			cameraInfo = new CameraInfo();			addChild(cameraInfo);			stageW = stage.stageWidth;			stageH = stage.stageHeight;			vpX = stageW / 2;			vpY = stageH / 2;			cameraInfo.x = stageW;			cameraInfo.y = stageH;		}				private function setScene():void{			renderer = new BasicRenderEngine();			scene = new Scene3D();			viewport  = new Viewport3D(0, 0, true, true);			addChild(viewport);		}				private function setCamera():void {			camera = new Camera3D();			camera.x = 0;			camera.y = 100;			camera.z = -600;			camera.zoom = 30;			camera.focus = 30;			camera.target = DisplayObject3D.ZERO;		}				private function setDO3D():void {			var materialPlane:WireframeMaterial = new WireframeMaterial(0x999999, 1);			materialPlane.oneSide = false;			var plane:Plane = new Plane(materialPlane, 2000, 2000, 8, 8);			plane.rotationX = 90;			scene.addChild(plane);			var materialList:MaterialsList = new MaterialsList({				front: new MovieAssetMaterial("Front", true ),				back: new MovieAssetMaterial("Back", true ),				right: new MovieAssetMaterial("Right", true ),				left: new MovieAssetMaterial("Left", true ),				top: new MovieAssetMaterial("Top", true ),				bottom: new MovieAssetMaterial("Bottom", true )			});			var cube:Cube = new Cube(materialList, 300, 300, 300, 4, 4, 4);			cube.y = 200;			scene.addChild(cube);		}				private function getFPS():void {			time = getTimer();			secondTime = time - previousSecondTime;			if(secondTime >= 1000) {				fps = frameNum.toString();				frameNum = 0;				previousSecondTime = time;			} else {				frameNum++;			}			cameraInfo.fpsText.text = fps+"FPS";			cameraInfo.cameraX.text = camera.x.toString();			cameraInfo.cameraY.text = camera.y.toString();			cameraInfo.cameraZ.text = camera.z.toString();		}				private function moveCameraX(angleX:Number):void {			var cosX:Number = Math.cos(angleX);			var sinX:Number = Math.sin(angleX);			camera.x = camera.x * cosX - camera.z * sinX;		}				private function moveCameraY(angleY:Number):void {			var cosY:Number = Math.cos(angleY);			var sinY:Number = Math.sin(angleY);			camera.y = camera.y * cosY - camera.z * sinY;		}			private function onEnterFrameHandler(event:Event):void {			var angleX:Number = (mouseX - vpX) * 0.0001;			var angleY:Number = (mouseY - vpY) * 0.0001;			moveCameraX(angleX);			moveCameraY(angleY);			renderer.renderScene(scene, camera, viewport);			getFPS();		}				private function onStageResizeHandler(event:Event):void {			stageW = stage.stageWidth;			stageH = stage.stageHeight;			vpX = stageW / 2;			vpY = stageH / 2;			cameraInfo.x = stageW;			cameraInfo.y = stageH;		}	}}