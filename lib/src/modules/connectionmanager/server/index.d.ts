import PlayerManager from "../../playermanager/server";
export default class ConnectionManager {
    playerManager: PlayerManager;
    constructor(playerManager: PlayerManager);
    onPlayerConnecting(name: string, setKickReason: KickFunc, deferral: Deferral): Promise<void>;
    onSessionStart(): void;
}
