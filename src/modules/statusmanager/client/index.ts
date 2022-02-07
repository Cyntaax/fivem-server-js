import { Module, Event } from "citadel";

@Module({
	name: "statusmanager"
})
export default class StatusManager {
	@Event("base:sessionstarted")
	startTracking() {
		setInterval(() => {
			const sprint = GetPlayerSprintStaminaRemaining(PlayerId());
			const val = 100 - sprint;
			SendNuiMessage(
				JSON.stringify({
					event: "hud:status",
					stamina: val
				})
			);
			console.log(`sprint`, sprint);
		}, 500);
	}
}
