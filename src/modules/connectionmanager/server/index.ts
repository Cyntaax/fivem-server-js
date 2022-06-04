import { Module, Event, NetEvent } from "citadel";
import { Util } from "../../../util";
import { UserModel } from "../../playermanager/models/UserModel";
import PlayerManager from "../../playermanager/server";

@Module({
	name: "connectionmanager",
	deps: [
		{
			dep: PlayerManager,
			key: "playerManager"
		}
	]
})
export default class ConnectionManager {
	constructor(public playerManager: PlayerManager) {}

	@Event("playerConnecting")
	async onPlayerConnecting(name: string, setKickReason: KickFunc, deferral: Deferral) {
		const source = global.source;
		console.log(`${name} is connecting...`);
		deferral.defer();

		deferral.update("Checking something...");
		const ids = Util.getIdentifiers(source);
		console.log(`user is`, ids.license);
		console.log(`ids`, JSON.stringify(ids, null, 2));

		let user = await UserModel.findOne({
			where: {
				id: ids.license
			}
		});

		let firstTime = false;

		if (user === null) {
			firstTime = true;
			const myUser = await UserModel.create({
				id: ids.license,
				name,
				connectionCount: 1
			});
			user = myUser;
		} else {
			user.connectionCount++;
			console.log(`banned till`, user.banInfo.until);
			await user.save();
		}

		if (firstTime === false) {
			deferral.update(`Welcome back, ${user.name}, checking your ban status\n...checking`);
			if (user.banInfo.until === 0) {
				deferral.update("Everything looks good, sending you in!");
				deferral.done();
			} else {
				deferral.done("Looks like you're banned, tsk tsk.");
			}
		} else {
			deferral.update(`Welcome ${user.name}, getting things ready for you...`);
			deferral.done();
		}
	}

	@NetEvent("base:sessionstarted")
	onSessionStart() {
		const source = global.source;
		this.playerManager.addPlayer(source);
	}
}
