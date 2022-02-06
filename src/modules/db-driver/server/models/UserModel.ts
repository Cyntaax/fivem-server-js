import { Column, Model, Table, DataType, HasMany, ForeignKey } from "sequelize-typescript";
import CharacterModel from "./CharacterModel";

const defaultBan: BanInfo = {
	until: 0,
	by: "",
	reason: ""
};

@Table({
	tableName: "users"
})
export class UserModel extends Model {
	@Column({
		primaryKey: true,
		unique: true
	})
	id: string;

	source: number = 0;

	@Column
	name: string;

	@Column
	connectionCount: number;

	@Column({
		type: DataType.TEXT,
		get() {
			return JSON.parse(this.getDataValue("banInfo"));
		},
		set(value: BanInfo) {
			return this.setDataValue("banInfo", JSON.stringify(value));
		},
		defaultValue: JSON.stringify(defaultBan)
	})
	banInfo: BanInfo;

	@HasMany(() => CharacterModel, "userId")
	characters: CharacterModel[];

	async createCharacter(name: string) {
		const character = new CharacterModel();
		character.name = name;
		character.user = this;
		character.userId = this.id;
		await character.save();
	}
}
