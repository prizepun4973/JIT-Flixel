package state;
import flixel.FlxState;
import game.data.Note;
import game.data.Song;
import flixel.FlxG;
import system.Paths;
import sys.FileSystem;
import system.LuaObject;
import flixel.animation.FlxAnimationController;
import game.StrumNote;

class PlayState extends FlxState
{
	public static var INSTANCE:PlayState;

	public var strums:Array<StrumNote> = new Array();
	public var notes:Array<Note> = new Array();

	public var curStage:String = "stage";

	public var paused:Bool = false;

	var previousFrameTime:Int = 0;
	var lastReportedPlayheadPosition:Int = 0;
	var songTime:Float = 0;
	public var songPosition:Float=0;
	public var lastSongPos:Float;

	private var noteTypeMap:Map<String, Bool> = new Map<String, Bool>();
	private var eventPushedMap:Map<String, Bool> = new Map<String, Bool>();

	private var stateLua:LuaObject;
	public var loadedLua:Array<LuaObject> = [];

	public function new(chart:String) {
		super();

		INSTANCE = this;

		stateLua = new LuaObject(Paths.getLua("state/PlayState"), this);

		var songData:SwagSong = Song.loadFromJson(chart, chart);

		if (songData.stage != null) curStage = songData.stage;

		// load notes
		for (i in songData.notes) {
			for (j in i.sectionNotes) {
				var strumTime:Float = j[0];
				var noteData:Int = j[1];
				var sustainLength:Float = j[2];
				var noteType:String = j.length > 3 ? j[3] : "";

				notes.push(new Note(strumTime, noteData, sustainLength, noteType));

				if(!noteTypeMap.exists(noteType)) {
					noteTypeMap.set(noteType, true);
				}
			}
		}

		for (i in 0...8) {
			strums.push(new StrumNote());
		}
	}

	override public function create() {

		callOnLuas("onCreate", []);

		Paths.clearStoredMemory();

		startLuasOnFolder('stages/' + curStage + '.lua');

		for (notetype in noteTypeMap.keys()) {
			startLuasOnFolder('custom_notetypes/' + notetype + '.lua');
		}
		noteTypeMap.clear();
		noteTypeMap = null;

		// TODO Event
//		for (event in eventPushedMap.keys()) {
//			startLuasOnFolder('custom_events/' + event + '.lua');
//		}
//		eventPushedMap.clear();
//		eventPushedMap = null;

		for(i in 0...8) {
			strums.push(new StrumNote());
		}

		super.create();
		callOnLuas("onCreatePost", []);
	}

	override public function update(elapsed:Float) {
		callOnLuas("onUpdate", [elapsed]);
		super.update(elapsed);
		doTiming();
		callOnLuas("onUpdatePost", [elapsed]);
	}
	
	override function destroy() {
		for (lua in loadedLua) {
			lua.call('onDestroy', []);
			lua.stop();
		}
		loadedLua = [];

		// TODO HScript
		
//		FlxAnimationController.globalSpeed = 1;
		FlxG.sound.music.pitch = 1;
		super.destroy();
	}

	public function callOnLuas(event:String, args:Array<Dynamic>, ignoreStops = true, exclusions:Array<String> = null, excludeValues:Array<Dynamic> = null):Dynamic {
		stateLua.call(event, args);

		var returnVal = LuaObject.Function_Continue;
		if(exclusions == null) exclusions = [];
		if(excludeValues == null) excludeValues = [];

		for (script in loadedLua) {
			if(exclusions.contains(script.scriptName))
				continue;

			var myValue = script.call(event, args);
			if(myValue == LuaObject.Function_StopLua && !ignoreStops)
				break;
			
			if(myValue != null && myValue != LuaObject.Function_Continue) {
				returnVal = myValue;
			}
		}
		
		return returnVal;
	}
	
	private function doTiming() {
	if (!paused) {
		songPosition += FlxG.elapsed * 1000;

		songTime += FlxG.game.ticks - previousFrameTime;
		previousFrameTime = FlxG.game.ticks;

		// Interpolation type beat
		if (lastSongPos != songPosition) {
			songTime = (songTime + songPosition) / 2;
			lastSongPos = songPosition;
		}
	}
}

	public function startLuasOnFolder(luaFile:String) {
		for (script in loadedLua) {
			if(script.scriptName == luaFile) return false;
		}

		var luaToLoad:String = Paths.modFolders(luaFile);
		if (FileSystem.exists(luaToLoad)) {
			loadedLua.push(new LuaObject(luaToLoad, this));
			return true;
		} else {
			luaToLoad = Paths.getPreloadPath(luaFile);
			if(FileSystem.exists(luaToLoad)) {
				loadedLua.push(new LuaObject(luaToLoad, this));
				return true;
			}
		}

		return false;
	}
}
