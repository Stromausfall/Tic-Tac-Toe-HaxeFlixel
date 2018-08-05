package net.matthiasauer.tictactoehaxeflixel.model;

import haxe.ds.HashMap;
import net.matthiasauer.utils.messageboard.MessageBoard;

class TileBoardModelImpl implements TileBoardModel {
	private var tiles:HashMap<Coordinate, TileState>;
    private var messageBoard:MessageBoard;
    private var tileBoardSizeX:Int;
    private var tileBoardSizeY:Int;

    public function new(messageBoard:MessageBoard) {
        this.messageBoard = messageBoard;

        this.intialize(Constants.TILE_BOARD_SIZE_X, Constants.TILE_BOARD_SIZE_Y);
    }

    private function intialize(tileBoardSizeX:Int, tileBoardSizeY:Int) {
        this.tileBoardSizeX = tileBoardSizeX;
        this.tileBoardSizeY = tileBoardSizeY;

        this.tiles = new HashMap<Coordinate, TileState>();

        for (x in 0...this.tileBoardSizeX) {
            for (y in 0...this.tileBoardSizeY) {
                var coordinate:Coordinate = new Coordinate(x, y);

                this.changeTileState(coordinate, TileState.None);
            }
        }
    }

    public function getTileState(coordinate:Coordinate) : TileState {
        var tile:TileState = this.tiles.get(coordinate);

        return tile;
    }

    public function changeTileState(coordinate:Coordinate, newTileState:TileState) : Void {
        this.tiles.set(coordinate, newTileState);

        var message:TileBoardTileChangeMessage = new TileBoardTileChangeMessage(coordinate);

        // tile.changeState(newTileState);
        this.messageBoard.store(TileBoardTileChangeMessage.TOPIC, message);
    }

    public function getTileBoardSizeX() : Int {
        return this.tileBoardSizeX;
    }

    public function getTileBoardSizeY() : Int {
        return this.tileBoardSizeY;
    }
} 