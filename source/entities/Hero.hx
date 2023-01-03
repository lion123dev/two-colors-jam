package entities;

import entities.projectiles.Projectile;
import entities.weapons.BaseWeapon;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.input.keyboard.FlxKeyboard;
import flixel.system.FlxAssets.FlxGraphicAsset;
import state.BriefingState;

/**
 * ...
 * @author lion123dev
 */
class Hero extends FlxSprite 
{
	static var SPEED:Float = 30;
	public var Lives:Int = 3;
	
	private var _weapon:BaseWeapon;
	private var _invulnerable:Bool;
	
	private var _invulnerableTimer:Float;
	
	public function Damage()
	{
		if (_invulnerable) return;
		_invulnerableTimer = Reg.INVULNERABLE_TIMER;
		_invulnerable = true;
		Lives--;
		if (Lives <= 0)
		{
			if (Reg.GetLevelInfo().DieToWin)
			{
				Reg.Win();
			}else{
				Reg.Lose();
			}
		}else{
			animation.play("inv", true);
		}
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		velocity.x = SPEED;
		if (_invulnerable)
		{
			_invulnerableTimer -= elapsed;
			if (_invulnerableTimer <= 0)
			{
				_invulnerable = false;
				animation.play("idle");
			}
		}
		if (FlxG.keys.justPressed.SPACE)
		{
			_weapon.SpacePressed();
			if(!_invulnerable)
				animation.play("shoot");
		}
		if (FlxG.keys.justReleased.SPACE)
		{
			_weapon.SpaceReleased();
			if(!_invulnerable)
				animation.play("idle"); 
		}
	}
	
	public function AddWeapon(weapon:BaseWeapon)
	{
		_weapon = weapon;
	}
	
	public function OnProjectileHit(p:Projectile)
	{
		Damage();
		p.kill();
	}
	
	public function new(X:Float, Y:Float) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.hero__png, true, 14, 16);
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		
		animation.add("idle", [0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 1, 2], 3, true);
		animation.add("shoot", [3], 1);
		animation.add("inv", [0, 9], 6, true);
		
		animation.play("idle");
		
		acceleration.y = Reg.GRAVITY;
		drag.set(0, 0);
	}
	
}