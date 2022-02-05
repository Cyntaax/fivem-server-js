import { Command, Module } from "citadel";
import { Game } from "fivem-js";

@Module({
	name: "debug"
})
export class Debug {
	@Command("sudoku")
	public sudoku() {
		Game.PlayerPed.kill();
	}

	@Command("reviveme")
	public revive() {
		const coords = Game.PlayerPed.Position;
		NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, 0, false, false);
	}
}
