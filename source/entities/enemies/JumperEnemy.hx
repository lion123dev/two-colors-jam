package entities.enemies;
import flixel.FlxObject;

/**
 * ...
 * @author lion123dev
 */
class JumperEnemy extends BaseEnemy 
{
	static var JUMP_TIMER = 1.5;
	static var JUMP_XSPEED = 30;
	static var JUMP_YSPEED = -80;
	
	private var _isJumping:Bool = false;
	private var _jumpTimer:Float = 0;
	
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.jumper__png, true, 10, 20);
		
		animation.add("idle", [0]);
		animation.add("jump", [0, 1, 2], 3, false);
		FacePlayer();
		_jumpTimer = Random.float(0, 2);
	}
	
	override public function update(elapsed:Float):Void 
	{
		
		if (!FarAwayFromPlayer(140)){
			_jumpTimer -= elapsed;
			if (_isJumping == false)
			{
				if (_jumpTimer <= 0)
				{
					animation.play("jump", true);
					_isJumping = true;
					//Duration of the animation
					_jumpTimer = 1;
				}
			}else{
				if (_jumpTimer <= 0)
				{
					animation.play("idle");
					var xSpeed:Float = (facing == FlxObject.LEFT) ? -JUMP_XSPEED:JUMP_XSPEED;
					velocity.set(xSpeed, JUMP_YSPEED);
					_jumpTimer = JUMP_TIMER + Random.float(0, 1);
					_isJumping = false;
				}
			}
		}
		super.update(elapsed);
	}
	
	override public function OnHitGround() 
	{
		super.OnHitGround();
		velocity.x = 0;
	}
	
}