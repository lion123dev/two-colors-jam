package entities.weapons;

import entities.Hero;
import entities.projectiles.Projectile;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author lion123dev
 */
class BaseWeapon extends FlxSprite 
{
	private var _heroAnchorPoint:FlxPoint;
	private var _projectileCreatePosition:FlxPoint;
	private var _ammo:Int = 0;
	
	private var _space:Bool = false;
	
	public var ProjectileCreateCallback:Projectile-> Void;
	
	public function SpacePressed()
	{
		_space = true;
	}
	public function SpaceReleased()
	{
		_space = false;
	}
	public function Shoot():Bool
	{
		if (_ammo <= 0)
			return false;
		_ammo -= 1;
		return true;
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		x = Reg.Player.x + _heroAnchorPoint.x;
		y = Reg.Player.y + _heroAnchorPoint.y;
	}
	
	public function new(heroAnchorPoint:FlxPoint, projectileCreatePoint:FlxPoint) 
	{
		_heroAnchorPoint = heroAnchorPoint;
		_projectileCreatePosition = projectileCreatePoint;
		super(_heroAnchorPoint.x, _heroAnchorPoint.y);
	}
	
	public function SetProjectilePosition(p:Projectile)
	{
		p.setPosition(Reg.Player.x + _projectileCreatePosition.x, Reg.Player.y + _projectileCreatePosition.y);
	}
}