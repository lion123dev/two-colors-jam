package;

import entities.Barrel;
import entities.Hero;
import entities.enemies.BaseEnemy;
import entities.enemies.JumperEnemy;
import entities.enemies.SlimeEnemy;
import entities.enemies.ZombieEnemy;
import entities.projectiles.Projectile;
import entities.weapons.BaseWeapon;
import flixel.FlxBasic;
import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.tiled.TiledLayer;
import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxAssets.FlxTilemapGraphicAsset;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import state.BriefingState;
import state.GameOverState;
import ui.LevelInfo;

class PlayState extends FlxState
{
	var _tilemap:FlxTilemap;
	var _enemies:FlxTypedGroup<BaseEnemy>;
	var _projectiles:FlxTypedGroup<Projectile>;
	var _explosives:FlxTypedGroup<Barrel>;
	var _exit:FlxSprite;
	
	var _lifeCounter:FlxText;
	
	var _weapon:BaseWeapon;
	var _hero:Hero;
	
	var levelInfo:LevelInfo;
	override public function create():Void
	{
		if (FlxG.sound.music != null)
		{
			FlxG.sound.music.stop();
		}
		FlxG.sound.playMusic(AssetPaths.c3__ogg, 0.8);
		
		levelInfo = Reg.GetLevelInfo();
		super.create();
		
		bgColor = Reg.WHITE_COLOR;
		
		//New everything
		_hero = new Hero(10, 10);
		Reg.Player = _hero;
		_weapon = Reg.GetWeapon(levelInfo.Weapon);
		_weapon.ProjectileCreateCallback = ProjectileCreateCallback;
		_hero.AddWeapon(_weapon);
		
		_enemies = new FlxTypedGroup();
		_projectiles = new FlxTypedGroup();
		_explosives = new FlxTypedGroup();
		
		var lifeIcon:FlxSprite = new FlxSprite(4, 4, AssetPaths.life__png);
		lifeIcon.scrollFactor.set(0, 0);
		_lifeCounter = new FlxText(lifeIcon.x + lifeIcon.width + 2, 2, 20, "x3");
		_lifeCounter.scrollFactor.set(0, 0);
		_lifeCounter.color = Reg.BLACK_COLOR;
		var lifeBacking:FlxSprite = new FlxSprite(_lifeCounter.x, _lifeCounter.y);
		lifeBacking.makeGraphic(Std.int(_lifeCounter.width), Std.int(_lifeCounter.height), Reg.WHITE_COLOR);
		lifeBacking.scrollFactor.set(0, 0);
		LoadMap("assets/data/level" + levelInfo.Index + ".tmx");
		
		add(_exit);
		add(_tilemap);
		add(_enemies);
		add(_explosives);
		add(_projectiles);
		add(_hero);
		add(_weapon);
		
		//Add UI (topmost)
		add(lifeBacking);
		add(lifeIcon);
		add(_lifeCounter);
		
		FlxG.camera.follow(_hero, FlxCameraFollowStyle.PLATFORMER, 1);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		FlxG.collide(_hero, _tilemap);
		FlxG.collide(_enemies, _tilemap, EnemyHitTerrain); 
		
		FlxG.overlap(_enemies, _projectiles, enemyHit);
		
		FlxG.overlap(_hero, _enemies, bumpEnemy);
		
		_projectiles.forEachAlive(checkBulletHitTerrain);
		
		FlxG.overlap(_hero, _exit, ReachExit);
		FlxG.overlap(_projectiles, _explosives, HitBarrel);
		
		_lifeCounter.text = "x" + _hero.Lives;
	}
	private function HitBarrel(p:Projectile, b:Barrel)
	{
		p.HitTerrain();
		b.Explode();
	}
	private function EnemyHitTerrain(e:BaseEnemy, t:FlxBasic)
	{
		e.OnHitGround();
	}
	private function ReachExit(h:Dynamic, e:Dynamic)
	{
		_exit.kill();
		if (levelInfo.DieToWin)
		{
			Reg.Lose();
			return;
		}
		Reg.Win();
	}
	private function checkBulletHitTerrain(p:Projectile)
	{
		if(_tilemap.overlaps(p))
			p.HitTerrain();
	}
	private function enemyHit(enemy:BaseEnemy, projectile:Projectile)
	{
		if(projectile.IsActivated)
			enemy.OnHitProjectile(projectile);
	}
	private function heroHit(hero:Hero, projectile:Projectile)
	{
		if(projectile.IsActivated)
			hero.OnProjectileHit(projectile);
	}
	private function bumpEnemy(hero:Hero, enemy:BaseEnemy)
	{
		enemy.OnHitHero(hero);
	}
	
	public function ProjectileCreateCallback(p:Projectile):Void
	{
		_projectiles.add(p);
	}
	
	private function LoadMap(map:String)
	{
		try{
			var tiled:TiledMap = new TiledMap(map);
			for (layer in tiled.layers)
			{
				ProcessLayer(layer);
			}
		}
		catch (e:Dynamic)
		{
			trace(e);
		}
	}
	
	private function ProcessLayer(l:TiledLayer)
	{
		switch(l.type)
		{
			case TiledLayerType.TILE:
				ProcessTilemapLayer(cast l);
			case TiledLayerType.OBJECT:
				ProcessEntityLayer(cast l);
			case TiledLayerType.IMAGE:
				return;
		}
	}
	
	private function ProcessTilemapLayer(l:TiledTileLayer)
	{
		var arr:Array<Int> = l.tileArray;
		for (i in 0...arr.length)
		{
			arr[i]--;
		}
		_tilemap = new FlxTilemap();
		_tilemap.loadMapFromArray(arr, l.width, l.height, AssetPaths.tileset__png, 16, 16);
		
		_tilemap.setTileProperties(0, FlxObject.NONE);
		for(i in 32...64)
			_tilemap.setTileProperties(i, FlxObject.NONE);
		FlxG.worldBounds.set(0, 0, _tilemap.width, _tilemap.height);
	}
	private function ProcessEntityLayer(l:TiledObjectLayer)
	{
		for (e in l.objects)
		{
			var enemy:BaseEnemy = null;
			switch(e.type)
			{
				case "hero":
					_hero.setPosition(e.x, e.y);
				case "slime":
					var slime = new SlimeEnemy(e.x, e.y);
					_enemies.add(slime);
					enemy = slime;
				case "jumper":
					var jumper = new JumperEnemy(e.x, e.y);
					_enemies.add(jumper);
					enemy = jumper;
				case "zombie":
					var zombie = new ZombieEnemy(e.x, e.y);
					_enemies.add(zombie);
					enemy = zombie;
				case "exit":
					_exit = new FlxSprite(e.x, e.y);
					_exit.makeGraphic(e.width, e.height, Reg.WHITE_COLOR);
				case "barrel":
					var barrel:Barrel = new Barrel(e.x, e.y);
					_explosives.add(barrel);
			}
			if (enemy != null)
			{
				if (e.properties.contains("left"))
					enemy.FreezeFacing(false);
				if (e.properties.contains("right"))
					enemy.FreezeFacing(true);
			}
		}
	}
}
