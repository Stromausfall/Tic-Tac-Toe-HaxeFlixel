package net.matthiasauer.tictactoehaxeflixel.controller.player;

import net.matthiasauer.tictactoehaxeflixel.model.Coordinate;
import net.matthiasauer.tictactoehaxeflixel.model.TileBoardModel;
import net.matthiasauer.tictactoehaxeflixel.model.TileState;

class ComputerPlayerImpl implements ComputerPlayer {
    private var tileBoardModel:TileBoardModel;
    private var playerColor:TileState;

    public function new(tileBoardModel:TileBoardModel) {
        this.tileBoardModel = tileBoardModel;
    }

    public function initialize(playerColor:TileState) : Player {
        this.playerColor = playerColor;
        return this;
    }

    public function startTurn() : Void {
        this.counter = 0;
    }
    private var counter:Int = 0;

    public function update() : PlayerState {
        this.counter += 25;

        if (this.counter > 100) {
            for (x in 0...this.tileBoardModel.getTileBoardSizeX()) {
                for (y in 0...this.tileBoardModel.getTileBoardSizeY()) {
                    var coordinate:Coordinate = new Coordinate(x, y);
                    
                    if (this.tileBoardModel.getTileState(coordinate) == TileState.None) {
                        this.tileBoardModel.changeTileState(coordinate, this.playerColor);

                        return PlayerState.Finished;
                    }
                }
            }
        }
        
        return PlayerState.InProgress;
    }

    public function getName() : String {
        return "Computer";
    }
}
