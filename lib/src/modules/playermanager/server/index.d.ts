import { UserModel } from "../models/UserModel";
export default class PlayerManager {
    players: UserModel[];
    addPlayer(source: number): Promise<void>;
    getPlayerById(source: number): UserModel;
    saveAll(): Promise<void>;
    $onReady(): void;
}
