package
{
 
	import org.papervision3d.view.BasicView;
	import org.papervision3d.core.geom.Lines3D;
	import org.papervision3d.materials.special.LineMaterial;
	import org.papervision3d.core.geom.renderables.Vertex3D;
 
	import flash.events.Event;
 
	import org.papervision3d.events.InteractiveScene3DEvent;
	import org.papervision3d.objects.DisplayObject3D;
 
	/**
	 * @author Seb Lee-Delisle
	 */
	public class Line3DHitTest extends BasicView
	{
		public var lineContainer:DisplayObject3D;
		private var lines : Array;
 
		public function Line3DHitTest()
		{
			super(stage.stageWidth, stage.stageHeight, false, true);
			init();
 
 
		}
 
		private function init():void
		{
 
			lineContainer = new DisplayObject3D("Line Container");
			lines = new Array();
 
			for(var i:int = 0; i<100; i++)
			{
				var l:Number = (Math.random()*100)+600;
				var v0:Vertex3D = new Vertex3D(-l, 0,0);
				var v1:Vertex3D = new Vertex3D(l,0,0);
 
				var lm:LineMaterial = new LineMaterial(0x8000ff,0.2);
				lm.interactive = true;
 
				var lines3D:Lines3D = new Lines3D(lm,"Lines3d#"+i);
				lines3D.addNewLine(4,v0.x,v0.y,v0.z,v1.x,v1.y,v1.z);
 
				lines3D.addEventListener(InteractiveScene3DEvent.OBJECT_OVER, lineOver);
 
				lines3D.rotationY = Math.random()*360;
				lines3D.rotationZ = Math.random()*180;
 
 
				lines3D.extra = {spin: 0};
 
				lineContainer.addChild(lines3D);
				lines.push(lines3D);
 
			}
 
			scene.addChild(lineContainer);
 
			singleRender();
 
			addEventListener(Event.ENTER_FRAME, frameLoop);
		}
 
 
 
 
		private function lineOver(e : InteractiveScene3DEvent) : void
		{
			e.displayObject3D.extra["spin"] = 5;
 
		}
 
		function frameLoop(e:Event): void
		{
 
			lineContainer.rotationY+=((stage.stageWidth/2)-mouseX)/300;
			lineContainer.rotationX+=((stage.stageHeight/2)-mouseY)/300;
			var drag:Number = 0.96;
 
			for(var i:int=0; i<lines.length; i++)
			{
				var line:Lines3D = lines[i];
				var spin:Number = line.extra["spin"];
 
				if(spin>0.1)
				{
					line.extra["spin"]*=drag;
					line.rotationY+=spin;
					var newcol:Number = (spin/5*0xff);
					line.material.lineColor = ((0x80+(newcol>>1))<<16) | (0xff);
					line.material.lineAlpha = (spin/5*0.2)+0.2;
 
 
				}
				else
				{
					line.extra["spin"] = 0;
				}
 
 
			}
 
 
			singleRender();
 
 
		}
	}
}