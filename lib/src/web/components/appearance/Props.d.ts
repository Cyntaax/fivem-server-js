import { PropSettings, PedProp } from "./interfaces";
interface PropsProps {
    settings: PropSettings[];
    data: PedProp[];
    storedData: PedProp[];
    handlePropDrawableChange: (prop_id: number, drawable: number) => void;
    handlePropTextureChange: (prop_id: number, texture: number) => void;
}
declare const Props: ({ settings, data, storedData, handlePropDrawableChange, handlePropTextureChange }: PropsProps) => JSX.Element;
export default Props;
