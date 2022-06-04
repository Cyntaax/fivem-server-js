declare class UserIdentifiers {
    readonly steam: string;
    readonly discord: string;
    readonly fivem: string;
    readonly license: string;
    readonly ip: string;
}
declare class Util {
    static getIdentifiers(source: number): UserIdentifiers;
}
export declare const Delay: (ms: number) => Promise<void>;
export declare const isPedFreemodeModel: (ped: number) => boolean;
export declare function arrayToVector3(coords: number[]): Vector3;
export { UserIdentifiers, Util };
