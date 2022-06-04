import { Module, Event, AsyncServerCallback, NetEvent } from "citadel";
import { energy, health, healthRegen, healthRegenLimit, maxHealth, StatusType } from "./Statuses";

@Module({
	name: "statusmanager"
})
export default class StatusManager {
	public statuses = [energy, maxHealth, health, healthRegen, healthRegenLimit];
	@Event("base:sessionstarted")
	async onInit() {
		this.startTracking();
	}

	@NetEvent("pm:charselected")
	async onCharacterSelect() {
		const statusObj = await AsyncServerCallback<PlayerStatus[]>("statuscontroller.getstatus");
		console.log(JSON.stringify(statusObj, null, 2));
		if (!statusObj) {
			console.log(`no status returned`);
			return;
		}
		for (const status of this.statuses) {
			const existValue = statusObj.find((v) => v.name === status.name);
			if (existValue) {
				console.log(`setting`, status.name, existValue.value);
				status.setValueSilent(existValue.value);
			} else {
				status.setValueSilent(status.defaultValue);
			}
		}
	}

	startTracking() {
		setInterval(() => {
			const data = this.getAllStatusData();
			SendNuiMessage(
				JSON.stringify({
					event: "hud:status",
					payload: data
				})
			);
		}, 500);

		setInterval(() => {
			emitNet("status:recv", this.getAllStatusData());
		}, 5000);
	}

	public getAllStatusData() {
		const tmp: { name: string; value: number; max: number }[] = [];
		for (const status of this.statuses) {
			const data = status.data();
			tmp.push(data);
		}
		return tmp;
	}

	public getStatus(name: StatusType) {
		return this.statuses.find((v) => v.name === name);
	}
}
