package;

import haxe.ds.HashMap;
import flixel.FlxG;
import flixel.group.FlxGroup;

class TileBoard extends FlxGroup {
    public var clickedTile(default, null):Coordinate = null;
	public var TILE_COUNT_X(default, null) = 3;
	public var TILE_COUNT_Y(default, null) = 3;
    private var clickedTileInternal:Coordinate = null;
	private var IMAGE_SIZE_X = 100;
	private var IMAGE_SIZE_Y = 100;
	private var tiles:HashMap<Coordinate, Tile> = new HashMap<Coordinate, Tile>();

    public function new() {	
        super();

		var tileBoardSizeX = TILE_COUNT_X * IMAGE_SIZE_X;
		var tileBoardSizeY = TILE_COUNT_Y * IMAGE_SIZE_Y;
		var screenCenterX = FlxG.width / 2;
		var screenCenterY = FlxG.height / 2;

		var tileStartX:Int = Std.int(screenCenterX - (tileBoardSizeX / 2));
		var tileStartY:Int = Std.int(screenCenterY - (tileBoardSizeY / 2));

		for (x in 0...TILE_COUNT_X) {
			for (y in 0...TILE_COUNT_Y) {
                var coordinate:Coordinate = new Coordinate(x, y);
				var tileOffsetX = IMAGE_SIZE_X * x;
				var tileOffsetY = IMAGE_SIZE_Y * y;

				var tile = new Tile(
					tileStartX + tileOffsetX,
					tileStartY + tileOffsetY,
                    function myLocalFunction() {
                        this.clickedTileInternal = coordinate;
                    });

				this.add(tile);

				this.tiles.set(coordinate, tile);
			}
		}
	}

    public function updateInput() : Void {
        this.clickedTile = this.clickedTileInternal;

        // reset the clickedTileInternal
        this.clickedTileInternal = null;
    }

    public function getTileState(coordinate:Coordinate) : TileState {
        var tile:Tile = this.tiles.get(coordinate);

        return tile.state;
    }

    public function changeTileState(coordinate:Coordinate, newTileState:TileState) : Void {
        var tile:Tile = this.tiles.get(coordinate);

        tile.changeState(newTileState);
    }
}