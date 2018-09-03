package net.matthiasauer.tictactoehaxeflixel;

import flixel.FlxState;
import flixel.FlxG;
import flixel.util.FlxColor;

import net.matthiasauer.tictactoehaxeflixel.view.TileBoardView;

import net.matthiasauer.tictactoehaxeflixel.view.GameStatusDisplay;
import net.matthiasauer.tictactoehaxeflixel.view.CurrentPlayerDisplay;

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
	private var gameController:GameController;
	private var messageBoard:MessageBoard;

	private var tileBoardViewController:TileBoardViewController;

	override public function create():Void
	{
		super.create();
		
		FlxG.log.redirectTraces = true;
		this.bgColor = FlxColor.WHITE;


		var applicationContext:ApplicationContext = new ApplicationContextImpl();
		applicationContext.addSingleton([MessageBoard], MessageBoardImpl, []);

		new ControllerDependencyDefinition().addTo(applicationContext);
		new ModelDependencyDefinition().addTo(applicationContext);
		new ViewDependencyDefinition().addTo(applicationContext);
		new ViewControllerDependencyDefinition().addTo(applicationContext);
		

		this.messageBoard = applicationContext.getImplementation(MessageBoard);
		var humanPlayer:Player = applicationContext.getImplementation(HumanPlayer).initialize(TileState.Circle);
		var computerPlayer:Player = applicationContext.getImplementation(ComputerPlayer).initialize(TileState.Cross);


		this.tileBoardViewController = applicationContext.getImplementation(TileBoardViewController);

		var gameStatusDisplay:GameStatusDisplay = new GameStatusDisplay();
		var currentPlayerDisplay:CurrentPlayerDisplay = new CurrentPlayerDisplay();
		this.gameController = applicationContext.getImplementation(GameController);
		this.gameController.initialize([humanPlayer, computerPlayer], currentPlayerDisplay, gameStatusDisplay);

		this.add(currentPlayerDisplay);

		applicationContext.getImplementation(TileBoardView).addTo(this);
		this.add(gameStatusDisplay);
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
