import { Module } from "citadel";
import { Sequelize } from "sequelize-typescript";
import * as mysql from "mysql2";
import CharacterModel from "../../playermanager/models/CharacterModel";
import { TestModel } from "./models/TestModel";
import { UserModel } from "../../playermanager/models/UserModel";
import UserCurrencyAccount from "../../currencymanager/models/UserCurrencyAccount";
@Module({
	name: "db-driver"
})
export default class DbDriver {
	public instance: Sequelize;
	public async $onReady() {
		const sequelize = new Sequelize({
			database: GetConvar("mysql_db", ""),
			username: GetConvar("mysql_user", ""),
			password: GetConvar("mysql_password", ""),
			host: GetConvar("mysql_host", ""),
			dialect: "mysql",
			dialectModule: mysql,
			models: [TestModel, UserModel, CharacterModel, UserCurrencyAccount],
			logging: false
		});

		sequelize.connectionManager
			.getConnection({
				type: "read",
				useMaster: true
			})
			.then(() => {
				console.log(`^5[database]: ^3connection success!^7`);
			})
			.catch((e) => {
				console.log(`error`, e);
			});

		await UserModel.sync({
			alter: true
		});
		await CharacterModel.sync({
			alter: true
		}).catch((e) => {
			console.log(`error character`, e);
		});

		await UserCurrencyAccount.sync({
			alter: true
		}).catch((e) => {
			console.log(`error: `, e);
		});

		emit("db:ready");

		this.instance = sequelize;
	}
}
