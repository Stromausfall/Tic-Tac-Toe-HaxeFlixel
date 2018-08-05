package net.matthiasauer.tictactoehaxeflixel.model;

import haxe.unit.TestCase;
import haxe.ds.HashMap;

class CoordinateTest extends TestCase {
    public function testThatCoordinatesCanBeUsedAsHashMapKeys() {
        // GIVEN:
        var map:HashMap<Coordinate, String> = new HashMap<Coordinate, String>();

        map.set(new Coordinate(0, 0), "zero");
        map.set(new Coordinate(1, 1), "one");
        map.set(new Coordinate(0, 1), "half-one-1");
        map.set(new Coordinate(1, 0), "half-one-2");

        // WHEN:
        var zero:String = map.get(new Coordinate(0, 0));
        var one:String = map.get(new Coordinate(1, 1));
        var halfOne1:String = map.get(new Coordinate(0, 1));
        var halfOne2:String = map.get(new Coordinate(1, 0));

        // THEN:
        assertEquals("zero", zero);
        assertEquals("one", one);
        assertEquals("half-one-1", halfOne1);
        assertEquals("half-one-2", halfOne2);
    }
}