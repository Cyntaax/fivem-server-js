import { Column, Model, Table, ForeignKey, BelongsTo } from "sequelize-typescript";
import * as uuid from "uuid";
import CharacterModel from "../../playermanager/models/CharacterModel";

@Table({})
export default class UserCurrencyAccount extends Model {
	@Column({
		primaryKey: true,
		unique: true,
		defaultValue: () => uuid.v4()
	})
	public id: string;

	@ForeignKey(() => CharacterModel)
	@Column
	public characterId: string;

	@BelongsTo(() => CharacterModel)
	public character: CharacterModel;

	/**
	 * The name of the account. Might be `bank_standard` or `scrap`
	 */
	@Column({
		allowNull: false
	})
	public name: string;

	@Column({
		defaultValue: () => 0
	})
	public balance: number;

	public add(amount: number) {
		// TODO: perform other add logic

		this.balance += amount;
	}

	public remove(amount: number): boolean {
		// TODO: Add other remove logic

		if (this.balance < amount) {
			return false;
		}

		this.balance -= amount;

		return true;
	}
}
