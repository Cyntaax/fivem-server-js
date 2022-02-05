import "reflect-metadata";
interface IModuleOptions {
    name: string;
    deps?: {
        key: string;
        dep: any;
    }[];
}
export declare function Module(options: IModuleOptions): <T extends new (...args: any[]) => {}>(constructor: T) => void;
export declare const assumeType: (input: any) => {
    type: string;
    value: any;
};
export {};
