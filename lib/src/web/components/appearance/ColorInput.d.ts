/// <reference types="react" />
interface ColorInputProps {
    title?: string;
    colors?: number[][];
    defaultValue?: number;
    clientValue?: number;
    onChange: (value: number) => void;
}
declare const ColorInput: React.FC<ColorInputProps>;
export default ColorInput;
