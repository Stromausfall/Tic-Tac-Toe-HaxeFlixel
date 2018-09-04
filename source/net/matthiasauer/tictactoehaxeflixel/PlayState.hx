package net.matthiasauer.tictactoehaxeflixel;

import flixel.FlxState;
import flixel.FlxG;
import flixel.util.FlxColor;

import net.matthiasauer.tictactoehaxeflixel.view.TileBoardView;
import net.matthiasauer.tictactoehaxeflixel.view.CurrentPlayerDisplayView;
import net.matthiasauer.tictactoehaxeflixel.view.GameStatusDisplayView;

import net.matthiasauer.tictactoehaxeflixel.viewController.TileBoardViewController;

import net.matthiasauer.utils.messageboard.MessageBoard;
import net.matthiasauer.utils.messageboard.MessageBoardImpl;

import net.matthiasauer.tictactoehaxeflixel.controller.GameController;

import net.matthiasauer.tictactoehaxeflixel.controller.player.Player;
import net.matthiasauer.tictactoehaxeflixel.controller.player.ComputerPlayer;
import net.matthiasauer.tictactoehaxeflixel.controller.player.HumanPlayer;

import net.matthiasauer.utils.di.ApplicationContext;
import net.matthiasauer.utils.di.ApplicationContextImpl;

import net.matthiasauer.tictactoehaxeflixel.model.TileState;

import net.matthiasauer.tictactoehaxeflixel.controller.ControllerDependencyDefinition;
import net.matthiasauer.tictactoehaxeflixel.model.ModelDependencyDefinition;
import net.matthiasauer.tictactoehaxeflixel.view.ViewDependencyDefinition;
import net.matthiasauer.tictactoehaxeflixel.viewController.ViewControllerDependencyDefinition;

class PlayState extends FlxState
{
	private var applicationContext:ApplicationContext;

	private var tileBoardViewController:TileBoardViewController;
	private var gameController:GameController;
	private var messageBoard:MessageBoard;

	override public function create():Void
	{
		super.create();
		
		this.applicationContext = new ApplicationContextImpl();

		this.addDependencyDefinitions();
		this.getDependenciesForUpdate();
		
		this.initializeGameController();
		this.initializeView();
	}

	private function addDependencyDefinitions() {
		// add the messageBoard
		this.applicationContext.addSingleton([MessageBoard], MessageBoardImpl, []);

		// add the dependencies of the sub packages
		new ControllerDependencyDefinition().addTo(this.applicationContext);
		new ModelDependencyDefinition().addTo(this.applicationContext);
		new ViewDependencyDefinition().addTo(this.applicationContext);
		new ViewControllerDependencyDefinition().addTo(this.applicationContext);
	}

	private function getDependenciesForUpdate() : Void {
		this.tileBoardViewController = this.applicationContext.getImplementation(TileBoardViewController);
		this.gameController = this.applicationContext.getImplementation(GameController);
		this.messageBoard = this.applicationContext.getImplementation(MessageBoard);
	}

	private function initializeGameController() : Void {
		var humanPlayer:Player = applicationContext.getImplementation(HumanPlayer).initialize(TileState.Circle);
		var computerPlayer:Player = applicationContext.getImplementation(ComputerPlayer).initialize(TileState.Cross);

		this.gameController.initialize([humanPlayer, computerPlayer]);
	}

	private function initializeView() : Void {
		FlxG.log.redirectTraces = true;
		this.bgColor = FlxColor.WHITE;

		applicationContext.getImplementation(TileBoardView).addTo(this);
		applicationContext.getImplementation(GameStatusDisplayView).addTo(this);
		applicationContext.getImplementation(CurrentPlayerDisplayView).addTo(this);
	}

	override public function update(elapsed:Float):Void
	{
		// input from GUI
		this.tileBoardViewController.updateInput();

		// logic
		this.gameController.update();

		// update GUI
		this.tileBoardViewController.updateGUI();

		// clear message board (connection from Logic to GUI)
		this.messageBoard.reset();
		
		// DRAW GUI
		super.update(elapsed);
	}
}
