package net.matthiasauer.tictactoehaxeflixel.view;

import net.matthiasauer.utils.di.ApplicationContext;
import net.matthiasauer.utils.di.DependencyDefinition;

class ViewDependencyDefinition implements DependencyDefinition {
    public function new() {}
    
    public function addTo(applicationContext:ApplicationContext) : Void {
        applicationContext.addSingleton([TileBoardView], TileBoardViewImpl, []);
    }
}