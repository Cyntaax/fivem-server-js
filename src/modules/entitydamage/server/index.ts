import { Module, NetEvent } from "citadel";

@Module({
	name: "entitydamagecontroller"
})
class EntityDamageController {
	@NetEvent("entitydamage:change")
	onDamage(ped: number, type: string, changed: number) {
		TriggerClientEvent("entitydamage:change", ped, type, changed);
	}
}
