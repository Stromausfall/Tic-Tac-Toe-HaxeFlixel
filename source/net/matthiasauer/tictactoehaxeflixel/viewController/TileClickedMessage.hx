package net.matthiasauer.tictactoehaxeflixel.viewController;

import net.matthiasauer.tictactoehaxeflixel.model.Coordinate;

class TileClickedMessage {
    public static inline var TOPIC:String = "TileClickedMessage";
    public var coordinate(default, null):Coordinate = null;

    public function new(coordinate:Coordinate) {
        this.coordinate = coordinate;
    }
}