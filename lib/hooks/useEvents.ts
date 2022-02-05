import * as React from "react";

const windowEventSet = React.createContext(false);
type HandlerFunc<T> = (data: T) => void;
type HandlerFuncArray = HandlerFunc<any>[];
const useEvents = () => {
	const isSet = React.useContext(windowEventSet);
	const onEvent = {
		handlers: new Map<string, HandlerFuncArray>(),
		addHandler<T>(event: string, handler: HandlerFunc<T>) {
			const existing = this.handlers.get(event);
			if (existing) {
				existing.push(handler);
				return;
			}
			this.handlers.set(event, []);
			const output = this.handlers.get(event);
			output.push(handler);
		}
	};
	React.useEffect(() => {
		if (isSet === true) {
			return;
		}
		const eventListener = (ev: MessageEvent) => {
			console.log("data", JSON.stringify(ev.data));
			const existing = onEvent.handlers.get(ev.data.event);
			if (existing) {
				existing.forEach((v) => {
					v(ev.data);
				});
			}
		};
		window.addEventListener("message", eventListener);
		return () => {
			window.removeEventListener("message", eventListener);
		};
	}, []);

	return onEvent;
};

export default useEvents;
