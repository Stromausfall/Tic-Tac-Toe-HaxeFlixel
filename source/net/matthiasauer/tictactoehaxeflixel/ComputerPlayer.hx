package net.matthiasauer.tictactoehaxeflixel;

import net.matthiasauer.tictactoehaxeflixel.model.Coordinate;
import net.matthiasauer.tictactoehaxeflixel.model.TileBoardModel;

class ComputerPlayer implements Player {
    private var tileBoardModel:TileBoardModel;
    private var playerColor:TileState;

    public function new(playerColor:TileState, tileBoardModel:TileBoardModel) {
        this.tileBoardModel = tileBoardModel;
        this.playerColor = playerColor;
    }

    public function startTurn() : Void {
trace("computer start :)");
this.counter = 0;
    }
    private var counter:Int = 0;

    public function update() : PlayerState {
        //trace("computer :)");
        this.counter += 100;

        if (this.counter > 100) {
            for (x in 0...this.tileBoardModel.getTileBoardSizeX()) {
                for (y in 0...this.tileBoardModel.getTileBoardSizeY()) {
                    var coordinate:Coordinate = new Coordinate(x, y);
trace(coordinate);
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
