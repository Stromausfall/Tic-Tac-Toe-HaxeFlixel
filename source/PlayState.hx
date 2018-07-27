package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	private var gameController:GameController;
	private var tileBoard:TileBoard;

	override public function create():Void
	{
		super.create();
		
		FlxG.log.redirectTraces = true;
		this.bgColor = FlxColor.WHITE;

		this.tileBoard = new TileBoard();

		var gameStatusDisplay:GameStatusDisplay = new GameStatusDisplay();
		var currentPlayerDisplay:CurrentPlayerDisplay = new CurrentPlayerDisplay();
		var humanPlayer:Player = new HumanPlayer(TileState.Circle, this.tileBoard);
		var computerPlayer:Player = new ComputerPlayer(TileState.Cross, this.tileBoard);
		this.gameController = new GameController([humanPlayer, computerPlayer], currentPlayerDisplay, gameStatusDisplay, tileBoard);

		this.add(currentPlayerDisplay);
		this.add(this.tileBoard);
		this.add(gameStatusDisplay);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		// input
		this.tileBoard.updateInput();

		// logic
		this.gameController.update();
	}
}
