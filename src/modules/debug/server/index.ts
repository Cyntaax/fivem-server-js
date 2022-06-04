import { Module, Event, Command } from "citadel";
import { Util } from "../../../util";
import { TestModel } from "../../db-driver/server/models/TestModel";
import { UserModel } from "../../playermanager/models/UserModel";
import PlayerManager from "../../playermanager/server";

@Module({
	name: "base-events-sv",
	deps: [
		{
			dep: PlayerManager,
			key: "playerManager"
		}
	]
})
export default class BaseEventsSv {
	constructor(public playerManager: PlayerManager) {}

	@Event("db:ready")
	onDbReady() {}

	@Command("nchar")
	async createChar(source: number) {
		const player = this.playerManager.getPlayerById(source);
		if (!player) {
			return;
		}

		await player.createCharacter(`test-char-${GetGameTimer()}`);
		console.log(`created character`);
	}

	@Command("mychars")
	async myChars(source: number) {
		const player = this.playerManager.getPlayerById(source);
		console.log(`found player`, player.name);
	}

	@Command("setchar")
	async setChar(source: number) {
		const player = this.playerManager.getPlayerById(source);
		if (player.characters.length > 0) {
			player.setCharacter(player.characters[0]);
			console.log(`accounts: `, player.currentCharacter.accounts);
		} else {
			await player.createCharacter("test-char");
			player.setCharacter(player.characters[0]);
		}
	}

	@Command("nacct")
	public async newAccount(source: number) {
		const player = this.playerManager.getPlayerById(source);
		if (!player) {
			return;
		}
		player.currentCharacter.createAccount("cash", 1000);
	}
}
