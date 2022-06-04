import { Model } from "sequelize-typescript";
import CharacterModel from "../../playermanager/models/CharacterModel";
export default class UserCurrencyAccount extends Model {
    id: string;
    characterId: string;
    character: CharacterModel;
    /**
     * The name of the account. Might be `bank_standard` or `scrap`
     */
    name: string;
    balance: number;
    add(amount: number): void;
    remove(amount: number): boolean;
}
