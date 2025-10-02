package game.data;
class Note {

    public var strumTime:Float = 0;
    public var noteData:Int = 0;
    public var sustainLength:Float = 0;

    public var noteType:String = "";

    public function new(strumTime:Float, noteData:Int, sustainLength:Float, noteType:String) {
        this.strumTime = strumTime;
        this.noteData = noteData;
        this.sustainLength = sustainLength;
        this.noteType = noteType;
    }
}
