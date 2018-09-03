package net.matthiasauer.tictactoehaxeflixel.controller;

import net.matthiasauer.tictactoehaxeflixel.controller.player.Player;
import net.matthiasauer.tictactoehaxeflixel.view.CurrentPlayerDisplay;
import net.matthiasauer.tictactoehaxeflixel.view.GameStatusDisplay;

interface GameController {
    function update() : Void;
    function initialize(players:Array<Player>, currentPlayerDisplay:CurrentPlayerDisplay, gameStatusDisplay:GameStatusDisplay) : Void;
}