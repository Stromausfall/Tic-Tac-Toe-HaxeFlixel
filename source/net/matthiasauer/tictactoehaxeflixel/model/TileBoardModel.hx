package net.matthiasauer.tictactoehaxeflixel.model;

interface TileBoardModel {
    function getTileState(coordinate:Coordinate) : TileState;

    function changeTileState(coordinate:Coordinate, newTileState:TileState) : Void;

    function getTileBoardSizeX() : Int;

    function getTileBoardSizeY() : Int;
}