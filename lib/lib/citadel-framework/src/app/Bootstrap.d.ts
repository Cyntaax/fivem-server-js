/**
 * the bootstrap function. Triggers the loading and instantiation of all the classes
 * @returns {Promise<void>}
 */
export declare const bootstrap: () => Promise<void>;
export declare function DoServerCallback(name: string, cb: Function, ...args: any[]): void;
export declare const AsyncServerCallback: <T = any>(name: string, ...args: any[]) => Promise<T>;
