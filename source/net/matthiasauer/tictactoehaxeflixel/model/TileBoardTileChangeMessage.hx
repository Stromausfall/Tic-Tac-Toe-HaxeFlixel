package net.matthiasauer.tictactoehaxeflixel.model;

class TileBoardTileChangeMessage {
    public static inline var TOPIC:String = "TileBoardTileChangeMessage";
    public var coordinate(default, null):Coordinate = null;

    public function new(coordinate:Coordinate) {
        this.coordinate = coordinate;
    }
}