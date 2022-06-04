import { useAtom } from "jotai";
import { observer } from "mobx-react-lite";
import { createRef, FC, useEffect, useReducer, useRef, useState } from "react";
import useEvents from "../../../../lib/hooks/useEvents";
import { circles } from "../../state";

const Status: FC = observer(() => {
	const _circles = circles.circles;
	const [a, b] = useState([]);
	const events = useEvents();
	events.addHandler<{ payload: { name: string; value: number; max: number }[] }>("hud:status", (data) => {
		for (const status of data.payload) {
			const pct = (status.value / status.max) * 100;
			updateCircle(status.name, pct);
		}
	});

	const updateCircle = (name: string, pct: number) => {
		const idx = _circles.findIndex((v) => v.name === name);
		if (idx === -1) {
			return;
		}

		const data = _circles[idx];
		data.circumference = 2 * Math.PI * parseInt(data.r);
		const offset = (data.circumference - (pct / 100) * data.circumference).toString();
		data.strokeDashOffset = offset;
		data.strokeDashArray = [data.circumference.toString(), data.circumference.toString()];
		const newArr = [..._circles];
		newArr[idx] = data;
		circles.circles = [...newArr];
	};

	return (
		<div className="status">
			<svg className="progress-ring" width="300" height="300">
				<circle className="bg" stroke="#EF184B" strokeWidth="20" cx="150" cy="150" r="90" fill="transparent" />
				<circle className="bg" stroke="#61E700" strokeWidth="20" cx="150" cy="150" r="69" fill="transparent" />
				<circle className="bg" stroke="#28D0DB" strokeWidth="20" cx="150" cy="150" r="48" fill="transparent" />

				{_circles.map((v, i) => {
					return (
						<circle
							key={i}
							className={v.className}
							stroke={v.stroke}
							strokeWidth={v.strokeWidth}
							strokeDashoffset={v.strokeDashOffset}
							strokeLinecap={v.strokeLineCap as "round"}
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
});

export default Status;
