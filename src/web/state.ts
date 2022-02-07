import { useAtom } from "jotai";
import { atom } from "jotai/esm";
import { makeAutoObservable } from "mobx";

type CircleInfo = {
	className: string;
	strokeDashOffset: string;
	strokeWidth: string;
	strokeLineCap: "round";
	cx: string;
	cy: string;
	stroke: string;
	r: string;
	fill: string;
	circumference: number;
	name: string;
	strokeDashArray: [string, string];
};

class CircleState {
	public circles: any[] = [];

	constructor() {
		makeAutoObservable(this);
	}
}
const circles = new CircleState();

export { circles };
