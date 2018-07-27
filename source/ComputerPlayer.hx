package;

class ComputerPlayer implements Player {
    private var tileBoard:TileBoard;
    private var playerColor:TileState;

    public function new(playerColor:TileState, tileBoard:TileBoard) {
        this.tileBoard = tileBoard;
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
            for (x in 0...this.tileBoard.TILE_COUNT_X) {
                for (y in 0...this.tileBoard.TILE_COUNT_Y) {
                    var coordinate:Coordinate = new Coordinate(x, y);
trace(coordinate);
                    if (this.tileBoard.getTileState(coordinate) == TileState.None) {
                        this.tileBoard.changeTileState(coordinate, this.playerColor);

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
