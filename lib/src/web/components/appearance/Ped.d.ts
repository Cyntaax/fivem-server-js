import { PedSettings } from "./interfaces";
interface PedProps {
    settings: PedSettings;
    storedData: string;
    data: string;
    handleModelChange: (value: string) => void;
}
declare const Ped: ({ settings, storedData, data, handleModelChange }: PedProps) => JSX.Element;
export default Ped;
