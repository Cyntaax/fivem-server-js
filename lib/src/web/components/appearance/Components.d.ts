import { ComponentSettings, PedComponent } from "./interfaces";
interface ComponentsProps {
    settings: ComponentSettings[];
    data: PedComponent[];
    storedData: PedComponent[];
    handleComponentDrawableChange: (component_id: number, drawable: number) => void;
    handleComponentTextureChange: (component_id: number, texture: number) => void;
}
declare const Components: ({ settings, data, storedData, handleComponentDrawableChange, handleComponentTextureChange }: ComponentsProps) => JSX.Element;
export default Components;
