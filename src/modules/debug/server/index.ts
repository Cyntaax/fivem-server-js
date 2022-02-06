import { Module, Event, Command } from "citadel";
import { Util } from "../../../util";
import { TestModel } from "../../db-driver/server/models/TestModel";
import { UserModel } from "../../db-driver/server/models/UserModel";
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
	onDbReady() {
		const p = new TestModel();
		p.name = "hello";
		p.something = true;

		p.save()
			.then(() => {
				console.log(`created test model`);
			})
			.catch((e) => {
				console.log(`error`, e);
			});
	}

	@Command("nchar")
	async createChar(source: number) {
		const identifiers = Util.getIdentifiers(source);
		const pl = await UserModel.findOne({
			where: {
				id: identifiers.license
			}
		});

		if (pl) {
			await pl.createCharacter("testchar");
		}
	}

	@Command("mychars")
	async myChars(source: number) {
		const player = this.playerManager.getPlayerById(source);
		console.log(`found player`, player.name);
	}
}
