package net.matthiasauer.tictactoehaxeflixel.view;

import flixel.group.FlxGroup;
import net.matthiasauer.tictactoehaxeflixel.model.Coordinate;

interface TileBoardView {
    function addTo(parent:FlxGroup) : Void;

    function createTile(coordinate:Coordinate) : Tile;
    function getTile(coordinate:Coordinate) : Tile;
    function getAndClearCoordinatesOfClickedTiles() : Array<Coordinate>;
}