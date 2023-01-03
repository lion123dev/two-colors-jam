package entities.projectiles;

/**
 * ...
 * @author lion123dev
 */
class CannonProjectile extends Projectile 
{

	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		_ttl = 10;
		makeGraphic(3, 3, Reg.BLACK_COLOR);
		acceleration.y = Reg.GRAVITY;
	}
	
	override public function HitSomeone() 
	{
		//Piercing
		//super.HitSomeone();
	}
}