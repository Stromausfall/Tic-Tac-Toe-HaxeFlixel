package;

import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.util.FlxColor;

class CurrentPlayerDisplay extends FlxGroup {
    private var text:FlxText;
    private var format:FlxTextFormat;

    public function new() {
        super();
        
		this.format = new FlxTextFormat(0x4DA6FF, false, false, FlxColor.BLACK);
        
        this.text = new FlxText(60, 40, FlxG.width, "");
		this.text.setFormat(null, 24, FlxColor.YELLOW);
		this.text.setBorderStyle(OUTLINE, FlxColor.BLUE, 2);
		this.text.addFormat(this.format);

        this.add(this.text);
    }

    public function displayPlayer(playerName:String) : Void {
        this.text.text = "Current player: " + playerName;
    }
}