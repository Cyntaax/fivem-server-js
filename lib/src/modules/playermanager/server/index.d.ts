import { UserModel } from "../../db-driver/server/models/UserModel";
export default class PlayerManager {
    players: UserModel[];
    addPlayer(source: number): Promise<void>;
    getPlayerById(source: number): UserModel;
}
