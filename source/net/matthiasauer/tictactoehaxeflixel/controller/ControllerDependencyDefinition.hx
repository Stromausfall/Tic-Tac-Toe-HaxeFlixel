package net.matthiasauer.tictactoehaxeflixel.controller;

import net.matthiasauer.tictactoehaxeflixel.model.TileBoardModel;
import net.matthiasauer.tictactoehaxeflixel.controller.player.ComputerPlayer;
import net.matthiasauer.tictactoehaxeflixel.controller.player.ComputerPlayerImpl;
import net.matthiasauer.tictactoehaxeflixel.controller.player.HumanPlayer;
import net.matthiasauer.tictactoehaxeflixel.controller.player.HumanPlayerImpl;

import net.matthiasauer.utils.di.ApplicationContext;
import net.matthiasauer.utils.di.DependencyDefinition;
import net.matthiasauer.utils.messageboard.MessageBoard;

class ControllerDependencyDefinition implements DependencyDefinition {
    public function new() {}

    public function addTo(applicationContext:ApplicationContext) : Void {
        applicationContext.addSingleton([GameController], GameControllerImpl, [TileBoardModel]);

        applicationContext.addPrototype([HumanPlayer], HumanPlayerImpl, [TileBoardModel, MessageBoard]);
        applicationContext.addPrototype([ComputerPlayer], ComputerPlayerImpl, [TileBoardModel]);

    }
}