package net.matthiasauer.tictactoehaxeflixel.view;

import flixel.group.FlxGroup;

interface GameStatusDisplayView {
    function addTo(parent:FlxGroup) : Void;

    function displayString(playerName:String) : Void;
}