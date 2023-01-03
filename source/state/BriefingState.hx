package state;
import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxAxes;
import ui.LevelInfo;
import ui.SimpleButton;
/**
 * ...
 * @author lion123dev
 */
class BriefingState extends FlxState 
{
	var info:LevelInfo;
	var charIndex:Int = 0;
	
	var descText:FlxText;
	override public function create():Void 
	{
		if (FlxG.sound.music != null)
		{
			FlxG.sound.music.stop();
		}
		FlxG.sound.playMusic(AssetPaths.c4__ogg, 0.5);
		//TODO: add stuff
		super.create();
		bgColor = Reg.BLACK_COLOR;
		info = Reg.GetLevelInfo();
		
		var nameText:FlxText = new FlxText(0, 0, FlxG.width, info.Index + ". " + info.Name, 16);
		nameText.color = Reg.WHITE_COLOR;
		nameText.alignment = FlxTextAlign.CENTER;
		nameText.screenCenter(FlxAxes.X);
		
		var weaponTxt:FlxText = new FlxText(0, nameText.y + nameText.height, FlxG.width, "Weapon: " + info.Weapon);
		weaponTxt.color = Reg.WHITE_COLOR;
		
		descText = new FlxText(0, weaponTxt.y + weaponTxt.height, FlxG.width, "");
		descText.color = Reg.WHITE_COLOR;
		descText.alignment = FlxTextAlign.CENTER;
		descText.screenCenter(FlxAxes.X);
		
		var back:SimpleButton = new SimpleButton(24, FlxG.height - 12 - 4, "Back", GoBack);
		var play:SimpleButton = new SimpleButton(FlxG.width-34-24, FlxG.height-12-4, "Play", GoPlay);
		
		add(nameText);
		add(descText);
		add(weaponTxt);
		add(back);
		add(play);
	}
	public function GoPlay()
	{
		FlxG.switchState(new PlayState());
	}
	public function GoBack()
	{
		FlxG.switchState(new MenuState());
	}
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		charIndex++;
		descText.text = info.Description.substr(0, charIndex);
	}
	public function new() 
	{
		super();
	}
	
}