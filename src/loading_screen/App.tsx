import { FC, useEffect } from "react";
import { Button, ThemeWrapper, Box } from "retro-ui";

///@ts-ignore
import soundFile from "./loading.mp3";

const App: FC = () => {
	useEffect(() => {
		let sound = new Audio(soundFile);
		sound.volume = 0.5;
		sound.play();
		return () => {
			sound.pause();
		};
	}, []);
	return (
		<ThemeWrapper>
			<div className="loader-main">
				<h1>Loading...</h1>
			</div>
		</ThemeWrapper>
	);
};

export default App;
