import { Model } from "sequelize-typescript";
import { UserModel } from "./UserModel";
export default class CharacterModel extends Model {
    id: string;
    user: UserModel;
    name: string;
}
