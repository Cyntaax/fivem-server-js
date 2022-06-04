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
	public circles = [
		{
			name: "health",
			className: "progress-ring__hours",
			strokeDashOffset: "0",
			stroke: "#b71c1c",
			strokeWidth: "20",
			strokeLineCap: "round",
			cx: "150",
			cy: "150",
			r: "90",
			fill: "transparent",
			circumference: 0,
			strokeDashArray: ["0", "0"]
		},
		{
			name: "energy",
			className: "progress-ring__energy",
			strokeDashOffset: "0",
			stroke: "#ffb300",
			strokeWidth: "20",
			strokeLineCap: "round",
			cx: "150",
			cy: "150",
			r: "69",
			fill: "transparent",
			circumference: 0,
			strokeDashArray: ["0", "0"]
		},
		{
			name: "stamina",
			className: "progress-ring__energy",
			strokeDashOffset: "0",
			stroke: "#388e3c",
			strokeWidth: "20",
			strokeLineCap: "round",
			cx: "150",
			cy: "150",
			r: "48",
			fill: "transparent",
			circumference: 0,
			strokeDashArray: ["0", "0"]
		},
		{
			name: "breath",
			className: "progress-ring__energy",
			strokeDashOffset: "0",
			stroke: "#0099cc",
			strokeWidth: "5",
			strokeLineCap: "round",
			cx: "150",
			cy: "150",
			r: "32",
			fill: "transparent",
			circumference: 0,
			strokeDashArray: ["0", "0"]
		}
	];

	constructor() {
		makeAutoObservable(this);
	}
}
const circles = new CircleState();

export { circles };
