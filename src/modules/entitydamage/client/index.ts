import { Command, Module, NetEvent } from "citadel";
import StatusManager from "../../statusmanager/client";
import { StatusType } from "../../statusmanager/client/Statuses";

@Module({
	name: "entitydamagemanager",
	deps: [
		{
			dep: StatusManager,
			key: "statusManager"
		}
	]
})
class EntityDamageManager {
	constructor(public statusManager: StatusManager) {}

	$onReady() {
		const hp = this.statusManager.getStatus(StatusType.Health);
		hp.onDecrease((changed, before) => {
			console.log(`health decreased by ${changed}`);
			TriggerServerEvent("entitydamage:change", PedToNet(PlayerPedId()), "minus", changed);
		});
	}

	@NetEvent("entitydamage:change")
	public onDamage(ped: number, type: string, change: number) {
		const localPed = NetToPed(ped);
		if (!DoesEntityExist(localPed)) {
			return;
		}
	}
}
