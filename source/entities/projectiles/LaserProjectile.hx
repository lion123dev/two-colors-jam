package entities.projectiles;
import entities.weapons.BaseWeapon;

/**
 * ...
 * @author lion123dev
 */
class LaserProjectile extends Projectile 
{
	var _weapon:BaseWeapon;
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.laserbeam__png, true, 50, 5);
		animation.add("anim", [0, 1, 2, 3], 10);
		animation.play("anim");
	}
	
	override public function HitSomeone() 
	{
		//Piercing
		//super.HitSomeone();
	}
	
	override public function HitTerrain() 
	{
		//Piercing too!
		//super.HitTerrain();
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		if (_weapon != null)
		{
			_weapon.SetProjectilePosition(this);
		}
	}
	
	override public function TTLCheck(elapsed:Float):Void 
	{
		//Do nothing
	}
	
	public function SetParentLaser(w:BaseWeapon)
	{
		_weapon = w;
	}
	
}