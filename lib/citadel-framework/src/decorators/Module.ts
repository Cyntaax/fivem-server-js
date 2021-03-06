import "reflect-metadata";

import { Cache } from "../app/Cache";

interface IModuleOptions {
	name: string;
	deps?: {
		key: string;
		dep: any;
	}[];
}

export function Module(options: IModuleOptions) {
	return function <T extends { new (...args: any[]): {} }>(constructor: T) {
		const commands = (Reflect.getOwnMetadata("commands", constructor.prototype) as any[]) || [];

		const argors = (Reflect.getOwnMetadata("argors", constructor.prototype) as any) || {};

		const ticks = (Reflect.getOwnMetadata("ticks", constructor.prototype) as any) || {};

		const injectables = (Reflect.getOwnMetadata("ijdecors", constructor.prototype) as any) || {};

		const mapsourcer = (Reflect.getOwnMetadata("mapsourcer", constructor.prototype) as any) || {};

		const keys = (Reflect.getOwnMetadata("keys", constructor.prototype) as unknown as any[]) || [];

		const nuis = (Reflect.getOwnMetadata("nuis", constructor.prototype) as unknown as any[]) || [];

		let events = (Reflect.getOwnMetadata("events", constructor.prototype) as any) || {};

		let scb = (Reflect.getOwnMetadata("scb", constructor.prototype) as unknown as { [key: string]: any }) || {};

		const http_gets = (Reflect.getOwnMetadata("http_gets", constructor.prototype) as any[]) || [];

		let exportz =
			(Reflect.getOwnMetadata("exportz", constructor.prototype) as unknown as { [key: string]: any }) || {};

		if (events === undefined) {
			Reflect.defineMetadata("events", {}, constructor.prototype);
		}

		events = (Reflect.getOwnMetadata("events", constructor.prototype) as any) || {};

		const regevents = (Reflect.getOwnMetadata("regevents", constructor.prototype) as any) || {};

		let enabled = Reflect.getOwnMetadata("enabled", constructor.prototype);

		if (enabled === undefined) {
			Reflect.defineMetadata("enabled", true, constructor.prototype);
		}

		enabled = Reflect.getOwnMetadata("enabled", constructor.prototype);

		let ident: string;

		ident = options.name;
		const tr = class extends constructor {
			ident = ident;
			_depsToLoad: any = options.deps || [];
			constructor(...args: any[]) {
				super(...args);

				keys.forEach((v: any) => {
					const ktick = setTick(() => {
						if (IsControlJustReleased(0, v.key)) {
							/// @ts-ignore
							this[v.methodName]();
						}
					});
				});

				for (const nui of nuis) {
					console.log(`register`, nui.event);
					RegisterNuiCallbackType(nui.event);
					on(`__cfx_nui:${nui.event}`, (data: any, cb: Function) => {
						///@ts-ignore
						this[nui.methodName](data, cb);
					});
				}

				if (Cache.serverCallbacks[ident] === undefined) {
					Cache.serverCallbacks[ident] = {} as { [key: string]: any };
				}

				Object.keys(scb).forEach((v) => {
					Cache.serverCallbacks[ident][v] = scb[v].methodName;
				});

				commands.forEach((v) => {
					/// @ts-ignore
					RegisterCommand(
						v.command,
						(...args: any[]) => {
							const enabled = Reflect.getMetadata("enabled", this);
							if (!enabled) {
								return;
							}
							let errors: any[] = [];
							let restrictorFail = false;
							if (v.restrictors) {
								for (const restrictor of v.restrictors) {
									if (restrictor() === false) {
										restrictorFail = true;
										errors.push(`You do not have permission to run this command!`);
										break;
									}
								}
							}

							if (errors.length > 0) {
								errors.forEach((v) => {
									if (IsDuplicityVersion()) {
										console.log(v);
									}
								});
								return;
							}
							/// @ts-ignore
							this[v.handler](args[0], [...args[1]]);
						},
						false
					);
				});

				Object.keys(regevents).forEach((v) => {
					on(v, (...args: any[]) => {
						console.log(`doing event ${v} ${source} ${JSON.stringify(args)}`);
						/// @ts-ignore
						this[regevents[v].methodName](...args);
					});
				});

				Object.keys(exportz).forEach((v) => {
					global.exports(`${ident}_${v}`, (...args: any[]) => {
						console.log(`all args ${JSON.stringify(args)}`);
						return "f33";
						/// @ts-ignore
						//const ret = await Promise.resolve(this[exportz[v].methodName](...args))
						//console.log(`epport ret ${ret }`)
					});
				});

				Object.keys(events).forEach((v) => {
					onNet(v, (...args: any[]) => {
						let _source = global.source;
						if (isNaN(_source)) {
							if (typeof args[0] === "number") {
								_source = args[0];
								args.splice(0, 1);
							}
						}
						/// @ts-ignore
						console.log(`map sourcer? ${source}`);
						if (mapsourcer !== undefined) {
							/// @ts-ignore
							if (typeof mapsourcer[events[v].methodName] !== "undefined") {
								console.log(`map sourcing! ${_source} ${typeof _source}`);
								/// @ts-ignore
								let sourced = mapsourcer[events[v].methodName];
								/// @ts-ignore
								args[sourced.idx] = Cache.moduleCache[sourced.module][sourced.method](_source);
								if (args[sourced.idx] === undefined) {
									console.log(`^1Failed to map source to object^0`);
									return;
								}
							}
						}

						console.log(`exec event! ${events[v].methodName}`);
						/// @ts-ignore
						this[events[v].methodName](...args);
					});
				});

				Object.keys(ticks).forEach((v) => {
					const tick = setTick(() => {
						/// @ts-ignore
						this[ticks[v].methodName]();
					});

					Cache.ticks[v] = {
						name: v,
						id: tick
					};
				});

				Object.keys(argors).forEach((v) => {
					/// @ts-ignore
					if (typeof this[v] === "function") {
						/// @ts-ignore
						const method = this[v];

						const newmethod = function (...args: string[]) {
							const enabled = Reflect.getMetadata("enabled", this);
							if (!enabled) {
								return;
							}
							console.log(`^3ARGUMENTS: ${JSON.stringify(arguments)}^0`);
							const unpacked: any[] = [];
							let newArgs: string[] = [];
							unpacked.push(args[0]);
							if (typeof arguments[1] !== "object") {
								if (Object.entries(arguments).length >= 2) {
									for (let i = 1; i < Object.keys(arguments).length; i++) {
										newArgs.push(arguments[i]);
									}
								}
							}
							if (newArgs.length > 0) {
								arguments[1] = newArgs;
							}
							Object.entries(argors[v].sort((a: any, b: any) => a.index - b.index));
							let errors: any[] = [];
							argors[v].forEach(
								(param: {
									index: number;
									expectedType: string;
									name: string;
									options: { validator: any; optional: boolean; default: any };
								}) => {
									if (arguments[1] !== undefined) {
										/// @ts-ignore
										let type: any;

										if (arguments[1][param.index - 1] === undefined && !param.options.default) {
											errors.push(
												`No value specified for argument ${param.name} => expects ${param.expectedType}`
											);
										}

										if (arguments[1][param.index - 1] === undefined) {
											if (param.options.default) {
												arguments[1][param.index - 1] = param.options.default;
											}
										}
										let tmp = arguments[1][param.index - 1];
										let assumed = assumeType(tmp);

										/// @ts-ignore
										if (assumed.type !== param.expectedType) {
											errors.push(
												`Parameter ${param.name} expects type "${param.expectedType}" but got "${assumed}"`
											);
										}

										if (typeof param.options.validator === "function") {
											const er = param.options.validator(tmp);
											if (er === false) {
												errors.push(`Invalid usage of ${param.name}`);
											}
										}

										unpacked.push(assumed.value);
										arguments[1][param.index - 1] = null;
									}
								}
							);

							if (errors.length > 0) {
								errors.forEach((v) => {
									console.log(v);
								});
								return;
							}

							const tmp2: any[] = [];
							arguments[1].forEach((v: any) => {
								if (v !== null) {
									tmp2.push(v);
								}
							});

							unpacked.push(tmp2);

							console.log(`calling with ${JSON.stringify(unpacked)}`);

							return method.apply(this, unpacked);
						};

						/// @ts-ignore
						this[v] = newmethod;
					}
				});
			}
		};

		Cache.modules[ident.toLowerCase()] = tr;
	};
}

export const assumeType = (input: any) => {
	if (typeof input === undefined || input === null) {
		return {
			type: undefined as undefined,
			value: undefined as undefined
		};
	}
	if (!isNaN(parseInt(input))) {
		return {
			type: "Number",
			value: Number(input)
		};
	}

	if (input === "true" || input === "false") {
		return {
			type: "Boolean",
			value: input === "true"
		};
	}

	return {
		type: "String",
		value: input
	};
};

interface Type<T> {
	new (...args: any[]): T;
}
