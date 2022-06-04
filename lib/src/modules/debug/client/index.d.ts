import StatusManager from "../../statusmanager/client";
export declare class Debug {
    statusManager: StatusManager;
    constructor(statusManager: StatusManager);
    sudoku(): void;
    revive(): void;
    debug1(): void;
    hurtme(): void;
    setStatus(source: number, status: string, value: number): void;
    pause(): void;
    tp(source: number, x: number, y: number, z: number): void;
    spawnCar(source: number, model: string): Promise<void>;
}
