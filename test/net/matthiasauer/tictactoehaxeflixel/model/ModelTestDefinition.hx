package net.matthiasauer.tictactoehaxeflixel.model;

import haxe.unit.TestCase;
import net.matthiasauer.tictactoehaxeflixel.model.CoordinateTest;

class ModelTestDefinition implements TestDefinition {
    public function new() {
    }

    public function getTestCases() : Array<TestCase> {
        return [

            // Misc
            new CoordinateTest()
        ];
    }
}