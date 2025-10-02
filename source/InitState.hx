package;

import flixel.FlxG;
import flixel.FlxState;
import state.LuaState;

class InitState extends FlxState
{
	override public function create()
	{
		super.create();
		FlxG.switchState(new LuaState("Title"));
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
