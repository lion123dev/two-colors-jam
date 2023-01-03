package;

import flixel.FlxG;
import flixel.FlxGame;
import flixel.input.mouse.FlxMouse;
import openfl.display.Sprite;
import state.MenuState;

class Main extends Sprite
{
	public function new()
	{
		super();
		Reg.Init();
		addChild(new FlxGame(0, 0, MenuState, 2, 60, 60, true));
		FlxG.mouse.useSystemCursor = true;
	}
}
