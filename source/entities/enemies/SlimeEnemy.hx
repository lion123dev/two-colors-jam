package entities.enemies;
import flixel.FlxObject;

/**
 * ...
 * @author lion123dev
 */
class SlimeEnemy extends BaseEnemy 
{

	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.slime__png, true, 19, 17);
		animation.add("idle", [0, 1], 2);
		animation.play("idle");
		
		FacePlayer();
	}
	
}