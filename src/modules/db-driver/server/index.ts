import { Module } from "citadel";
import { Sequelize } from "sequelize-typescript";
import * as mysql from "mysql2";
import { TestModel } from "./models/TestModel";
@Module({
	name: "db-driver"
})
export default class DbDriver {
	public instance: Sequelize;
	$onReady() {
		const sequelize = new Sequelize({
			database: GetConvar("mysql_db", ""),
			username: GetConvar("mysql_user", ""),
			password: GetConvar("mysql_password", ""),
			host: GetConvar("mysql_host", ""),
			dialect: "mysql",
			dialectModule: mysql,
			models: [TestModel]
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

		sequelize.sync().then(() => {
			emit("db:ready");
		});

		this.instance = sequelize;
	}
}
