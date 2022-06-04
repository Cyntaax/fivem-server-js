import { Module } from "citadel";
import { Util } from "../../../util";
import { UserModel } from "../models/UserModel";

@Module({
	name: "playermanager"
})
export default class PlayerManager {
	public players: UserModel[] = [];

	public async addPlayer(source: number) {
		let tmpPlayer: UserModel;
		const identifiers = Util.getIdentifiers(source);
		let replaced = false;
		let invalidPlayer = false;
		for (const [idx, player] of this.players.entries()) {
			if (player.id === identifiers.license) {
				const _player = await UserModel.findOne({
					where: {
						include: { all: true, nested: true },
						id: identifiers.license
					}
				});

				if (_player) {
					tmpPlayer = _player;
					_player.source = source;
					for (const c of _player.characters) {
						c.player = _player;
					}
					this.players[idx] = _player;
					replaced = true;
				} else {
					invalidPlayer = true;
				}
			}
		}

		if (replaced === false && invalidPlayer === false) {
			tmpPlayer = await UserModel.findOne({
				include: { all: true, nested: true },
				where: {
					id: identifiers.license
				}
			});
			if (tmpPlayer !== null) {
				tmpPlayer.source = source;
				for (const c of tmpPlayer.characters) {
					c.player = tmpPlayer;
				}
				console.log(`Added player ${tmpPlayer.name} with ${tmpPlayer.characters.length} characters`);
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

	public async saveAll() {
		for (const player of this.players) {
			for (const char of player.characters) {
				await char.save();
				console.log(`Saved ${char.name}`);
			}
			await player.save();
			console.log(`Saved {${player.name}}`);
		}
	}

	public $onReady() {
		setInterval(() => {
			this.saveAll();
		}, 30000);
	}
}
