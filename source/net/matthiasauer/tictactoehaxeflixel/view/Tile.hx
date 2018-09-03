package net.matthiasauer.tictactoehaxeflixel.view;

import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.input.mouse.FlxMouseEventManager;
import net.matthiasauer.tictactoehaxeflixel.model.TileState;

class Tile extends FlxGroup {
    public var state(default, null):TileState;
    private var positionX:Int;
    private var positionY:Int;
    private var sprite:FlxSprite;
    private var clickCallback:Void->Void;

    public function new(positionX:Int, positionY:Int, clickCallback:Void->Void) {
        super();

        this.clickCallback = clickCallback;
        this.positionX = positionX;
        this.positionY = positionY;
        this.sprite = null;

        this.changeState(TileState.None);
    }

    public function changeState(tileState:TileState) {
        if (this.sprite != null) {
            // remove the sprite from this group
            this.remove(this.sprite);

            // remove the sprite from the FlxMouseEventManager
            FlxMouseEventManager.remove(this.sprite);

            // destroy the sprite
            this.sprite.destroy();

            // clear the variable
            this.sprite = null;
        }

        this.state = tileState;
        var pathToSprite = getImagePathFor(this.state);

        this.sprite =
			new FlxSprite(
                this.positionX,
                this.positionY,
                pathToSprite);

        this.add(this.sprite);

        // install the mouse click listener
        FlxMouseEventManager.add(this.sprite);
        FlxMouseEventManager.setMouseClickCallback(this.sprite, this.mouseClicked);
    }

    private function getImagePathFor(tileState:TileState) : String {
        switch tileState {
            case TileState.Circle:
                return "assets/images/tile_circle.png";
            case TileState.Cross:
                return "assets/images/tile_cross.png";
            default:
                return "assets/images/tile_empty.png";
        }
    }

    private function mouseClicked(sprite:FlxSprite) : Void {
        this.clickCallback();
    }
}
