type StatusGetter<T, U> = (self: U) => T;
type StatusSetter<T, U> = (self: U, input: T) => void;

type StatusChangeHandler = (changed: number, before: number) => void;

export class Status<T extends number> {
	private _get: StatusGetter<T, Status<T>>;
	private _set: StatusSetter<T, Status<T>>;

	private _getEntity: StatusGetter<T, Status<T>>;

	private _max: StatusGetter<T, Status<T>>;

	private _default: T | number = 0;

	public readonly state: Map<string, any> = new Map<string, any>();

	private events = new Map<string, any[]>();

	constructor(public readonly name: string, public readonly defaultValue = 0) {
		this._max = (status) => {
			return 100 as unknown as any;
		};
	}

	public setOnGet(caller: StatusGetter<T, Status<T>>) {
		this._get = caller;
	}

	public setOnSet(caller: StatusSetter<T, Status<T>>) {
		this._set = caller;
	}

	public setGetMax(caller: StatusGetter<T, Status<T>>) {
		this._max = caller;
	}

	get value() {
		return this._get(this);
	}

	set value(input) {
		const current = this.value;
		this._set(this, input);
		if (input < current) {
			const diff = current - input;
			this.handleDecrease(diff, current);
		} else if (input > current) {
			const diff = current - input;
			this.handleIncrease(diff, current);
		}
	}

	get max() {
		return this._max(this);
	}

	public setValueSilent(value: T) {
		this._set(this, value);
	}

	private handleDecrease(changed: number, before: number) {
		const handlers = this.events.get("decrease");
		if (handlers) {
			for (const handler of handlers) {
				handler(changed, before);
			}
		}
	}

	private handleIncrease(changed: number, before: number) {
		const handlers = this.events.get("increase");
		if (handlers) {
			for (const handler of handlers) {
				handler(changed, before);
			}
		}
	}

	public onIncrease(cb: StatusChangeHandler) {
		let existing = this.events.get("increase");
		if (!existing) {
			this.events.set("increase", []);
		}
		existing = this.events.get("increase");
		existing.push(cb);
	}

	public onDecrease(cb: StatusChangeHandler) {
		let existing = this.events.get("decrease");
		if (!existing) {
			this.events.set("decrease", []);
		}
		existing = this.events.get("decrease");
		existing.push(cb);
	}

	public data() {
		return {
			name: this.name,
			value: this.value,
			max: this.max
		};
	}
}
