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
export { UserIdentifiers, Util };
