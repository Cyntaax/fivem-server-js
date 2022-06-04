import * as ReactDOM from "react-dom";
import { BrowserRouter } from "react-router-dom";
import App from "./App";
import "./app.scss";
import * as React from "react";

///@ts-ignore
window.process = {
	env: {}
};

ReactDOM.render(
	<React.StrictMode>
		<BrowserRouter>
			<App />
		</BrowserRouter>
	</React.StrictMode>,
	document.getElementById("app")
);
