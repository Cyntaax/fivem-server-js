declare type HandlerFunc<T> = (data: T) => void;
declare type HandlerFuncArray = HandlerFunc<any>[];
declare const useEvents: () => {
    handlers: Map<string, HandlerFuncArray>;
    addHandler<T>(event: string, handler: HandlerFunc<T>): void;
};
export default useEvents;
