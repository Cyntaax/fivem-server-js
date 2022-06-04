import PlayerManager from "../../playermanager/server";
export default class BaseEventsSv {
    playerManager: PlayerManager;
    constructor(playerManager: PlayerManager);
    onDbReady(): void;
    createChar(source: number): Promise<void>;
    myChars(source: number): Promise<void>;
    setChar(source: number): Promise<void>;
}
