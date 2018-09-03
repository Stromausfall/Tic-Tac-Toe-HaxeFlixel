package net.matthiasauer.tictactoehaxeflixel.controller;

import net.matthiasauer.tictactoehaxeflixel.model.TileBoardModel;
import net.matthiasauer.tictactoehaxeflixel.view.CurrentPlayerDisplay;
import net.matthiasauer.tictactoehaxeflixel.view.GameStatusDisplay;
import net.matthiasauer.tictactoehaxeflixel.controller.player.Player;
import net.matthiasauer.tictactoehaxeflixel.controller.player.PlayerManager;

class GameControllerImpl implements GameController {
    private var playerManager:PlayerManager;
    private var gameConditionMonitor:GameConditionMonitor;
    private var tileBoardModel:TileBoardModel;

    public function new(tileBoardModel:TileBoardModel) {
        this.tileBoardModel = tileBoardModel;
    }

    public function initialize(players:Array<Player>, currentPlayerDisplay:CurrentPlayerDisplay, gameStatusDisplay:GameStatusDisplay) {
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