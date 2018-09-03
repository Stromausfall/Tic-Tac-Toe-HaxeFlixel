package net.matthiasauer.tictactoehaxeflixel.controller;

import net.matthiasauer.tictactoehaxeflixel.model.Coordinate;
import net.matthiasauer.tictactoehaxeflixel.model.TileBoardModel;
import net.matthiasauer.tictactoehaxeflixel.model.TileState;
import net.matthiasauer.tictactoehaxeflixel.view.GameStatusDisplay;

class GameConditionMonitor {
    private var tileBoardModel:TileBoardModel;
    private var gameStatusDisplay:GameStatusDisplay;
    private var winner:TileState = null;

    public function new(tileBoardModel:TileBoardModel, gameStatusDisplay:GameStatusDisplay) {
        this.tileBoardModel = tileBoardModel;
        this.gameStatusDisplay = gameStatusDisplay;
    }

    public function isGameFinished() : Bool {
        return this.winner != null;
    }

    private function isDraw() {
        for (x in 0...this.tileBoardModel.getTileBoardSizeX()) {
            for (y in 0...this.tileBoardModel.getTileBoardSizeY()) {
                var coordinate:Coordinate = new Coordinate(x, y);

                if (this.tileBoardModel.getTileState(coordinate) == TileState.None) {
                    // there is at least ONE free tile so there can be no DRAW
                    return false;
                }
            }
        }

        // no more free tiles - this is a draw
        return true;
    }

    private function isLineCompletelyOwnedBy(start:Coordinate, direction:Coordinate, player:TileState) {
        var pointsInLine:Array<Coordinate> = [
            start,
            start.add(direction),
            start.add(direction).add(direction)
        ];

        return allPointsOwnedBy(pointsInLine, player);
    }

    private function allPointsOwnedBy(points:Array<Coordinate>, player:TileState) {
        for (point in points) {
            var pointTileState:TileState = this.tileBoardModel.getTileState(point);

            if (pointTileState != player) {
                // we found at least on point which is not owned by the player
                return false;
            }
        }

        return true;
    }

    private function isGameWonBy(player:TileState) : Bool {
        var gameWonByPlayer:Bool = false;

        // horizontal
        gameWonByPlayer = gameWonByPlayer || isLineCompletelyOwnedBy(new Coordinate(0, 0), new Coordinate(0, 1), player);
        gameWonByPlayer = gameWonByPlayer || isLineCompletelyOwnedBy(new Coordinate(1, 0), new Coordinate(0, 1), player);
        gameWonByPlayer = gameWonByPlayer || isLineCompletelyOwnedBy(new Coordinate(2, 0), new Coordinate(0, 1), player);

        // vertical
        gameWonByPlayer = gameWonByPlayer || isLineCompletelyOwnedBy(new Coordinate(0, 0), new Coordinate(1, 0), player);
        gameWonByPlayer = gameWonByPlayer || isLineCompletelyOwnedBy(new Coordinate(0, 1), new Coordinate(1, 0), player);
        gameWonByPlayer = gameWonByPlayer || isLineCompletelyOwnedBy(new Coordinate(0, 2), new Coordinate(1, 0), player);
        
        // diagonal
        gameWonByPlayer = gameWonByPlayer || isLineCompletelyOwnedBy(new Coordinate(0, 0), new Coordinate(1, 1), player);
        gameWonByPlayer = gameWonByPlayer || isLineCompletelyOwnedBy(new Coordinate(2, 0), new Coordinate(-1, 1), player);

        return gameWonByPlayer;
    }

    public function check() : Void {
        if (this.isGameWonBy(TileState.Circle)) {
            this.winner = TileState.Circle;
            this.gameStatusDisplay.displayString("Player won");
        }
        if (this.isGameWonBy(TileState.Cross)) {
            this.winner = TileState.Cross;
            this.gameStatusDisplay.displayString("Player won");
        }

        if ((this.winner == null) && (this.isDraw())) {
            this.winner = TileState.None;
            this.gameStatusDisplay.displayString("Draw");
        }

    }
}