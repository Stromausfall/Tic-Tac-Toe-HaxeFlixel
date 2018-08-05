package net.matthiasauer.tictactoehaxeflixel;

import net.matthiasauer.tictactoehaxeflixel.model.TileBoardModel;

class GameController {
    private var playerManager:PlayerManager;
    private var gameConditionMonitor:GameConditionMonitor;

    public function new(players:Array<Player>, currentPlayerDisplay:CurrentPlayerDisplay, gameStatusDisplay:GameStatusDisplay, tileBoardModel:TileBoardModel) {
        this.playerManager = new PlayerManager(players, currentPlayerDisplay);
        this.gameConditionMonitor = new GameConditionMonitor(tileBoardModel, gameStatusDisplay);
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