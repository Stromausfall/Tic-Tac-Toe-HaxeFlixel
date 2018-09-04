package net.matthiasauer.tictactoehaxeflixel.controller.player;

import net.matthiasauer.tictactoehaxeflixel.view.CurrentPlayerDisplayView;

class PlayerManager {
    private var players:Array<Player>;
    private var currentPlayer:Player;
    private var currentPlayerDisplay:CurrentPlayerDisplayView;

    public function new(players:Array<Player>, currentPlayerDisplay:CurrentPlayerDisplayView) {
        this.players = players;
        this.currentPlayer = null;
        this.currentPlayerDisplay = currentPlayerDisplay;
    }


    public function update() {
        if (this.currentPlayer == null) {
            this.currentPlayer = getFirstAndAttachItAtBack();
            this.currentPlayer.startTurn();
            this.currentPlayerDisplay.displayPlayer(this.currentPlayer.getName());
        }

        var playerState:PlayerState = this.currentPlayer.update();

        if (playerState == PlayerState.Finished) {
            this.currentPlayer = null;
        }
    }

    private function getFirstAndAttachItAtBack() {
        // first reverse the list (the first is now the last)
        this.players.reverse();

        // get the first player (the last in the now reversed list)
        var firstPlayer:Player = this.players.pop();

        // reverse the list again (normal order again)
        this.players.reverse();

        // then attach the removed firs element at the end of the list
        this.players.push(firstPlayer);

        return firstPlayer;
    }
}