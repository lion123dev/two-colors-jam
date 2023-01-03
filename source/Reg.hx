package;
import entities.Hero;
import entities.projectiles.CannonProjectile;
import entities.weapons.BaseWeapon;
import entities.weapons.CannonWeapon;
import entities.weapons.LaserWeapon;
import entities.weapons.PistolWeapon;
import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxSave;
import state.BriefingState;
import state.GameOverState;
import ui.LevelInfo;

/**
 * ...
 * @author lion123dev
 */
class Reg 
{
	public static var LastMadeLevel:Int = 0;
	
	
	public static var Player:Hero;
	public static var CurrentLevel:Int = 0;
	public static var MAX_LEVEL:Int = 9;
	public static var INVULNERABLE_TIMER:Float = 2.5;
	public static var GRAVITY:Float = 150;
	public static var BLACK_COLOR:FlxColor = FlxColor.fromRGB(44, 44, 44);
	public static var WHITE_COLOR:FlxColor = FlxColor.fromRGB(214, 255, 250);
	
	public static var Save:FlxSave;
	
	private static var _levels:Array<LevelInfo>;
	
	public static function Init():Void
	{
		_levels = new Array();
		_levels.push(new LevelInfo(0, "Tutorial", "Oh no! We messed up big time! Quick, turn on manual control. Press SPACE when there are hazards to the user of our gun, don't let him die", WeaponType.Pistol));
		_levels.push(new LevelInfo(1, "Plains", "Thank God that was just a pistol. Our company makes cannons too, they are impossible to aim.", WeaponType.Pistol));
		_levels.push(new LevelInfo(2, "Cave", "The goal of the company is to provide self-taught guns that know when to shoot better than you do   ...   I hate company meetings", WeaponType.Pistol));
		_levels.push(new LevelInfo(3, "Cannon test", "Crap, they sold a malfunctioning cannon! Guess I'll have to control it manually myself too. Wait, what is it? Zombie apocalypse?", WeaponType.Cannon));
		_levels.push(new LevelInfo(4, "Descent", "Here at Space Industries, we've developed a brand new weapon   ...   It's a recharging flamethrower ... If only they knew...", WeaponType.Cannon));
		_levels.push(new LevelInfo(5, "In Flames", "Those entrances they go in look familiar. Where could I see them?   ...   Nevermind, it's a flamethrower now. Fire!", WeaponType.Flamethrower));
		_levels.push(new LevelInfo(6, "In Flames II", "To think about it, is machine learning better than me controlling when to shoot? Both work on neural networks.", WeaponType.Flamethrower));
		
		_levels.push(new LevelInfo(7, "Space Industries", "Oh f**k, they're going right inside the Space Industries facilities! I have to stop them, the whole company is in danger!", WeaponType.Pistol, true));
		_levels.push(new LevelInfo(8, "Explosives", "There should be some explosives in the facility.", WeaponType.Cannon, true));
		_levels.push(new LevelInfo(9, "In Flames III", "I'm pretty sure the protocol allows user's death to prevent greater danger.", WeaponType.Flamethrower, true));
		
		Save = new FlxSave();
		if (!Save.bind("_lion123_BlackWhite")){
			SaveGame();
		}else{
			LoadGame();
		}
	}
	
	public static function Win()
	{
		if (CurrentLevel == MAX_LEVEL)
		{
			FlxG.switchState(new GameOverState());
		}else{
			CurrentLevel++;
			SaveGame();
			FlxG.switchState(new BriefingState());
		}
	}
	public static function Lose()
	{
		FlxG.switchState(new BriefingState());
	}
	
	public static function GetLevelInfo():LevelInfo
	{
		return _levels[CurrentLevel];
	}
	
	public static function SaveGame():Void
	{
		Save.data.level = CurrentLevel;
		Save.flush();
	}
	public static function LoadGame():Void
	{
		CurrentLevel = Save.data.level;
	}
	
	public static function GetWeapon(wt:WeaponType):BaseWeapon
	{
		switch(wt)
		{
			case WeaponType.Pistol:
				return new PistolWeapon(new FlxPoint(12, 2), new FlxPoint(17, 3));
			case WeaponType.Cannon:
				return new CannonWeapon(new FlxPoint(12, 0), new FlxPoint(13, 0));
			case WeaponType.Flamethrower:
				return new LaserWeapon(new FlxPoint(10, 1), new FlxPoint(29, 2));
		}
		return null;
	}
	
	public function new() 
	{
		
	}
	
}
