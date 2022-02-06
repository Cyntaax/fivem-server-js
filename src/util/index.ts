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

export { UserIdentifiers, Util };
