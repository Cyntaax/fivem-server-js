import { Module } from "citadel";
import { Sequelize } from "sequelize-typescript";
import * as mysql from "mysql2";
import CharacterModel from "./models/CharacterModel";
import { TestModel } from "./models/TestModel";
import { UserModel } from "./models/UserModel";
@Module({
	name: "db-driver"
})
export default class DbDriver {
	public instance: Sequelize;
	async $onReady() {
		const sequelize = new Sequelize({
			database: GetConvar("mysql_db", ""),
			username: GetConvar("mysql_user", ""),
			password: GetConvar("mysql_password", ""),
			host: GetConvar("mysql_host", ""),
			dialect: "mysql",
			dialectModule: mysql,
			models: [TestModel, UserModel, CharacterModel]
		});

		sequelize.connectionManager
			.getConnection({
				type: "read",
				useMaster: true
			})
			.then(() => {
				console.log(`CONNECTED!`);
			})
			.catch((e) => {
				console.log(`error`, e);
			});

		await UserModel.sync({
			alter: true
		});
		await CharacterModel.sync({
			alter: true
		});

		emit("db:ready");

		this.instance = sequelize;
	}
}
