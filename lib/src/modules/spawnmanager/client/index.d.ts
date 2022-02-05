import { Vector3 } from "fivem-js";
export declare class SpawnManager {
    initialSpawnDone: boolean;
    spawnPlayer(coords: Vector3): Promise<void>;
    $onReady(): void;
    onMapStart(): void;
    forceStart(): void;
}
