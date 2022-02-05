export declare const Command: (commandName: string, options?: {
    restrictors?: any[];
}) => (target: any, name: string, desc: PropertyDescriptor) => void;
