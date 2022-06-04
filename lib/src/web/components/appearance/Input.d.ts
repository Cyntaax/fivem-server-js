/// <reference types="react" />
interface InputProps {
    title?: string;
    min?: number;
    max?: number;
    defaultValue: number;
    clientValue: number;
    onChange: (value: number) => void;
}
declare const Input: React.FC<InputProps>;
export default Input;
