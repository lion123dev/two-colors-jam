package entities.weapons;

import entities.projectiles.CannonProjectile;
import flixel.math.FlxPoint;

/**
 * ...
 * @author lion123dev
 */
class CannonWeapon extends BaseWeapon 
{
	static var PROJECTILE_SPEED:Float = -100;
	static var PROJECTILE_SPEED_INCREASE:Float = -25;
	static var MAX_CHARGE:Int = 3;
	static var RELOAD_TIMER:Float = 1;
	static var CHARGE_TIMER:Float = 0.4;
	
	var _reloadTimer:Float=RELOAD_TIMER;
	var _charge:Int=0;
	var _chargeTimer:Float=CHARGE_TIMER;
	
	public function new(heroAnchorPoint:FlxPoint, projectileCreatePoint:FlxPoint) 
	{
		super(heroAnchorPoint, projectileCreatePoint);
		loadGraphic(AssetPaths.cannon__png, true, 5, 12);
		
		animation.add("idle", [0], 1, false);
		animation.add("reload", [4], 1, false);
		
		for (i in 0...MAX_CHARGE)
		{
			animation.add("charge" + i, [1 + i], 1, false);
		}
		
		_ammo = 1;
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		if (_ammo == 0)
		{
			_reloadTimer -= elapsed;
			if (_reloadTimer <= 0)
			{
				_ammo++;
				_reloadTimer = RELOAD_TIMER;
			}
		}
		if (_ammo == 1 && _space)
		{
			_chargeTimer -= elapsed;
			if (_chargeTimer <= 0)
			{
				_chargeTimer = CHARGE_TIMER;
				_charge++;
				if (_charge >= MAX_CHARGE)
					_charge = MAX_CHARGE-1;
			}
			animation.play("charge" + _charge);
			
		}else{
			if (_ammo == 0)
			{
				animation.play("reload");
			}else{
				animation.play("idle");
			}
		}
	}
	
	override public function SpacePressed() 
	{
		super.SpacePressed();
		_charge = 0;
		_chargeTimer = CHARGE_TIMER;
	}
	
	override public function Shoot():Bool 
	{
		var result:Bool = super.Shoot();
		if (result)
		{
			var pp:CannonProjectile = new CannonProjectile(0, 0);
			SetProjectilePosition(pp);
			pp.velocity.y = PROJECTILE_SPEED + PROJECTILE_SPEED_INCREASE * _charge;
			
			ProjectileCreateCallback(pp);
		}
		return result;
	}
	
	override public function SpaceReleased() 
	{
		super.SpaceReleased();
		Shoot();
	}
	
}