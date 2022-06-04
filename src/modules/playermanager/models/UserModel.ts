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
	public id: string;

	public source = 0;

	@Column
	public name: string;

	@Column
	public connectionCount: number;

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
	public banInfo: BanInfo;

	@HasMany(() => CharacterModel, "userId")
	public characters: CharacterModel[];

	private _activeCharacter = "";

	public get currentCharacter() {
		return this.characters.find((v) => v.id === this._activeCharacter);
	}

	public setCharacter(character: CharacterModel) {
		this._activeCharacter = character.id;
		emitNet("pm:charselected", this.source);
	}

	public async createCharacter(name: string) {
		const character = new CharacterModel();
		character.name = name;
		character.user = this;
		character.userId = this.id;
		await character.save();
		character.player = this;
		this.characters.push(character);
	}
}
