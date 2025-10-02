package state;

import flixel.FlxSubState;
import system.LuaObject;
import flixel.FlxState;
import system.LuaManager;
import system.Paths;

class LuaState extends FlxState
{

	// TODO SubState

	private var stateLua:LuaObject;

	public function new(script:String) {
		super();
		LuaManager.clearSprite();
		stateLua = new LuaObject(Paths.getLua("state/" + script), this);
	}

	override public function create() {
		stateLua.call("onCreate", []);
		super.create();
		stateLua.call("onCreatePost", []);
	}

	override public function update(elapsed:Float) {
		stateLua.call("onUpdate", [elapsed]);
		super.update(elapsed);
		stateLua.call("onUpdatePost", [elapsed]);
	}

	override public function destroy() {
		stateLua.call("onDestroy", []);
		stateLua.stop();
		LuaManager.clear();
		super.destroy();
	}

	override public function draw() {
		stateLua.call("onDraw", []);
		super.draw();
		stateLua.call("onDrawPost", []);
	}

	override public function onFocus() {
		stateLua.call("onFocus", []);
	}

	override public function onFocusLost() {
		stateLua.call("onFocusLost", []);
	}

	override public function onResize(width:Int, height:Int) {
		stateLua.call("onResize", [width, height]);
	}

//	override public function startOutro(onOutroComplete:() -> Void) {
//		stateLua.call("onOutro", []);
//	}

	// TODO
	override public function openSubState(subState:FlxSubState) {
		stateLua.call("onOpenSubState", [subState]);
		super.openSubState(subState);
		stateLua.call("onOpenSubStatePost", [subState]);
	}

	// TODO
	override public function closeSubState() {
		stateLua.call("onCloseSubState", [subState]);
		super.closeSubState();
		stateLua.call("onCloseSubStatePost", [subState]);
	}

	// TODO
	override public function resetSubState() {
		stateLua.call("onResetSubState", []);
		super.resetSubState();
		stateLua.call("onResetSubStatePost", []);
	}
}
