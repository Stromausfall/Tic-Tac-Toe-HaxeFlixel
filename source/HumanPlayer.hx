package;

class HumanPlayer implements Player {
    private var tileBoard:TileBoard;
    private var playerColor:TileState;

    public function new(playerColor:TileState, tileBoard:TileBoard) {
        this.tileBoard = tileBoard;
        this.playerColor = playerColor;
    }

    public function startTurn() : Void {
trace("human start :)");
    }

    public function update() : PlayerState {
        var clickedTileCoordinate:Coordinate = this.tileBoard.clickedTile;

        if (clickedTileCoordinate != null) {
            var currentTileState:TileState = this.tileBoard.getTileState(clickedTileCoordinate);

            if (currentTileState == TileState.None) {
                // only change the tile
                this.tileBoard.changeTileState(clickedTileCoordinate, this.playerColor);
                return PlayerState.Finished;
            }
        }

        return PlayerState.InProgress;
    }

    public function getName() : String {
        return "Human";
    }
}
