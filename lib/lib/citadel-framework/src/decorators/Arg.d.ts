export declare function Arg(arg_name?: string, options?: {
    validator?: (v: string | boolean | number) => void;
    default?: any;
}): (target: any, name: string, idx: number) => void;
