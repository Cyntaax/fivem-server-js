import { FC } from "react";
import useEvents from "../../lib/hooks/useEvents";
import { Routes, Route, useNavigate } from "react-router-dom";
import { AppearanceView } from "./views/Appearance";
import { Home } from "./views/Home";
import { Login } from "./views/Login";

const App: FC = () => {
	const events = useEvents();
	const navigate = useNavigate();

	events.addHandler<{ page: string }>("web:navigate", (data) => {
		console.log(`navigate request`, data.page);
		navigate(data.page, { replace: true });
	});
	return (
		<Routes location="">
			<Route path="" element={<Home />} />
			<Route path="/login" element={<Login />} />
			<Route path="/appearance" element={<AppearanceView />} />
		</Routes>
	);
};

export default App;
