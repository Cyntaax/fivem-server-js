import { Model } from "sequelize-typescript";
import { UserModel } from "./UserModel";
export default class CharacterModel extends Model {
    id: string;
    userId: string;
    user: UserModel;
    name: string;
    status_info: PlayerStatus[];
}
