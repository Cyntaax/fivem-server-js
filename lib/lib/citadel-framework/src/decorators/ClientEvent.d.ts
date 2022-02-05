/**
 * Registers a client event. Wrapper for `RegisterNetEvent`
 * @param {string} name The name of the event to listen for
 */
export declare function ClientEvent(name: string): (target: any, propertyName: string, desc: PropertyDescriptor) => void;
export declare function NetEvent(name: string): (target: any, propertyName: string, desc: PropertyDescriptor) => void;
export declare function Event(name: string): (target: any, propertyName: string, desc: PropertyDescriptor) => void;
