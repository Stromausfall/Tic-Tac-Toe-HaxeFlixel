package net.matthiasauer.tictactoehaxeflixel.viewController;

import net.matthiasauer.tictactoehaxeflixel.model.TileBoardModel;
import net.matthiasauer.tictactoehaxeflixel.TileState;
import net.matthiasauer.tictactoehaxeflixel.view.TileBoardView;
import net.matthiasauer.tictactoehaxeflixel.view.Tile;
import net.matthiasauer.tictactoehaxeflixel.model.Coordinate;
import net.matthiasauer.tictactoehaxeflixel.model.TileBoardTileChangeMessage;
import net.matthiasauer.utils.messageboard.MessageBoard;

class TileBoardViewControllerImpl implements TileBoardViewController {
    private var tileBoardView:TileBoardView;
    private var tileBoardModel:TileBoardModel;
    private var messageBoard:MessageBoard;

    public function new(tileBoardView:TileBoardView, tileBoardModel:TileBoardModel, messageBoard:MessageBoard) {
        this.tileBoardView = tileBoardView;
        this.tileBoardModel = tileBoardModel;
        this.messageBoard = messageBoard;

    }

    public function updateInput() : Void {
        var coordinatesOfClickedTiles:Array<Coordinate> = this.tileBoardView.getAndClearCoordinatesOfClickedTiles();

        for (coordinate in coordinatesOfClickedTiles) {
            var message:TileClickedMessage = new TileClickedMessage(coordinate);

            this.messageBoard.store(TileClickedMessage.TOPIC, message);
        }
    }

    public function updateGUI() : Void {
        var messages:List<Dynamic> = this.messageBoard.collectFor(TileBoardTileChangeMessage.TOPIC);

        for (message in messages) {
            var actualMessage:TileBoardTileChangeMessage = cast(message, TileBoardTileChangeMessage);
            var tile:Tile = this.getTile(actualMessage.coordinate);
            var newTileState:TileState = this.tileBoardModel.getTileState(actualMessage.coordinate);

            // change the tile state
            tile.changeState(newTileState);
        }
    }

    private function getTile(coordinate:Coordinate) {
        var tile:Tile = this.tileBoardView.getTile(coordinate);

        if (tile == null) {
            tile = this.tileBoardView.createTile(coordinate);
        }

        return tile;
    }
}