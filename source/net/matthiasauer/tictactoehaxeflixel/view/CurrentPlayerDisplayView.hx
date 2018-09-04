package net.matthiasauer.tictactoehaxeflixel.view;

import flixel.group.FlxGroup;

interface CurrentPlayerDisplayView {
    function addTo(parent:FlxGroup) : Void;

    function displayPlayer(playerName:String) : Void;
}