export declare class Config<T extends ICitadelConfig = ICitadelConfig> {
    static defaultSpawn: {
        x: number;
        y: number;
        z: number;
        h: number;
    };
    static defaultAccounts: {
        type: string;
        balance: number;
    }[];
    static characterPoints: {
        [key: string]: {
            character: {
                x: number;
                y: number;
                z: number;
                h: number;
            };
            camera: {
                x: number;
                y: number;
                z: number;
                h: number;
            };
        };
    };
    static defaultAppearance: {
        skin: any;
        clothing: any;
    };
    static defaultIdentifier: string;
    static load(): void;
}
export interface ICitadelConfig {
    defaultSpawn: {
        x: number;
        y: number;
        z: number;
        h: number;
    };
    defaultAccounts: {
        type: string;
        balance: number;
    }[];
    characterPoints: {
        [key: string]: {
            character: {
                x: number;
                y: number;
                z: number;
                h: number;
            };
            camera: {
                x: number;
                y: number;
                z: number;
                h: number;
            };
        };
    };
    defaultAppearance: {
        skin: any;
        clothing: any;
    };
}
