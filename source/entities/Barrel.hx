package entities;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author lion123dev
 */
class Barrel extends FlxSprite 
{
	static var EXPLOSION_RADIUS:Float = 50;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.barrel__png, true, 8, 15);
		animation.add("idle", [0, 1], 2, true);
		animation.play("idle");
	}
	
	public function Explode()
	{
		if (Math.abs(Reg.Player.x - x) < EXPLOSION_RADIUS && Math.abs(Reg.Player.y - y) < EXPLOSION_RADIUS)
		{
			Reg.Player.Damage();
		}
		kill();
	}
}