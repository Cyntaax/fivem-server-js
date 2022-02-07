export default class EXPManager {
    currentXP: number;
    ranks: number[];
    maxRank: number;
    addXP(xp: number): void;
    removeXP(xp: number): void;
    getXPFloorForLevel(level: number): number;
    getXPCeilingForLevel(level: number): number;
    getLevelFromXP(xpAmount: number): number;
}
