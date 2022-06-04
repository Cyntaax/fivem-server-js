interface SelectInputProps {
    title: string;
    items: string[];
    defaultValue: string;
    clientValue: string;
    onChange: (value: string) => void;
}
declare const SelectInput: ({ title, items, defaultValue, clientValue, onChange }: SelectInputProps) => JSX.Element;
export default SelectInput;
