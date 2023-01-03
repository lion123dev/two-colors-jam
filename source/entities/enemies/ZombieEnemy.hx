package entities.enemies;
import entities.Hero;
import flixel.FlxObject;

/**
 * ...
 * @author lion123dev
 */
class ZombieEnemy extends BaseEnemy 
{
	static var MAX_SPEED:Float = 70;
	static var MIN_SPEED:Float = 50;
	
	private var _speed:Float;
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.zombie__png, true, 11, 19);
		animation.add("z0", [0], 1, false);
		animation.add("z1", [1], 1, false);
		animation.add("z2", [2], 1, false);
		
		animation.play(Random.fromArray(["z0", "z1", "z2"]));
		
		_speed = Random.float(MIN_SPEED, MAX_SPEED);
	}
	
	override public function OnHitHero(hero:Hero) 
	{
		super.OnHitHero(hero);
		kill();
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		if (FarAwayFromPlayer())
		{
			velocity.x = 0;
			return;
		}
		FacePlayer();
		velocity.x = (facing == FlxObject.LEFT)? -_speed:_speed;
	}
	
}