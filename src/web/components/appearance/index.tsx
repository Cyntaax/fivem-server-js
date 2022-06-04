import GlobalStyles from "./global";
import { FC } from "react";
import { NuiStateProvider } from "../../../../lib/hooks/useNUI";
import Appearance from "./Appearance";
import { EventListener } from "./nui";

const AppearancePage: FC = () => {
	return (
		<NuiStateProvider>
			<Appearance />
			<GlobalStyles />
			<EventListener />
		</NuiStateProvider>
	);
};

export { AppearancePage };
