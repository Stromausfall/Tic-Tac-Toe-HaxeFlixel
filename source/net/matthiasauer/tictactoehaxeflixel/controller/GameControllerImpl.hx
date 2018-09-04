package net.matthiasauer.tictactoehaxeflixel.controller;

import net.matthiasauer.tictactoehaxeflixel.model.TileBoardModel;
import net.matthiasauer.tictactoehaxeflixel.view.CurrentPlayerDisplayView;
import net.matthiasauer.tictactoehaxeflixel.view.GameStatusDisplayView;
import net.matthiasauer.tictactoehaxeflixel.controller.player.Player;
import net.matthiasauer.tictactoehaxeflixel.controller.player.PlayerManager;

class GameControllerImpl implements GameController {
    private var currentPlayerDisplay:CurrentPlayerDisplayView;
    private var gameConditionMonitor:GameConditionMonitor;
    private var playerManager:PlayerManager;

    public function new(tileBoardModel:TileBoardModel, currentPlayerDisplay:CurrentPlayerDisplayView, gameStatusDisplay:GameStatusDisplayView) {
        this.gameConditionMonitor = new GameConditionMonitor(tileBoardModel, gameStatusDisplay);
        this.currentPlayerDisplay = currentPlayerDisplay;
    }

    public function initialize(players:Array<Player>) {
        this.playerManager = new PlayerManager(players, this.currentPlayerDisplay);
    }

    public function update() {
        if (this.gameConditionMonitor.isGameFinished()) {
            return;
        }

        this.playerManager.update();
        this.gameConditionMonitor.check();
    }
}