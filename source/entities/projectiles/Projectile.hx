package entities.projectiles;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author lion123dev
 */
class Projectile extends FlxSprite 
{
	public var IsActivated:Bool = false;
	public function HitSomeone()
	{
		kill();
	}
	public function HitTerrain()
	{
		kill();
	}
	private var _ttl:Float = 1;
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		IsActivated = true;
		TTLCheck(elapsed);
	}
	public function TTLCheck(elapsed:Float):Void
	{
		_ttl -= elapsed;
		if (_ttl <= 0)
		{
			kill();
		}
	}
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		drag.set(0, 0);
	}
	
}