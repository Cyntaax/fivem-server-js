declare type StatusGetter<T, U> = (self: U) => T;
declare type StatusSetter<T, U> = (self: U, input: T) => void;
declare type StatusChangeHandler = (changed: number, before: number) => void;
export declare class Status<T extends number> {
    readonly name: string;
    readonly defaultValue: number;
    private _get;
    private _set;
    private _getEntity;
    private _max;
    private _default;
    readonly state: Map<string, any>;
    private events;
    constructor(name: string, defaultValue?: number);
    setOnGet(caller: StatusGetter<T, Status<T>>): void;
    setOnSet(caller: StatusSetter<T, Status<T>>): void;
    setGetMax(caller: StatusGetter<T, Status<T>>): void;
    get value(): T;
    set value(input: T);
    get max(): T;
    setValueSilent(value: T): void;
    private handleDecrease;
    private handleIncrease;
    onIncrease(cb: StatusChangeHandler): void;
    onDecrease(cb: StatusChangeHandler): void;
    data(): {
        name: string;
        value: T;
        max: T;
    };
}
export {};
