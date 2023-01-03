package entities.weapons;

import entities.Hero;
import entities.projectiles.PistolProjectile;
import flixel.math.FlxPoint;

/**
 * ...
 * @author lion123dev
 */
class PistolWeapon extends BaseWeapon 
{
	static var MAX_AMMO:Int = 3;
	static var RELOAD_TIME:Float = 1.2;
	static var PROJECTILE_SPEED:Float = 100;
	
	private var _reloadTimer:Float = RELOAD_TIME;
	public function new(heroAnchorPoint:FlxPoint, projectileCreatePoint:FlxPoint) 
	{
		super(heroAnchorPoint, projectileCreatePoint);
		loadGraphic(AssetPaths.pistol__png, true, 7, 6);
		
		animation.add("ammo0", [3], 1);
		animation.add("ammo1", [2], 1);
		animation.add("ammo2", [1], 1);
		animation.add("ammo3", [0], 1);
		
		_ammo = MAX_AMMO;
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		if (_ammo == MAX_AMMO)
		{
			_reloadTimer = RELOAD_TIME;
		}else{
			_reloadTimer -= elapsed;
			if (_reloadTimer <= 0)
			{
				_ammo++;
				_reloadTimer = RELOAD_TIME;
			}
		}
		animation.play("ammo" + _ammo);
	}
	
	override public function SpacePressed() 
	{
		super.SpacePressed();
		Shoot();
	}
	
	override public function Shoot():Bool 
	{
		var result:Bool = super.Shoot();
		if (result)
		{
			var pp:PistolProjectile = new PistolProjectile(0, 0);
			SetProjectilePosition(pp);
			pp.velocity.x = PROJECTILE_SPEED;
			ProjectileCreateCallback(pp);
		}
		return result;
	}
	
}