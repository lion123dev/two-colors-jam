package ui;

import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

/**
 * ...
 * @author lion123dev
 */
class SimpleButton extends FlxGroup 
{

	public function new(X:Float=0, Y:Float=0, ?Text:String, ?OnClick:Void->Void) 
	{
		super();
		var btn:FlxButton = new FlxButton(X, Y, null, OnClick);
		btn.loadGraphic(AssetPaths.button__png, true, 34, 12);
		var txt:FlxText = new FlxText(X, Y-1, 30, Text);
		txt.color = Reg.WHITE_COLOR;
		txt.alignment = FlxTextAlign.CENTER;
		
		add(btn);
		add(txt);
	}
	
}