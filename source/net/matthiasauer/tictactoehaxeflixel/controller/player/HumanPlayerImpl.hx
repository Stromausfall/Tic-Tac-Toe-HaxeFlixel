package net.matthiasauer.tictactoehaxeflixel.controller.player;

import net.matthiasauer.tictactoehaxeflixel.model.Coordinate;
import net.matthiasauer.tictactoehaxeflixel.model.TileBoardModel;
import net.matthiasauer.tictactoehaxeflixel.model.TileState;
import net.matthiasauer.tictactoehaxeflixel.viewController.TileClickedMessage;
import net.matthiasauer.utils.messageboard.MessageBoard;

class HumanPlayerImpl implements HumanPlayer {
    private var messageBoard:MessageBoard;
    private var playerColor:TileState;
    private var tileBoardModel:TileBoardModel;

    public function new(tileBoardModel:TileBoardModel, messageBoard:MessageBoard) {
        this.tileBoardModel = tileBoardModel;
        this.messageBoard = messageBoard;
    }

    public function initialize(playerColor:TileState) : Player {
        this.playerColor = playerColor;
        return this;
    }

    public function startTurn() : Void {
    }

    public function update() : PlayerState {        
        var messages:List<TileClickedMessage> = this.messageBoard.collectFor(TileClickedMessage.TOPIC, TileClickedMessage);

        for (message in messages) {
            var clickedTileCoordinate:Coordinate = message.coordinate;

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
