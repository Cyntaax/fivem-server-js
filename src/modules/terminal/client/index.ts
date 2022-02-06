import { Command, Module } from "citadel";
import { NUI } from "../../../../lib/citadel-framework/src/decorators/NUI";

@Module({
	name: "terminal"
})
export class Terminal {
	$onReady() {
		console.log("registering");
		RegisterKeyMapping("terminal", "toggle the terminal", "keyboard", "t");
	}

	@Command("terminal")
	onTerminal() {
		console.log("toggling terminal");
		SendNuiMessage(
			JSON.stringify({
				event: "web:navigate",
				page: "/login"
			})
		);
	}

	@NUI("terminalToggle")
	onToggle(data: any, cb: any) {
		console.log(`on terminal toggle`);
		SetNuiFocus(false, false);
		cb("");
	}
}
