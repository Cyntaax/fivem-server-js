/// <reference types="react" />
import { CameraState, RotateState } from "./interfaces";
interface OptionsProps {
    camera: CameraState;
    rotate: RotateState;
    handleSetCamera: (key: keyof CameraState) => void;
    handleTurnAround: () => void;
    handleRotateLeft: () => void;
    handleRotateRight: () => void;
    handleSave: () => void;
    handleExit: () => void;
}
declare const Options: React.FC<OptionsProps>;
export default Options;
