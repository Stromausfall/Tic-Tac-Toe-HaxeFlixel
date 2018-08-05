package net.matthiasauer.tictactoehaxeflixel.view;

import haxe.ds.HashMap;
import net.matthiasauer.tictactoehaxeflixel.model.Coordinate;
import net.matthiasauer.tictactoehaxeflixel.model.Constants;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import flixel.FlxG;

class TileBoardViewImpl extends FlxGroup implements TileBoardView {
	private static inline var IMAGE_SIZE_X = 100;
	private static inline var IMAGE_SIZE_Y = 100;
	private var tiles:HashMap<Coordinate, Tile> = new HashMap<Coordinate, Tile>();
    private var clickedTiles:Array<Coordinate> = [];

    public function new() {
        super();
    }
    
    public function addTo(parent:FlxGroup) : Void {
        parent.add(this);
    }

    private function getTilePosition(coordinate:Coordinate) : FlxPoint {
		var tileBoardSizeX = Constants.TILE_BOARD_SIZE_X * IMAGE_SIZE_X;
		var tileBoardSizeY = Constants.TILE_BOARD_SIZE_Y * IMAGE_SIZE_Y;
		var screenCenterX = FlxG.width / 2;
		var screenCenterY = FlxG.height / 2;

		var tileStartX:Int = Std.int(screenCenterX - (tileBoardSizeX / 2));
		var tileStartY:Int = Std.int(screenCenterY - (tileBoardSizeY / 2));
		var tileOffsetX = IMAGE_SIZE_X * coordinate.x;
        var tileOffsetY = IMAGE_SIZE_Y * coordinate.y;

        return new FlxPoint(
            tileStartX + tileOffsetX,
            tileStartY + tileOffsetY);
    }

    public function createTile(coordinate:Coordinate) : Tile {
        var position:FlxPoint = getTilePosition(coordinate);

		var tile:Tile = new Tile(
            Std.int(position.x),
            Std.int(position.y),
            function clicked() {
                // remember the clicked tile
                clickedTiles.push(coordinate);
            });

        // add tile to the FlxGropu
		this.add(tile);

        // add tile to the map
		this.tiles.set(coordinate, tile);

        return tile;
    }

    public function getTile(coordinate:Coordinate) : Tile {
        return this.tiles.get(coordinate);
    }

    public function getAndClearCoordinatesOfClickedTiles() : Array<Coordinate> {
        var result:Array<Coordinate> = this.clickedTiles;

        // 'clear' the changed tiles array
        this.clickedTiles = [];

        // return the original content
        return result;
    }
}
 