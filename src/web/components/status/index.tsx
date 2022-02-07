import { useAtom } from "jotai";
import { createRef, FC, useCallback, useEffect, useReducer, useRef, useState } from "react";
import useEvents from "../../../../lib/hooks/useEvents";
import { circles } from "../../state";

const Status: FC = () => {
	const [circles, setCircles] = useState([]);
	const events = useEvents();
	const [lastPacket, setLastPacket] = useState<any>({});

	const cb = useCallback(
		(data: any) => {
			console.log(`circles`, JSON.stringify(circles));
			Object.keys(data).forEach((v) => {
				updateCircle(circles, v, data[v as keyof typeof data]);
			});
		},
		[circles]
	);

	const updateCircle = useCallback(
		(_circles: any[], name: string, pct: number) => {
			const idx = _circles.findIndex((v) => v.name === name);
			if (idx === -1) {
				console.log(`not found`, _circles);
				return;
			}

			const data = _circles[idx];
			data.circumference = 2 * Math.PI * parseInt(data.r);
			const offset = (data.circumference - (pct / 100) * data.circumference).toString();
			data.strokeDashOffset = offset;
			data.strokeDashArray = [data.circumference.toString(), data.circumference.toString()];
			const newArr = [..._circles];
			newArr[idx] = data;
			setCircles([...newArr]);
		},
		[circles]
	);

	const ghettoMemo = useCallback(
		(data) => {
			cb(data);
		},
		[circles]
	);

	useEffect(() => {
		console.log(`CONSTRUCTING THE THING`, JSON.stringify(circles));
	}, [cb]);
	events.addHandler<{ health: number; energy: number; stamina: number }>("hud:status", ghettoMemo);

	useEffect(() => {
		setCircles([
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
		]);
	}, []);

	return (
		<div className="status">
			<svg className="progress-ring" width="300" height="300">
				<circle className="bg" stroke="#EF184B" strokeWidth="20" cx="150" cy="150" r="90" fill="transparent" />
				<circle className="bg" stroke="#61E700" strokeWidth="20" cx="150" cy="150" r="69" fill="transparent" />
				<circle className="bg" stroke="#28D0DB" strokeWidth="20" cx="150" cy="150" r="48" fill="transparent" />

				{circles.map((v, i) => {
					return (
						<circle
							key={i}
							className={v.className}
							stroke={v.stroke}
							strokeWidth={v.strokeWidth}
							strokeDashoffset={v.strokeDashOffset}
							strokeLinecap={v.strokeLineCap}
							cx={v.cx}
							cy={v.cy}
							fill={v.fill}
							r={v.r}
							strokeDasharray={v.strokeDashArray.join(" ")}
						/>
					);
				})}

				<text id="textid" x="100" y="260"></text>
				<text className="txt" x="146" y="65">
					H
				</text>
				<text className="txt" x="146" y="86">
					E
				</text>
				<text className="txt" x="146" y="107">
					S
				</text>
			</svg>
		</div>
	);
};

export default Status;
