package entities.enemies;

import entities.Hero;
import entities.projectiles.Projectile;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author lion123dev
 */
class BaseEnemy extends FlxSprite 
{
	public function OnHitHero(hero:Hero)
	{
		hero.Damage();
	}
	private var _facingFrozen:Bool = false;
	public function FreezeFacing(right:Bool)
	{
		_facingFrozen = true;
		facing = right?FlxObject.RIGHT : FlxObject.LEFT;
	}
	
	public function FarAwayFromPlayer(?distance:Float = 120):Bool
	{
		return (x - Reg.Player.x) > distance;
	}
	
	public function OnHitProjectile(projectile:Projectile)
	{
		projectile.HitSomeone();
		kill();
	}
	
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		acceleration.y = Reg.GRAVITY;
		drag.set(0, 0);
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);
	}
	
	public function FacePlayer():Void
	{
		if (_facingFrozen) return;
		facing = (Reg.Player.x > this.x)? FlxObject.RIGHT : FlxObject.LEFT;
	}
	
	public function OnHitGround()
	{
		
	}
}