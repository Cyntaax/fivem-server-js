import { Model } from "sequelize-typescript";
import CharacterModel from "./CharacterModel";
export declare class UserModel extends Model {
    id: string;
    name: string;
    connectionCount: number;
    banInfo: BanInfo;
    characters: CharacterModel[];
    createCharacter(name: string): Promise<void>;
}
