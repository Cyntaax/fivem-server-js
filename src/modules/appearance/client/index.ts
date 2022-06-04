import { Command, Module } from "citadel";
import { init, setPedComponent, setPedProp } from "./appearance";
import "./constants";
import "./customization";
import "./nui";
@Module({
	name: "appearance"
})
export default class AppearanceManager {
	$onReady() {
		init();
		on("gameEventTriggered", (name, args) => {
			console.log(`Game event ${name} ${args.join(", ")}`);
		});
		console.log(`initialized`);
	}

	@Command("clothes")
	clothes() {
		console.log("navigating clothes...");
		SendNuiMessage(
			JSON.stringify({
				event: "web:navigate",
				page: "/appearance"
			})
		);
	}

	@Command("foomit")
	foomit() {
		setPedProp(PlayerPedId(), {
			prop_id: 1,
			texture: 1,
			drawable: 1
		});
	}
}
