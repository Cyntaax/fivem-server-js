import { HairSettings, HeadOverlaysSettings, EyeColorSettings, PedHair, PedHeadOverlays, PedHeadOverlayValue } from "./interfaces";
interface HeadOverlaysProps {
    settings: {
        hair: HairSettings;
        headOverlays: HeadOverlaysSettings;
        eyeColor: EyeColorSettings;
    };
    storedData: {
        hair: PedHair;
        headOverlays: PedHeadOverlays;
        eyeColor: number;
    };
    data: {
        hair: PedHair;
        headOverlays: PedHeadOverlays;
        eyeColor: number;
    };
    handleHairChange: (key: keyof PedHair, value: number) => void;
    handleHeadOverlayChange: (key: keyof PedHeadOverlays, option: keyof PedHeadOverlayValue, value: number) => void;
    handleEyeColorChange: (value: number) => void;
}
declare const HeadOverlays: ({ settings, storedData, data, handleHairChange, handleHeadOverlayChange, handleEyeColorChange }: HeadOverlaysProps) => JSX.Element;
export default HeadOverlays;
