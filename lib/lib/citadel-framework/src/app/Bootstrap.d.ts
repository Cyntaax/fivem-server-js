/**
 * the bootstrap function. Triggers the loading and instantiation of all the classes
 * @returns {Promise<void>}
 */
export declare const bootstrap: () => Promise<void>;
export declare function DoServerCallback(name: string, cb: Function, ...args: any[]): Promise<void>;
