import { Table, Model, Column } from "sequelize-typescript";

@Table({
	tableName: "testModel"
})
export class TestModel extends Model {
	@Column({
		autoIncrement: true,
		primaryKey: true
	})
	id: number;

	@Column
	name: string;

	@Column
	something: boolean;
}
