export declare const Wait: (ms: number) => Promise<unknown>;
export declare function jsonToClass<T, U = any>(entity: new (...args: any[]) => T, json: string | U): T;
export declare function jsonBlanket<T, U>(entity: T, json: string | U): T;
export declare const toHHMMSS: (time: string | number, short?: boolean) => string;
