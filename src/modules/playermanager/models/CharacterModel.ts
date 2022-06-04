import { Column, Model, Table, BelongsTo, ForeignKey, DataType, HasMany } from "sequelize-typescript";
import * as uuid from "uuid";
import { UserModel } from "./UserModel";
import UserCurrencyAccount from "../../currencymanager/models/UserCurrencyAccount";
@Table({
	tableName: "characters"
})
export default class CharacterModel extends Model {
	@Column({
		primaryKey: true,
		unique: true
	})
	public id: string = uuid.v4();

	public player: UserModel;

	@ForeignKey(() => UserModel)
	@Column
	public userId: string;

	@BelongsTo(() => UserModel)
	public user: UserModel;

	@HasMany(() => UserCurrencyAccount, "characterId")
	public accounts: UserCurrencyAccount[];

	@Column
	public name: string;

	@Column({
		type: DataType.TEXT,
		get() {
			return JSON.parse(this.getDataValue("status_info"));
		},
		set(value: PlayerStatus[]) {
			return this.setDataValue("status_info", JSON.stringify(value));
		},
		defaultValue: JSON.stringify([])
	})
	public status_info: PlayerStatus[];

	@Column({
		type: DataType.TEXT,
		get() {
			return JSON.parse(this.getDataValue("etc"));
		},
		set(v: never) {
			this.setDataValue("etc", v);
		},
		defaultValue: JSON.stringify({})
	})
	public etc: { [key: string]: never };

	public getETCValue<T = never>(k: string): T {
		return this.etc[k];
	}

	public setETCValue<T extends never>(k: string, val: T) {
		this.etc[k] = val;
	}

	public async createAccount(name: string, startingBalance = 0) {
		if (this.accounts) {
			const exist = this.accounts.find((v) => v.name === name);
			if (exist) {
				throw new Error(`account with name ${name} already exists for character ${this.id}`);
			}
		}

		const account = new UserCurrencyAccount({
			characterId: this.id,
			name,
			balance: startingBalance
		});
		try {
			const savedAccount = await account.save();
			this.accounts.push(savedAccount);
		} catch (e) {
			console.log(e);
			throw new Error("failed to save account");
		}
	}
}
