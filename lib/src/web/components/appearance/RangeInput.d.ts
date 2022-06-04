/// <reference types="react" />
interface RangeInputProps {
    title?: string;
    min: number;
    max: number;
    factor?: number;
    defaultValue?: number;
    clientValue?: number;
    onChange: (value: number) => void;
}
declare const RangeInput: React.FC<RangeInputProps>;
export default RangeInput;
