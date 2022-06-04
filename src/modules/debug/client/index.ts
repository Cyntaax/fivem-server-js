import { Arg, Command, Module } from "citadel";
import { Game, Model, Vector3, VehicleSeat, World } from "fivem-js";
import StatusManager from "../../statusmanager/client";
import { StatusType } from "../../statusmanager/client/Statuses";
import { DebugBox } from "./debugBox";

@Module({
	name: "debug",
	deps: [
		{
			dep: StatusManager,
			key: "statusManager"
		}
	]
})
export class Debug {
	constructor(public statusManager: StatusManager) {}
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

	@Command("hurtme")
	public hurtme() {
		const health = this.statusManager.getStatus(StatusType.Health);
		health.value = health.value - 10;
	}

	@Command("setstatus")
	public setStatus(source: number, @Arg("status") status: string, @Arg("value") value: number) {
		const s = this.statusManager.getStatus(status as StatusType);
		if (!s) {
			console.log(`skipping`);
			return;
		}

		console.log(`setting ${status} ${value}`);
		s.value = value;
	}

	@Command("pu")
	public pause() {
		console.log(`pausing...`);
		ActivateFrontendMenu(GetHashKey("FE_MENU_VERSION_MP_PAUSE"), true, -1);
	}

	@Command("tp")
	public tp(source: number, @Arg("x") x: number, @Arg("y") y: number, @Arg("z") z: number) {
		console.log("x", x, "y", y, "z", z);
		Game.PlayerPed.Position = new Vector3(x, y, z);
	}

	@Command("car")
	public async spawnCar(source: number, @Arg("model") model: string) {
		const _model = new Model(model);
		await _model.request(5000);
		const veh = await World.createVehicle(_model, Game.PlayerPed.Position);
		Game.PlayerPed.setIntoVehicle(veh, VehicleSeat.Driver);
	}
}
