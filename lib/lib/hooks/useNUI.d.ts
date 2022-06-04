/// <reference types="react" />
import { Locales } from "../../src/modules/appearance/client/shared";
interface Display {
    appearance: boolean;
}
interface NuiContextData {
    display: Display;
    setDisplay(value: Display): void;
    locales?: Locales;
    setLocales(value: Locales): void;
}
declare const NuiStateProvider: React.FC;
declare function useNuiState(): NuiContextData;
export { NuiStateProvider, useNuiState };
