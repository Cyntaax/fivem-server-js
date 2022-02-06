import { Column, Model, Table, BelongsTo, ForeignKey } from "sequelize-typescript";
import * as uuid from "uuid";
import { UserModel } from "./UserModel";
@Table({
	tableName: "characters"
})
export default class CharacterModel extends Model {
	@Column({
		primaryKey: true,
		unique: true
	})
	id: string = uuid.v4();

	@ForeignKey(() => UserModel)
	@Column
	userId: string;

	@BelongsTo(() => UserModel)
	user: UserModel;

	@Column
	name: string;
}
