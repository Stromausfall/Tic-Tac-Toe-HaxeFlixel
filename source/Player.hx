package;

interface Player {
    public function startTurn() : Void;
    public function update() : PlayerState;
    public function getName() : String;
}