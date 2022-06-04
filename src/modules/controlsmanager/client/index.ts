import { Module } from "citadel";
import { Control } from "fivem-js";

@Module({
	name: "controlsmanager"
})
export class ControlsManager {
	public disabledControls: number[] = [Control.FrontendPause, Control.FrontendPauseAlternate];
	$onReady() {
		console.log(`Disabled controls ready`);
		setTick(() => {
			for (const control of this.disabledControls) {
				DisableControlAction(0, control, true);
			}
		});
	}
}
