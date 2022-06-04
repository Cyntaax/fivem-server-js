export declare let playerHeading: number;
export declare function getAppearance(): PedAppearance;
export declare function getComponentSettings(ped: number, componentId: number): ComponentSettings;
export declare function getPropSettings(ped: number, propId: number): PropSettings;
export declare function getAppearanceSettings(): AppearanceSettings;
export declare function getConfig(): CustomizationConfig;
export declare function setCamera(key: string): void;
export declare function rotateCamera(direction: "left" | "right"): Promise<void>;
export declare function pedTurnAround(ped: number): void;
export declare function exitPlayerCustomization(appearance?: PedAppearance): void;
export declare function loadModule(): void;
declare const _default: {
    loadModule: typeof loadModule;
};
export default _default;
