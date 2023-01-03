package state;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxAxes;
import ui.SimpleButton;

/**
 * ...
 * @author lion123dev
 */
class MenuState extends FlxState 
{

	override public function create():Void 
	{
		if (FlxG.sound.music == null)
		{
			FlxG.sound.playMusic(AssetPaths.c4__ogg, 0.5);
		}
		
		this.bgColor = Reg.BLACK_COLOR;
		var titleText:FlxText = new FlxText(0, 0, 200, "Space Industries weapons", 16);
		titleText.color = Reg.WHITE_COLOR;
		titleText.alignment = FlxTextAlign.CENTER;
		titleText.screenCenter(FlxAxes.X);
		var descText:FlxText = new FlxText(0, titleText.y + titleText.height + 2, FlxG.width, "Made for 2 Colors Game Jam in 48 hours by @lion123dev");
		descText.color = Reg.WHITE_COLOR;
		descText.alignment = FlxTextAlign.CENTER;
		descText.screenCenter(FlxAxes.X);
		
		var start:SimpleButton = new SimpleButton(FlxG.width / 2 - 17, descText.y + descText.height+2, "Start", StartGame);
		var cont:SimpleButton = new SimpleButton(FlxG.width / 2 - 17, descText.y + descText.height + 16, "Cont.", ContinueGame);
		
		add(titleText);
		add(descText);
		add(start);
		
		if(Reg.CurrentLevel > 0)
			add(cont);
		
		super.create();
	}
	/*
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		if (FlxG.keys.justPressed.N)
		{
			Reg.CurrentLevel = 0;
		}
		if (FlxG.keys.justPressed.M)
		{
			Reg.CurrentLevel++;
		}
	}
	*/
	public function StartGame():Void
	{
		Reg.CurrentLevel = Reg.LastMadeLevel;
		FlxG.switchState(new BriefingState());
	}
	public function ContinueGame()
	{
		FlxG.switchState(new BriefingState());
	}
	public function new() 
	{
		super();
	}
	
}