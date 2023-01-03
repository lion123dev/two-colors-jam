package entities.weapons;

import entities.projectiles.LaserProjectile;
import flixel.math.FlxPoint;

/**
 * ...
 * @author lion123dev
 */
class LaserWeapon extends BaseWeapon 
{
	static var MAX_AMMO:Int = 8;
	static var TIME_FOR_CHARGE:Float = 0.6;
	static var TIME_TO_RECHARGE:Float = 0.5;
	
	static var OVERHEAT_TIME:Float = 3;
	
	var _beam:LaserProjectile = null;
	var _chargeTimer:Float = 0;
	var _rechargeTimer:Float = 0;
	
	public function new(heroAnchorPoint:FlxPoint, projectileCreatePoint:FlxPoint) 
	{
		super(heroAnchorPoint, projectileCreatePoint);
		loadGraphic(AssetPaths.laser__png, true, 19, 10);
		
		for (i in 0...MAX_AMMO)
		{
			animation.add("ammo" + (8-i), [i], 1, false);
		}
		
		animation.add("ammo0", [8, 9, 10], 10, true);
		_ammo = MAX_AMMO;
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		if (_space)
		{
			SetProjectilePosition(_beam);
			_chargeTimer -= elapsed;
			if (_chargeTimer <= 0)
			{
				if (_ammo <= 0)
				{
					StopShooting();
					_space = false;
				}else{
					_ammo--;
					_chargeTimer = TIME_FOR_CHARGE;
				}
			}
		}else{
			_rechargeTimer -= elapsed;
			if (_rechargeTimer <= 0)
			{
				_rechargeTimer = TIME_TO_RECHARGE;
				if (_ammo < MAX_AMMO)
					_ammo++;
			}
		}
		animation.play("ammo" + _ammo);
	}
	
	private function StopShooting()
	{
		if (_beam.alive)
			_beam.kill();
		if(_ammo > 0)
			_rechargeTimer = TIME_TO_RECHARGE;
		else
			_rechargeTimer = OVERHEAT_TIME;
	}
	
	override public function SpacePressed() 
	{
		super.SpacePressed();
		if (Shoot())
		{
			if (_beam == null){
				_beam = new LaserProjectile();
				_beam.SetParentLaser(this);
				ProjectileCreateCallback(_beam);
			}else{
				_beam.revive();
			}
			SetProjectilePosition(_beam);
			_chargeTimer = TIME_FOR_CHARGE;
		}
	}
	
	override public function SpaceReleased() 
	{
		super.SpaceReleased();
		StopShooting();
	}
}