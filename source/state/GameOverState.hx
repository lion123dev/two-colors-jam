package state;

import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxAxes;
import ui.LevelInfo;
import ui.SimpleButton;
import flixel.FlxState;

/**
 * ...
 * @author lion123dev
 */
class GameOverState extends FlxState 
{

	public function new() 
	{
		super();
		bgColor = Reg.BLACK_COLOR;
		
		var nameText:FlxText = new FlxText(0, 0, FlxG.width, "Congratulations!", 16);
		nameText.color = Reg.WHITE_COLOR;
		nameText.alignment = FlxTextAlign.CENTER;
		nameText.screenCenter(FlxAxes.X);
		
		var descText:FlxText = new FlxText(0, nameText.y + nameText.height, FlxG.width, "You stopped all the intruders from stealing from your corporation! Now it will continue to dominate in weapon production industry, killing millions of people. And you won't even be remembered.");
		descText.color = Reg.WHITE_COLOR;
		descText.alignment = FlxTextAlign.CENTER;
		descText.screenCenter(FlxAxes.X);
		
		var back:SimpleButton = new SimpleButton(24, FlxG.height - 12 - 4, "Back", GoBack);
		
		add(nameText);
		add(descText);
		add(back);
	}
	
	private function GoBack()
	{
		FlxG.switchState(new MenuState());
	}
	
}