import { ICitadelConfig } from "../app/Config";
export declare const root: {
    app: any;
};
export declare function Root<T extends ICitadelConfig = ICitadelConfig>(config?: T): <T_1 extends new (...args: any[]) => {}>(constructor: T_1) => void;
