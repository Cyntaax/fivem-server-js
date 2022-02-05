/**
 * Define an argument for an @Command handler
 * @param {string} arg_name
 * @param {{validator?: (v: (string | boolean | number)) => void, default?: any}} options
 * @returns {(target: any, name: string, idx: number) => void}
 */
export declare function Arg(arg_name?: string, options?: {
    validator?: (v: string | boolean | number) => void;
    default?: any;
}): (target: any, name: string, idx: number) => void;
