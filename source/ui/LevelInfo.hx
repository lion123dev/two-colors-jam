package ui;

/**
 * ...
 * @author lion123dev
 */
class LevelInfo 
{
	public var Index:Int;
	public var Name:String;
	public var Description:String;
	public var Weapon:WeaponType;
	public var DieToWin:Bool;
	
	public function new(index:Int, name:String, desc:String, weapon:WeaponType, dieToWin:Bool = false) 
	{
		Index = index;
		Description = desc;
		Weapon = weapon;
		Name = name;
		DieToWin = dieToWin;
	}
	
}