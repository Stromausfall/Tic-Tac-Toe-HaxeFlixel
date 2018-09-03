package net.matthiasauer.tictactoehaxeflixel.controller;

import net.matthiasauer.tictactoehaxeflixel.model.TileBoardModel;
import net.matthiasauer.tictactoehaxeflixel.controller.player.Player;
import net.matthiasauer.tictactoehaxeflixel.controller.player.PlayerManager;

class GameController {
    private var playerManager:PlayerManager;
    private var gameConditionMonitor:GameConditionMonitor;

    public function new(players:Array<Player>, currentPlayerDisplay:CurrentPlayerDisplay, gameStatusDisplay:GameStatusDisplay, tileBoardModel:TileBoardModel) {
        this.playerManager = new PlayerManager(players, currentPlayerDisplay);
        this.gameConditionMonitor = new GameConditionMonitor(tileBoardModel, gameStatusDisplay);
    }

    public function update() {
        if (this.gameConditionMonitor.isGameFinished()) {
            return;
        }

        this.playerManager.update();
        this.gameConditionMonitor.check();
    }
}