import { Module, ServerCallback, Event, NetEvent } from "citadel";
import PlayerManager from "../../playermanager/server";

@Module({
	name: "statuscontroller",
	deps: [
		{
			dep: PlayerManager,
			key: "playerManager"
		}
	]
})
export class StatusController {
	public statusCache = new Map<number, any>();

	constructor(public playerManager: PlayerManager) {}

	@NetEvent("status:recv")
	onRecvStatus(data: PlayerStatus[]) {
		const source = global.source;
		const player = this.playerManager.getPlayerById(source);
		if (!player) {
			return;
		}
		const character = player.currentCharacter;
		if (!character) {
			return;
		}

		character.status_info = data;
	}

	@ServerCallback("getstatus")
	async getStatus(source: number) {
		console.log(`getting for`, source);
		const player = this.playerManager.getPlayerById(source);
		if (!player) {
			console.log(`no player`);
			return;
		}
		const character = player.currentCharacter;
		if (!character) {
			console.log(`no character`);
			return;
		}

		return character.status_info;
	}

	@Event("playerDropped")
	onPlayerDrop() {
		const source = global.source;
		const status = this.statusCache.get(source);
		if (!status) {
			console.log(`no status found for ${source}`);
			return;
		}
	}
}
