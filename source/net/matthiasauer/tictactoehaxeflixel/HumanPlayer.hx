package net.matthiasauer.tictactoehaxeflixel;

import net.matthiasauer.tictactoehaxeflixel.model.Coordinate;
import net.matthiasauer.tictactoehaxeflixel.model.TileBoardModel;
import net.matthiasauer.tictactoehaxeflixel.viewController.TileClickedMessage;
import net.matthiasauer.utils.messageboard.MessageBoard;

class HumanPlayer implements Player {
    private var messageBoard:MessageBoard;
    private var playerColor:TileState;
    private var tileBoardModel:TileBoardModel;

    public function new(playerColor:TileState, tileBoardModel:TileBoardModel, messageBoard:MessageBoard) {
        this.tileBoardModel = tileBoardModel;
        this.messageBoard = messageBoard;
        this.playerColor = playerColor;
    }

    public function startTurn() : Void {
trace("human start :)");
    }

    public function update() : PlayerState {
        
        var messages:List<Dynamic> = this.messageBoard.collectFor(TileClickedMessage.TOPIC);

        for (message in messages) {
            var actualMessage = cast(message, TileClickedMessage);

            //var clickedTileCoordinate:Coordinate = this.tileBoard.clickedTile;
            var clickedTileCoordinate:Coordinate = actualMessage.coordinate;

            if (clickedTileCoordinate != null) {
                var currentTileState:TileState = this.tileBoardModel.getTileState(clickedTileCoordinate);

                if (currentTileState == TileState.None) {
                    // only change the tile
                    this.tileBoardModel.changeTileState(clickedTileCoordinate, this.playerColor);
                    return PlayerState.Finished;
                }
            }
        }

        return PlayerState.InProgress;
    }

    public function getName() : String {
        return "Human";
    }
}
