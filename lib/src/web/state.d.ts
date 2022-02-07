declare class CircleState {
    circles: {
        name: string;
        className: string;
        strokeDashOffset: string;
        stroke: string;
        strokeWidth: string;
        strokeLineCap: string;
        cx: string;
        cy: string;
        r: string;
        fill: string;
        circumference: number;
        strokeDashArray: string[];
    }[];
    constructor();
}
declare const circles: CircleState;
export { circles };
