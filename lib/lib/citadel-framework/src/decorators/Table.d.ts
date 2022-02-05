import 'reflect-metadata';
export declare function Table(): <T extends new (...args: any[]) => {}>(constructor: T) => {
    new (...args: any[]): {};
} & T;
