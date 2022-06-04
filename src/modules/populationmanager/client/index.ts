import { Module } from "citadel";

@Module({
	name: "populationmanager"
})
export class PopulationManager {
	vehicleMultiplier = 0;
	pedMultiplier = 0;
	randomVehicleMultiplier = 0;
	parkedVehicleMultiplier = 0;
	scenarioPedMultiplier = 0;
	$onReady() {
		setTick(() => {
			SetVehicleDensityMultiplierThisFrame(this.vehicleMultiplier);
			SetPedDensityMultiplierThisFrame(this.pedMultiplier);
			SetRandomVehicleDensityMultiplierThisFrame(this.randomVehicleMultiplier);
			SetParkedVehicleDensityMultiplierThisFrame(this.parkedVehicleMultiplier);
			SetScenarioPedDensityMultiplierThisFrame(this.scenarioPedMultiplier, this.scenarioPedMultiplier);
		});
	}
}
