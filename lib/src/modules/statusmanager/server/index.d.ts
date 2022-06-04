import PlayerManager from "../../playermanager/server";
export declare class StatusController {
    playerManager: PlayerManager;
    statusCache: Map<number, any>;
    constructor(playerManager: PlayerManager);
    onRecvStatus(data: PlayerStatus[]): void;
    getStatus(source: number): Promise<PlayerStatus[]>;
    onPlayerDrop(): void;
}
