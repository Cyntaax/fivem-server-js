import { PedFaceFeatures, FaceFeaturesSettings } from "./interfaces";
interface FaceFeaturesProps {
    settings: FaceFeaturesSettings;
    storedData: PedFaceFeatures;
    data: PedFaceFeatures;
    handleFaceFeatureChange: (key: keyof PedFaceFeatures, value: number) => void;
}
declare const FaceFeatures: ({ settings, storedData, data, handleFaceFeatureChange }: FaceFeaturesProps) => JSX.Element;
export default FaceFeatures;
