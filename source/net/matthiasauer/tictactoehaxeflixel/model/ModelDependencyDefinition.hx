package net.matthiasauer.tictactoehaxeflixel.model;

import net.matthiasauer.utils.di.ApplicationContext;
import net.matthiasauer.utils.di.DependencyDefinition;
import net.matthiasauer.utils.messageboard.MessageBoard;

class ModelDependencyDefinition implements DependencyDefinition {
    public function new() {}

    public function addTo(applicationContext:ApplicationContext) : Void {
        applicationContext.addSingleton([TileBoardModel], TileBoardModelImpl, [MessageBoard]);
    }
}