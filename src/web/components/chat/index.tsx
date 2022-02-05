import { Autocomplete, Grid, TextField } from "@mui/material";
import axios from "axios";
import { FC, useEffect, useRef, useState } from "react";
import Terminal from "terminal-in-react";

import useEvents from "../../../../lib/hooks/useEvents";

type MessageUser = {
	userName: string;
	userID: number;
};

type Message = {
	user?: MessageUser;
	content: string;
};

type ChatEntryProps = {
	message: Message;
};

const ChatEntry: FC<ChatEntryProps> = (props) => {
	return (
		<>
			{props.message.user && <span className="user-name">{props.message.user.userName}: </span>}
			<span className="chat-content">{props.message.content}</span>
		</>
	);
};

const Chat: FC = () => {
	const [visible, setVisible] = useState(true);
	const terminalRef = useRef<Terminal>();
	const events = useEvents();
	const [messages, setMesssages] = useState<Message[]>([
		{
			content: "hello world",
			user: {
				userID: 0,
				userName: "cyntaax"
			}
		},
		{
			content: "oh hey!",
			user: {
				userID: 1,
				userName: "other"
			}
		}
	]);

	events.addHandler("terminal:toggle", () => {
		setVisible((v) => !v);
	});

	events.addHandler<{ message: string; user: MessageUser }>("terminal:chat", (data) => {
		setMesssages([
			...messages,
			{
				content: data.message,
				user: data.user
			}
		]);
	});

	useEffect(() => {
		window.addEventListener("keydown", (e) => {
			if (e.key === "Escape") {
				console.log("closing?");
				axios.post("http://framework/terminalToggle", {}).then(() => {
					setVisible(false);
				});
			}
		});

		console.log(`ref`, terminalRef.current);
	}, []);
	return (
		<div
			style={{
				width: "500px",
				height: "200px",
				backgroundColor: "rgba(0, 0, 0, 0.6)",
				padding: "5px",
				position: "relative",
				top: "100px"
			}}
		>
			<Grid
				container
				rowSpacing={0}
				columnSpacing={0}
				alignItems="flex-end"
				alignContent="flex-end"
				style={{
					overflowY: "scroll",
					position: "relative",
					height: "100%",
					width: "100%",
					display: "flex",
					alignContent: "flex-end",
					alignItems: "flex-end"
				}}
			>
				{messages.map((v, i) => {
					return (
						<Grid item xs={12} key={i} style={{ width: "100%" }}>
							<ChatEntry message={v} />
						</Grid>
					);
				})}
			</Grid>
			<Grid container style={{ width: "500px" }}>
				<Grid item>
					<Autocomplete
						renderInput={(params) => <TextField {...params} style={{ width: "100%" }} label="Enter Text" />}
						options={[]}
					/>
				</Grid>
			</Grid>
		</div>
	);
};

export default Chat;
