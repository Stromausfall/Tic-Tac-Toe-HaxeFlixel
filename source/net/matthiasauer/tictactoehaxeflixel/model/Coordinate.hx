package net.matthiasauer.tictactoehaxeflixel.model;

class Coordinate {
    public var x:Int;
    public var y:Int;

    public function new(x:Int, y:Int)
    {
        this.x=x;
        this.y=y;
    }

    public function hashCode():Int
    {
        return x + 1000*y;
    }

    public function toString()
    {
        return '(x:$x, y:$y)';
    }

    public function add(other:Coordinate) : Coordinate {
        return new Coordinate(
            this.x + other.x,
            this.y + other.y
        );
    }
}
