import { Model } from "sequelize-typescript";
import { UserModel } from "./UserModel";
import UserCurrencyAccount from "../../currencymanager/models/UserCurrencyAccount";
export default class CharacterModel extends Model {
    id: string;
    userId: string;
    user: UserModel;
    accounts: UserCurrencyAccount[];
    name: string;
    status_info: PlayerStatus[];
    etc: {
        [key: string]: never;
    };
    getETCValue<T = never>(k: string): T;
    setETCValue<T extends never>(k: string, val: T): void;
    createAccount(name: string, startingBalance?: number): Promise<void>;
}
