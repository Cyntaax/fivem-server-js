export class Config<T extends ICitadelConfig = ICitadelConfig> {
    static defaultSpawn: {
        x: number,
        y: number,
        z: number,
        h: number
    }
    static defaultAccounts: {
        type: string,
        balance: number,
    }[]
    static characterPoints: {
        [key: string]: { character: { x: number, y: number, z: number, h: number }, camera: {  x: number, y: number, z: number, h: number } }
    }
    static defaultAppearance: {
        skin: any,
        clothing: any
    }

    static defaultIdentifier = "steam"

    static load() {
        const cfgstr = LoadResourceFile(GetCurrentResourceName(), "config.json")
        const jobj = JSON.parse(cfgstr)
        Object.keys(jobj).forEach(v => {
            /// @ts-ignore
            Config[v] = jobj[v]
        })
    }
}

export interface ICitadelConfig {
    defaultSpawn: {
        x: number,
        y: number,
        z: number,
        h: number
    },
    defaultAccounts: {
        type: string,
        balance: number,
    }[],
    characterPoints: {
        [key: string]: { character: { x: number, y: number, z: number, h: number }, camera: {  x: number, y: number, z: number, h: number } }
    },
    defaultAppearance: {
        skin: any,
        clothing: any
    }
}