package system;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.sound.FlxSound;
class LuaManager {

    public static var sprites:Map<String, FlxSprite> = new Map();
    public static var variables:Map<String, Dynamic> = new Map();
    public static var texts:Map<String, FlxText> = new Map();
    public static var tweens:Map<String, FlxTween> = new Map();
    public static var timers:Map<String, FlxTimer> = new Map();
    public static var sounds:Map<String, FlxSound> = new Map();

    public static function clear() {
        clearSprite();
        clearVar();
        clearText();
        clearTweens();
        clearTimer();
        clearSound();
    }

    public static function clearSprite() {
        sprites.clear();
    }

    public static function clearVar() {
        variables.clear();
    }

    public static function clearText() {
        variables.clear();
    }

    public static function clearTweens() {
        tweens.clear();
    }

    public static function clearTimer() {
        timers.clear();
    }

    public static function clearSound() {
        sounds.clear();
    }

    public static function getLuaObject(tag:String, text:Bool=true):FlxSprite {
        if(sprites.exists(tag)) return sprites.get(tag);
        if(text && texts.exists(tag)) return texts.get(tag);
        if(variables.exists(tag)) return variables.get(tag);
        return null;
    }
}
