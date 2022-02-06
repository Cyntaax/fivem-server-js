import { FC } from "react";
import useEvents from "../../lib/hooks/useEvents";
import Chat from "./components/chat";
import { Routes, Route, useNavigate } from "react-router-dom";
import { Home } from "./views/Home";
import { Login } from "./views/Login";

const App: FC = () => {
	const events = useEvents();
	const navigate = useNavigate();

	events.addHandler<{ page: string }>("web:navigate", (data) => {
		navigate(data.page);
	});
	return (
		<Routes>
			<Route index element={<Home />} />
			<Route path="/login" element={<Login />} />
		</Routes>
	);
};

export default App;
