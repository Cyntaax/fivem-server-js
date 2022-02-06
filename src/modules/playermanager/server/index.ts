import { Module } from "citadel";
import { Util } from "../../../util";
import { UserModel } from "../../db-driver/server/models/UserModel";

@Module({
	name: "playermanager"
})
export default class PlayerManager {
	players: UserModel[] = [];

	public async addPlayer(source: number) {
		let tmpPlayer: UserModel;
		const identifiers = Util.getIdentifiers(source);
		let replaced = false;
		let invalidPlayer = false;
		for (const [idx, player] of this.players.entries()) {
			if (player.id === identifiers.license) {
				const _player = await UserModel.findOne({
					where: {
						include: { all: true },
						id: identifiers.license
					}
				});

				if (_player) {
					tmpPlayer = _player;
					_player.source = source;
					this.players[idx] = _player;
					replaced = true;
				} else {
					invalidPlayer = true;
				}
			}
		}

		if (replaced === false && invalidPlayer === false) {
			tmpPlayer = await UserModel.findOne({
				include: { all: true },
				where: {
					id: identifiers.license
				}
			});
			if (tmpPlayer !== null) {
				tmpPlayer.source = source;
				this.players.push(tmpPlayer);
			}
		}
	}

	public getPlayerById(source: number) {
		for (const player of this.players) {
			if (player.source === source) {
				return player;
			}
		}
	}
}
