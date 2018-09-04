package net.matthiasauer.tictactoehaxeflixel.view;

import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.util.FlxColor;

class GameStatusDisplayViewImpl implements GameStatusDisplayView extends FlxGroup {
    private var text:FlxText;
    private var format:FlxTextFormat;

    public function new() {
        super();
        
		this.format = new FlxTextFormat(0x4DA6FF, false, false, FlxColor.BLACK);
        
        this.text = new FlxText(0, 240, FlxG.width, "");
		this.text.setFormat(null, 24, FlxColor.YELLOW);
		this.text.setBorderStyle(OUTLINE, FlxColor.BLUE, 2);
		this.text.addFormat(this.format);
        this.text.autoSize = false;
        this.text.alignment = FlxTextAlign.CENTER;

        this.add(this.text);
    }

    public function displayString(playerName:String) : Void {
        this.text.text = playerName;
    }
    
    public function addTo(parent:FlxGroup) : Void {
        parent.add(this);
    }
}