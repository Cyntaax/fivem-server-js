import { Model } from "sequelize-typescript";
import CharacterModel from "./CharacterModel";
export declare class UserModel extends Model {
    id: string;
    source: number;
    name: string;
    connectionCount: number;
    banInfo: BanInfo;
    characters: CharacterModel[];
    private _activeCharacter;
    get currentCharacter(): CharacterModel;
    setCharacter(character: CharacterModel): void;
    createCharacter(name: string): Promise<void>;
}
