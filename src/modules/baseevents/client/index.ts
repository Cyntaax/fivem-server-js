import { Module, Tick } from "citadel";

@Module({
	name: "baseevents"
})
export default class BaseEvents {
	public dead = false;

	@Tick("baseevents")
	public async onKill() {
		if (IsPedFatallyInjured(PlayerPedId()) && this.dead === false) {
			this.dead = true;
			const [killer, weapon] = NetworkGetEntityKillerOfPlayer(PlayerId());
			if (killer === PlayerPedId() || killer === -1) {
				emit("base:playerDied", { killer, weapon });
				emitNet("base:playerDied", { killer, weapon });
				console.log(`died to ${killer}`);
			}
		}

		if (!IsPedFatallyInjured(PlayerPedId()) && this.dead == true) {
			this.dead = false;
		}
	}
}
