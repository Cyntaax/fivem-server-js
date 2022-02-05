import { Module, Event } from "citadel";
import { TestModel } from "../../db-driver/server/models/TestModel";

@Module({
	name: "base-events-sv"
})
export default class BaseEventsSv {
	@Event("db:ready")
	onDbReady() {
		const p = new TestModel();
		p.name = "hello";
		p.something = true;

		p.save()
			.then(() => {
				console.log(`created test model`);
			})
			.catch((e) => {
				console.log(`error`, e);
			});
	}
}
