import { Hud, Control } from "fivem-js";

type DrawTextOptions = {
	font?: number;
	proportional?: boolean;
	scale?: [number, number];
	color?: [number, number, number];
	alpha?: number;
	dropShadow?: {
		distance?: number;
		color?: [number, number, number];
		alpha?: number;
	};
	edge?: {
		p0?: number;
		color?: [number, number, number];
		alpha?: number;
	};
	outline?: boolean;
	position?: [number, number];
};

const defaultTextOptions: DrawTextOptions = {
	alpha: 255,
	color: [255, 255, 255],
	dropShadow: {
		alpha: 0,
		color: [0, 0, 0],
		distance: 0
	},
	edge: {
		p0: 0,
		color: [0, 0, 0],
		alpha: 0
	},
	font: 0,
	outline: false,
	position: [0, 0],
	proportional: true,
	scale: [0, 0.3]
};

class UI {
	static drawText(text: string, inputOptions: DrawTextOptions) {
		const options: DrawTextOptions = { ...defaultTextOptions, ...inputOptions };
		SetTextFont(options.font);
		SetTextProportional(options.proportional);
		SetTextScale(options.scale[0], options.scale[1]);
		SetTextColour(options.color[0], options.color[1], options.color[2], options.alpha);
		SetTextDropshadow(
			options.dropShadow.distance,
			options.dropShadow.color[0],
			options.dropShadow.color[1],
			options.dropShadow.color[2],
			options.dropShadow.alpha
		);
		SetTextEdge(
			options.edge.p0,
			options.edge.color[0],
			options.edge.color[1],
			options.edge.color[2],
			options.edge.alpha
		);
		if (options.dropShadow) {
			SetTextDropShadow();
		}
		if (options.outline) {
			SetTextOutline();
		}
		SetTextEntry("STRING");
		AddTextComponentString(text);
		DrawText(options.position[0], options.position[1]);
	}
}

export class DebugBox {
	drawingTick: number = 0;
	height = 0.2;
	width = 0.2;
	x = 0.8;
	y = 0.5;
	lines: string[] = [];
	textScale = [0.0, 0.3];

	public draw() {
		clearTick(this.drawingTick);
		console.log(`width`, this.width);
		this.lines.push("Example Text");
		this.lines.push("Another text");
		const height = GetRenderedCharacterHeight(this.textScale[1], 0);
		console.log(`height is`, height);
		this.drawingTick = setTick(() => {
			if (IsControlPressed(0, Control.CharacterWheel) && IsControlPressed(0, Control.FrontendRight)) {
				this.x += 0.0001;
			}
			if (IsControlPressed(0, Control.CharacterWheel) && IsControlPressed(0, Control.FrontendLeft)) {
				this.x -= 0.0001;
			}
			DrawRect(this.x, this.y, this.width, this.height, 0, 0, 255, 255);
			let offsety = this.y - this.height / 2;
			for (const [idx, line] of this.lines.entries()) {
				if (idx > 0) {
					offsety += height * idx;
				}
				const offsetx = this.x - this.width / 2 + 0.003;
				UI.drawText(line, {
					position: [offsetx, offsety],
					scale: [this.textScale[0], this.textScale[1]],
					proportional: true
				});
			}
		});
	}
}
