class Status<T> {
	constructor(public readonly name: string) {}

	private _get: () => T | (() => Promise<T>);
	private _set: (input: T) => void | ((input: T) => Promise<void>);

	public setOnGet(caller: () => T) {
		this._get = caller;
	}

	public setOnSet(caller: (input: T) => void) {
		this._set = caller;
	}
}

const health = new Status<number>("health");

health.setOnSet((input) => {
	SetEntityHealth(PlayerPedId(), input);
});
