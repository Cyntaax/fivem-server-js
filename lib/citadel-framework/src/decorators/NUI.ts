// __cfx_nui:Weight

export const NUI = (eventName: string) => {
	return (target: any, name: string, desc: PropertyDescriptor) => {
		const method = desc.value;

		desc.value = function (...args: any[]) {
			const res = method.apply(this, args);
			return res;
		};

		let commands = Reflect.getOwnMetadata("nuis", target);

		if (commands === undefined) {
			Reflect.defineMetadata("nuis", [], target);
		}

		commands = Reflect.getOwnMetadata("nuis", target);

		commands.push({
			event: eventName,
			methodName: name
		});
	};
};
