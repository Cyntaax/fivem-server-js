import { Status } from "./Status";
export declare enum StatusType {
    Health = "health",
    MaxHealth = "max_health",
    Energy = "energy"
}
declare const health: Status<number>;
declare const maxHealth: Status<number>;
declare const energy: Status<number>;
declare const healthRegen: Status<number>;
declare const healthRegenLimit: Status<number>;
export { health, maxHealth, energy, healthRegen, healthRegenLimit };
