package entities.projectiles;

/**
 * ...
 * @author lion123dev
 */
class PistolProjectile extends Projectile 
{

	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y);
		_ttl = 1;
		makeGraphic(2, 2, Reg.BLACK_COLOR);
	}
	
}