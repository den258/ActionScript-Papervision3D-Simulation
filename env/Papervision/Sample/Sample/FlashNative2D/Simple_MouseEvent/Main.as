﻿package {	import flash.display.*;	import flash.events.*;	[SWF(width="400", height="400", backgroundColor="#333333", frameRate="50")]	public class Main extends Sprite {				private var A:Sprite;		private var stageW:Number;		private var stageH:Number;		private var vpX:Number;		private var vpY:Number;				public function Main () {						init();		}			private function init():void {			stage.quality = StageQuality.MEDIUM;			stage.scaleMode = StageScaleMode.NO_SCALE;			stage.align = StageAlign.TOP_LEFT;						A = drawRectangle(100, 100, 0xCCCCCC);						stageW = stage.stageWidth;			stageH = stage.stageHeight;			vpX = stageW / 2;			vpY = stageH / 2;						A.x = vpX;			A.y = vpY;			A.doubleClickEnabled = true;			A.buttonMode = true;			addChild(A);						stage.addEventListener(Event.RESIZE, onStageResizeHandler);			A.addEventListener(MouseEvent.CLICK, onMouseEventHandler);			A.addEventListener(MouseEvent.DOUBLE_CLICK, onMouseEventHandler);			A.addEventListener(MouseEvent.ROLL_OVER, onMouseEventHandler);			A.addEventListener(MouseEvent.ROLL_OUT, onMouseEventHandler);			A.addEventListener(MouseEvent.MOUSE_DOWN, onMouseEventHandler);			A.addEventListener(MouseEvent.MOUSE_MOVE, onMouseEventHandler);			A.addEventListener(MouseEvent.MOUSE_UP, onMouseEventHandler);		}			private function drawRectangle (w:Number=50, h:Number=50, color:uint=0xff0000):Sprite {			var R:Sprite = new Sprite();			R.graphics.beginFill(color);			R.graphics.drawRect(-w/2,-h/2,w,h);			R.graphics.endFill();			return R;		}				private function onStageResizeHandler(event:Event):void {			stageW = stage.stageWidth;			stageH = stage.stageHeight;			vpX = stageW / 2;			vpY = stageH / 2;			A.x = vpX;			A.y = vpY;		}				private function onMouseEventHandler(event:MouseEvent):void {			trace(event.type);		}	}}