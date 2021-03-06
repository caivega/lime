package lime.graphics;


import lime.app.Event;
import lime.ui.Window;


class Renderer {
	
	
	public var context:RenderContext;
	public var onRenderContextLost = new Event<Void->Void> ();
	public var onRenderContextRestored = new Event<RenderContext->Void> ();
	public var onRender = new Event<RenderContext->Void> ();
	public var window:Window;
	
	@:noCompletion private var backend:RendererBackend;
	
	
	public function new (window:Window) {
		
		this.window = window;
		
		backend = new RendererBackend (this);
		
		this.window.currentRenderer = this;
		
	}
	
	
	public function create ():Void {
		
		backend.create ();
		
	}
	
	
	public function flip ():Void {
		
		backend.flip ();
		
	}
	
	
	private function render ():Void {
		
		backend.render ();
		
	}
	
	
}


#if flash
@:noCompletion private typedef RendererBackend = lime._backend.flash.FlashRenderer;
#elseif (js && html5)
@:noCompletion private typedef RendererBackend = lime._backend.html5.HTML5Renderer;
#else
@:noCompletion private typedef RendererBackend = lime._backend.native.NativeRenderer;
#end