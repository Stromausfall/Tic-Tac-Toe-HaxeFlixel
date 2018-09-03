package net.matthiasauer.tictactoehaxeflixel;

import flixel.FlxState;
import flixel.FlxG;
import flixel.util.FlxColor;
import net.matthiasauer.tictactoehaxeflixel.model.TileBoardModel;
import net.matthiasauer.tictactoehaxeflixel.model.TileBoardModelImpl;

import net.matthiasauer.tictactoehaxeflixel.view.TileBoardView;
import net.matthiasauer.tictactoehaxeflixel.view.TileBoardViewImpl;

import net.matthiasauer.tictactoehaxeflixel.viewController.TileBoardViewController;
import net.matthiasauer.tictactoehaxeflixel.viewController.TileBoardViewControllerImpl;

import net.matthiasauer.utils.messageboard.MessageBoard;
import net.matthiasauer.utils.messageboard.MessageBoardImpl;

import net.matthiasauer.tictactoehaxeflixel.controller.GameController;

import net.matthiasauer.tictactoehaxeflixel.controller.player.Player;
import net.matthiasauer.tictactoehaxeflixel.controller.player.ComputerPlayer;
import net.matthiasauer.tictactoehaxeflixel.controller.player.HumanPlayer;

import net.matthiasauer.tictactoehaxeflixel.model.TileState;

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

		this.messageBoard = new MessageBoardImpl();
		var tileBoardModel:TileBoardModel = new TileBoardModelImpl(messageBoard);
		var tileBoardView:TileBoardView = new TileBoardViewImpl();
		this.tileBoardViewController = new TileBoardViewControllerImpl(tileBoardView, tileBoardModel, messageBoard);

		var gameStatusDisplay:GameStatusDisplay = new GameStatusDisplay();
		var currentPlayerDisplay:CurrentPlayerDisplay = new CurrentPlayerDisplay();
		var humanPlayer:Player = new HumanPlayer(TileState.Circle, tileBoardModel, messageBoard);
		var computerPlayer:Player = new ComputerPlayer(TileState.Cross, tileBoardModel);
		this.gameController = new GameController([humanPlayer, computerPlayer], currentPlayerDisplay, gameStatusDisplay, tileBoardModel);

		this.add(currentPlayerDisplay);
		tileBoardView.addTo(this);
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
