﻿package {	import flash.display.*;	import flash.events.*;		import org.papervision3d.scenes.Scene3D;	import org.papervision3d.objects.DisplayObject3D;	import org.papervision3d.objects.primitives.Plane;	import org.papervision3d.cameras.Camera3D;	import org.papervision3d.view.Viewport3D;	import org.papervision3d.render.BasicRenderEngine;	import org.papervision3d.materials.WireframeMaterial;	[SWF(width="1024", height="568", backgroundColor="#333333", frameRate="50")]	public class Main extends Sprite {					private var scene:Scene3D;		private var camera:Camera3D;		private var viewport:Viewport3D;		private var renderer:BasicRenderEngine;		private var stageW:Number;		private var stageH:Number;		private var vpX:Number;		private var vpY:Number;				public function Main () {						init();		}			private function init():void {			setStage();			setScene();			setCamera();			setDO3D();						addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);		}				private function setStage():void {			stage.quality = StageQuality.MEDIUM;			stage.scaleMode = StageScaleMode.NO_SCALE;			stage.align = StageAlign.TOP_LEFT;			stageW = stage.stageWidth;			stageH = stage.stageHeight;			vpX = stageW / 2;			vpY = stageH / 2;		}				private function setScene():void{			renderer = new BasicRenderEngine();			scene = new Scene3D();			viewport  = new Viewport3D(0, 0, true, true);			addChild(viewport);		}				private function setCamera():void {			camera = new Camera3D();			camera.x = 0;			camera.y = 0;			camera.z = -500;			camera.zoom = 30;			camera.focus = 30;			camera.target = DisplayObject3D.ZERO;		}				private function setDO3D():void {			var material:WireframeMaterial = new WireframeMaterial(0xCCCCCC, 1);			material.oneSide = false;			var plane:Plane = new Plane(material, 200, 200, 4, 4);			scene.addChild(plane);		}			private function onEnterFrameHandler(event:Event):void {			renderer.renderScene(scene, camera, viewport);		}	}}