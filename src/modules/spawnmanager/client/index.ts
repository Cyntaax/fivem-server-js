import { Module, Wait, Event, Command, Config } from "citadel";
import { Model, PedHash, Player, Vector3 } from "fivem-js";

@Module({
	name: "spawnmanager"
})
export class SpawnManager {
	public initialSpawnDone = false;
	async spawnPlayer(coords: Vector3) {
		DoScreenFadeOut(500);
		while (!IsScreenFadedOut()) {
			await Wait(0);
		}
		const model = new Model(PedHash.FreemodeMale01);
		await model.request(5000);
		SetPlayerModel(PlayerId(), model.Hash);
		model.markAsNoLongerNeeded();
		RequestCollisionAtCoord(coords.x, coords.y, coords.z);
		const ped = PlayerPedId();
		SetPedDefaultComponentVariation(ped);
		SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false);
		NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, 0, true, false);
		ClearPedTasksImmediately(ped);
		RemoveAllPedWeapons(ped, true);
		ClearPlayerWantedLevel(PlayerId());

		const time = GetGameTimer();

		while (!HasCollisionLoadedAroundEntity(ped) && GetGameTimer() - time < 5000) {
			await Wait(0);
		}

		ShutdownLoadingScreen();

		if (IsScreenFadedOut()) {
			DoScreenFadeIn(500);
			while (!IsScreenFadedIn()) {
				await Wait(0);
			}
		}
		FreezeEntityPosition(ped, false);
	}

	$onReady() {
		const spawned = global.exports.statemanager.Get("spawned");
		if (spawned === true) {
			return;
		}
		const starterTick = setTick(() => {
			if (NetworkIsSessionActive()) {
				this.onMapStart();
				this.initialSpawnDone = true;
				global.exports.statemanager.Set("spawned", true);
				clearTick(starterTick);
			}
		});
	}

	onMapStart() {
		this.spawnPlayer(new Vector3(Config.defaultSpawn.x, Config.defaultSpawn.y, Config.defaultSpawn.z));
	}

	@Command("forcestart")
	forceStart() {
		this.spawnPlayer(new Vector3(Config.defaultSpawn.x, Config.defaultSpawn.y, Config.defaultSpawn.z));
	}
}
