package;

class GameController {
    private var playerManager:PlayerManager;
    private var gameConditionMonitor:GameConditionMonitor;

    public function new(players:Array<Player>, currentPlayerDisplay:CurrentPlayerDisplay, gameStatusDisplay:GameStatusDisplay, tileBoard:TileBoard) {
        this.playerManager = new PlayerManager(players, currentPlayerDisplay);
        this.gameConditionMonitor = new GameConditionMonitor(tileBoard, gameStatusDisplay);
    }

    public function update() {
        if (this.gameConditionMonitor.isGameFinished()) {
            trace("OOOOO !");
            return;
        }

        this.playerManager.update();
        this.gameConditionMonitor.check();
    }
}