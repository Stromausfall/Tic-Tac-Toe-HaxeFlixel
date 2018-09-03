package net.matthiasauer.tictactoehaxeflixel.controller.player;

import net.matthiasauer.tictactoehaxeflixel.model.TileState;

interface Player {
    public function startTurn() : Void;
    public function update() : PlayerState;
    public function getName() : String;
    public function initialize(playerColor:TileState) : Player;
}