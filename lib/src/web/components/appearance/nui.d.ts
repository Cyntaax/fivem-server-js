declare function post(event: string, data?: {}): Promise<any>;
declare function onEvent(type: string, func: any): void;
declare function emitEvent(type: string, payload: any): void;
declare const Nui: {
    post: typeof post;
    onEvent: typeof onEvent;
    emitEvent: typeof emitEvent;
};
export default Nui;
export declare const EventListener: () => any;
