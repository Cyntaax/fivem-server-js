class UserIdentifiers {
	public readonly steam: string;
	public readonly discord: string;
	public readonly fivem: string;
	public readonly license: string;
	public readonly ip: string;
}

class Util {
	static getIdentifiers(source: number) {
		const amountIdentifiers = GetNumPlayerIdentifiers(source.toString());
		const userIdentifiers = new UserIdentifiers();
		for (let i = 0; i < amountIdentifiers; i++) {
			const identifier = GetPlayerIdentifier(source.toString(), i);
			const [idType, id] = identifier.split(":");
			Object.defineProperty(userIdentifiers, idType, {
				value: id,
				configurable: true,
				enumerable: true,
				writable: true
			});
		}
		return userIdentifiers;
	}
}

export const Delay = (ms: number): Promise<void> => new Promise((res) => setTimeout(res, ms));

export const isPedFreemodeModel = (ped: number): boolean => {
	const entityModel = GetEntityModel(ped);

	const freemodeMale = GetHashKey("mp_m_freemode_01");
	const freemodeFemale = GetHashKey("mp_f_freemode_01");

	return entityModel === freemodeMale || entityModel === freemodeFemale;
};

export function arrayToVector3(coords: number[]): Vector3 {
	return {
		x: coords[0],
		y: coords[1],
		z: coords[2]
	};
}

export { UserIdentifiers, Util };
