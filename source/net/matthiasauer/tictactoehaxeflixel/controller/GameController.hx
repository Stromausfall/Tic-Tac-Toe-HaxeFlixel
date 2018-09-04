package net.matthiasauer.tictactoehaxeflixel.controller;

import net.matthiasauer.tictactoehaxeflixel.controller.player.Player;

interface GameController {
    function update() : Void;
    function initialize(players:Array<Player>) : Void;
}