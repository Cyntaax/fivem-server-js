import { StatusType } from "./Statuses";
export default class StatusManager {
    statuses: import("./Status").Status<number>[];
    onInit(): Promise<void>;
    onCharacterSelect(): Promise<void>;
    startTracking(): void;
    getAllStatusData(): {
        name: string;
        value: number;
        max: number;
    }[];
    getStatus(name: StatusType): import("./Status").Status<number>;
}
