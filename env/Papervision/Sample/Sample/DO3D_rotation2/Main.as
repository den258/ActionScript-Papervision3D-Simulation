﻿package {	import flash.display.*;	import flash.events.*;	import flash.utils.*;		import org.papervision3d.scenes.Scene3D;	import org.papervision3d.objects.DisplayObject3D;	import org.papervision3d.objects.primitives.*;	import org.papervision3d.cameras.*;	import org.papervision3d.view.Viewport3D;	import org.papervision3d.render.BasicRenderEngine;	import org.papervision3d.materials.*;	import org.papervision3d.materials.utils.MaterialsList;	import org.papervision3d.core.geom.Lines3D;	import org.papervision3d.materials.special.LineMaterial;	[SWF(width="1024", height="568", backgroundColor="#CCCCCC", frameRate="50")]	public class Main extends Sprite {			private var scene:Scene3D;		private var camera:Camera3D;		private var viewport:Viewport3D;		private var renderer:BasicRenderEngine;		private var container:DisplayObject3D;		private var cube:Cube;				private var stageW:Number;		private var stageH:Number;		private var vpX:Number;		private var vpY:Number;				private var cameraInfo:CameraInfo;			private var time:Number = 0;		private var secondTime:Number = 0;		private var previousSecondTime:Number = 0;		private var frameNum:Number = 0;		private var fps:String = "...";				// -- SWC書き出しのためのインスタンス化 Start -- //		private var m_1:Back = new Back();		private var m_2:Bottom = new Bottom();		private var m_3:Front = new Front();		private var m_4:Left = new Left();		private var m_5:Right = new Right();		private var m_6:Top = new Top();		// -- SWC書き出しのためのインスタンス化 End -- //				public function Main () {						init();		}			private function init():void {			setStage();			setScene();			setCamera();			setDO3D();			setCameraInfo();						addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);			stage.addEventListener(Event.RESIZE, onStageResizeHandler);		}				private function setStage():void {			stage.quality = StageQuality.MEDIUM;			stage.scaleMode = StageScaleMode.NO_SCALE;			stage.align = StageAlign.TOP_LEFT;			stageW = stage.stageWidth;			stageH = stage.stageHeight;			vpX = stageW / 2;			vpY = stageH / 2;		}				private function setCameraInfo():void {			cameraInfo = new CameraInfo();			addChild(cameraInfo);			stageW = stage.stageWidth;			stageH = stage.stageHeight;			vpX = stageW / 2;			vpY = stageH / 2;			cameraInfo.x = stageW;			cameraInfo.y = stageH;		}				private function setScene():void{			renderer = new BasicRenderEngine();			scene = new Scene3D();			viewport  = new Viewport3D(0, 0, true, true);			addChild(viewport);		}				private function setCamera():void {			camera = new Camera3D();			camera.x = 0;			camera.y = 600;			camera.z = -1400;			camera.zoom = 30;			camera.focus = 30;		}				private function setDO3D():void {			container = new DisplayObject3D();			scene.addChild(container);						var materialPlane:WireframeMaterial = new WireframeMaterial(0x666666, 1);			materialPlane.oneSide = false;			var plane:Plane = new Plane(materialPlane, 3000, 3000, 8, 8);			plane.rotationX = 90;			scene.addChild(plane);						var materialList:MaterialsList = new MaterialsList({				front: new MovieAssetMaterial("Front", true ),				back: new MovieAssetMaterial("Back", true ),				right: new MovieAssetMaterial("Right", true ),				left: new MovieAssetMaterial("Left", true ),				top: new MovieAssetMaterial("Top", true ),				bottom: new MovieAssetMaterial("Bottom", true )			});			cube = new Cube(materialList, 200, 200, 200, 6, 6, 6);			cube.x = 0;			cube.y = 350;			cube.z = 1000;			cube.rotationY = 90;			container.addChild(cube);			camera.target = cube;			setAxes();		}				private function setAxes():void {			var axisX:Lines3D = new Lines3D(new LineMaterial(0x00FF00));			cube.addChild(axisX);			axisX.addNewLine(2, 100, 0, 0, 200, 0, 0);			var axisY:Lines3D = new Lines3D(new LineMaterial(0x0000FF));			cube.addChild(axisY);			axisY.addNewLine(2, 0, 100, 0, 0, 200, 0);			var axisZ:Lines3D = new Lines3D(new LineMaterial(0xFF0000));			cube.addChild(axisZ);			axisZ.addNewLine(2, 0, 0, 100, 0, 0, 200);		}				private function getFPS():void {			time = getTimer();			secondTime = time - previousSecondTime;			if(secondTime >= 1000) {				fps = frameNum.toString();				frameNum = 0;				previousSecondTime = time;			} else {				frameNum++;			}			cameraInfo.fpsText.text = fps+"FPS";			cameraInfo.cameraX.text = camera.x.toString();			cameraInfo.cameraY.text = camera.y.toString();			cameraInfo.cameraZ.text = camera.z.toString();						cameraInfo.cubeRotationX.text = cube.rotationX.toString();			cameraInfo.cubeRotationY.text = cube.rotationY.toString();			cameraInfo.cubeRotationZ.text = cube.rotationZ.toString();			cameraInfo.cubeSceneX.text = cube.sceneX.toString();			cameraInfo.cubeSceneY.text = cube.sceneY.toString();			cameraInfo.cubeSceneZ.text = cube.sceneZ.toString();			cameraInfo.cubePosition.text = cube.position.toString();			cameraInfo.cubeX.text = cube.x.toString();			cameraInfo.cubeY.text = cube.y.toString();			cameraInfo.cubeZ.text = cube.z.toString();		}			private function onEnterFrameHandler(event:Event):void {			motionDO3D();			renderer.renderScene(scene, camera, viewport);			getFPS();		}				private function onStageResizeHandler(event:Event):void {			stageW = stage.stageWidth;			stageH = stage.stageHeight;			vpX = stageW / 2;			vpY = stageH / 2;			cameraInfo.x = stageW;			cameraInfo.y = stageH;		}				private function motionDO3D():void {			container.rotationY += 1;		}	}}