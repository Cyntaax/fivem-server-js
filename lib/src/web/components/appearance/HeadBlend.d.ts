import { PedHeadBlend, HeadBlendSettings } from "./interfaces";
interface HeadBlendProps {
    settings: HeadBlendSettings;
    storedData: PedHeadBlend;
    data: PedHeadBlend;
    handleHeadBlendChange: (key: keyof PedHeadBlend, value: number) => void;
}
declare const HeadBlend: ({ settings, storedData, data, handleHeadBlendChange }: HeadBlendProps) => JSX.Element;
export default HeadBlend;
