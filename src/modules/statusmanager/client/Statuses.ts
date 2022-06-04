import { Status } from "./Status";

export enum StatusType {
	Health = "health",
	MaxHealth = "max_health",
	Energy = "energy"
}

const health = new Status<number>("health", 300);

health.setOnSet((self, val) => {
	SetEntityHealth(PlayerPedId(), val + 100);
});

health.setOnGet((self) => {
	return GetEntityHealth(PlayerPedId());
});

const maxHealth = new Status<number>("max_health", 300);

maxHealth.setOnGet(() => {
	return GetEntityMaxHealth(PlayerPedId()) - 100;
});
maxHealth.setOnSet((self, val) => {
	SetEntityMaxHealth(PlayerPedId(), val + 100);
});

maxHealth.setGetMax((self) => {
	return 9999;
});

health.setGetMax((self) => {
	return maxHealth.value + 100;
});

const energy = new Status<number>("energy");
energy.setOnGet(() => {
	return energy.state.get("energy") || 0;
});

energy.setOnSet((self, val) => {
	energy.state.set("energy", val);
});

const healthRegen = new Status("health_regen");

healthRegen.state.set("rate", 1.0);

healthRegen.setOnGet((self) => {
	return self.state.get("rate");
});

healthRegen.setOnSet((self, value) => {
	self.state.set("rate", value);
	SetPlayerHealthRechargeMultiplier(PlayerId(), value);
});

const healthRegenLimit = new Status("health_regen_limit");

healthRegenLimit.setOnGet((self) => {
	return GetPlayerHealthRechargeLimit(PlayerId());
});

healthRegenLimit.setOnSet((self, value) => {
	SetPlayerHealthRechargeLimit(PlayerId(), value);
});

export { health, maxHealth, energy, healthRegen, healthRegenLimit };
