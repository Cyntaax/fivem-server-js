import { Command, Module } from "citadel";
import { Game } from "fivem-js";
import { DebugBox } from "./debugBox";

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

	@Command("debug1")
	public debug1() {
		console.log(`doing the thing`);
		const box = new DebugBox();
		box.draw();
	}
}
