package net.matthiasauer.tictactoehaxeflixel.viewController;

import net.matthiasauer.tictactoehaxeflixel.model.TileBoardModel;
import net.matthiasauer.tictactoehaxeflixel.view.TileBoardView;

import net.matthiasauer.utils.di.ApplicationContext;
import net.matthiasauer.utils.di.DependencyDefinition;
import net.matthiasauer.utils.messageboard.MessageBoard;

class ViewControllerDependencyDefinition implements DependencyDefinition {
    public function new() {}
    
    public function addTo(applicationContext:ApplicationContext) : Void {
        applicationContext.addSingleton([TileBoardViewController], TileBoardViewControllerImpl, [TileBoardView, TileBoardModel, MessageBoard]);
    }
}