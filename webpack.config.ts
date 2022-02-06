import * as HtmlWebpackPlugin from "html-webpack-plugin";
import * as MiniCssExtractPlugin from "mini-css-extract-plugin";
import * as os from "os";
import { TsconfigPathsPlugin } from "tsconfig-paths-webpack-plugin";
import { Configuration } from "webpack";
import * as path from "path";
import * as TerserPlugin from "terser-webpack-plugin";
import * as glob from "glob";
import * as WebpackBarPlugin from "webpackbar";
import { FxManifestPlugin } from "./lib/fx-manifest-plugin";

// import just for typings
import * as webpackDevServer from "webpack-dev-server";

const clientEntries = glob.sync("./src/modules/**/client/index.ts", {});
const serverEntries = glob.sync("./src/modules/**/server/index.ts", {});

const loaderConfig = [
	{
		loader: "thread-loader",
		options: {
			name: "citadel-pool",
			poolParallelJobs: 50,
			poolRespawn: false,
			poolTimeout: 1000,
			workerNodeArgs: ["--max-old-space-size=1024"],
			workerParallelJobs: 50,
			workers: os.cpus().length - 1
		}
	},
	{
		loader: "ts-loader",
		options: {
			happyPackMode: true,
			transpileOnly: true
		}
	}
];
const client: Configuration = {
	name: "Client",
	mode: "production",
	entry: ["./src/client/index.ts", ...clientEntries, "./src/modules/index.ts"],
	plugins: [
		///@ts-ignore
		new WebpackBarPlugin({
			name: "Client"
		}),
		new FxManifestPlugin({
			files: ["config.json", "web/*"],
			ui_page: "web/index.html",
			client_scripts: ["client.js"],
			server_scripts: ["server.js"],
			shared_scripts: [],
			fx_version: "bodacious"
		})
	],
	optimization: {
		minimizer: [
			new TerserPlugin({
				extractComments: false
			})
		]
	},
	module: {
		rules: [
			{
				test: /\.ts$/,
				use: loaderConfig,
				exclude: /node_modules/
			}
		]
	},
	resolve: {
		extensions: [".ts", ".js"],
		plugins: [new TsconfigPathsPlugin()]
	},
	output: {
		filename: "client.js",
		path: path.resolve(__dirname, "fx/resources/framework")
	},
	target: "node",
	stats: "minimal"
};

const server: Configuration = {
	name: "Server",
	mode: "production",
	entry: ["./src/server/index.ts", ...serverEntries, "./src/modules/index.ts"],
	externals: ["pg-native", "pg-hstore", "supports-color", "bufferutil", "utf-8-validate"],
	plugins: [
		///@ts-ignore
		new WebpackBarPlugin({
			name: "Server"
		})
	],
	optimization: {
		minimizer: [
			new TerserPlugin({
				extractComments: false
			})
		]
	},
	module: {
		rules: [
			{
				test: /\.ts$/,
				use: loaderConfig,
				exclude: /node_modules/
			}
		]
	},
	resolve: {
		extensions: [".ts", ".js"],
		plugins: [new TsconfigPathsPlugin()]
	},
	output: {
		filename: "server.js",
		path: path.resolve(__dirname, "fx/resources/framework")
	},
	target: "node",
	stats: "minimal"
};

const web: Configuration = {
	stats: {
		warnings: false
	},
	mode: "production",
	entry: "./src/web/main.tsx",
	output: {
		filename: "bundle.js",
		path: path.resolve(__dirname, "fx/resources/framework/web")
	},
	resolve: {
		extensions: [".ts", ".tsx", ".js"]
	},
	devServer: {
		port: 3000,
		liveReload: true,
		client: {
			overlay: { warnings: false }
		}
	},
	module: {
		rules: [
			{
				test: /\.tsx?$/,
				exclude: /node_modules/,
				loader: "ts-loader"
			},
			{
				test: /\.js$/,
				use: ["source-map-loader"],
				enforce: "pre"
			},
			{
				test: /\.(scss|css)$/,
				use: ["style-loader", "css-loader", "sass-loader"]
			},
			{ test: /\.(png|woff|woff2|eot|ttf|svg)$/, type: "asset/resource" }
		]
	},
	plugins: [
		///@ts-ignore
		new WebpackBarPlugin({
			name: "Web"
		}),
		new HtmlWebpackPlugin({
			template: "./src/web/public/index.html",
			filename: path.resolve(__dirname, "fx/resources/framework/web/index.html")
		}),
		new MiniCssExtractPlugin({
			filename: "app.css"
		})
	]
};

const loading: Configuration = {
	stats: {
		warnings: false
	},
	mode: "production",
	entry: "./src/loading_screen/main.tsx",
	output: {
		filename: "bundle.js",
		path: path.resolve(__dirname, "fx/resources/loading/web")
	},
	resolve: {
		extensions: [".ts", ".tsx", ".js"]
	},
	module: {
		rules: [
			{
				test: /\.tsx?$/,
				exclude: /node_modules/,
				loader: "ts-loader"
			},
			{
				test: /\.js$/,
				use: ["source-map-loader"],
				enforce: "pre"
			},
			{
				test: /\.css$/,
				use: ["style-loader", "css-loader"]
			},
			{ test: /\.(png|woff|woff2|eot|ttf|svg)$/, type: "asset/resource" },
			{
				test: /\.mp3$/,
				loader: "file-loader"
			}
		]
	},
	plugins: [
		///@ts-ignore
		new WebpackBarPlugin({
			name: "Loading Screen"
		}),
		new HtmlWebpackPlugin({
			template: "./src/loading_screen/public/index.html",
			filename: path.resolve(__dirname, "fx/resources/loading/web/index.html")
		}),
		new MiniCssExtractPlugin({
			filename: "app.css"
		}),
		new FxManifestPlugin({
			files: ["web/*"],
			loading_screen: "web/index.html",
			fx_version: "bodacious",
			shared_scripts: [],
			server_scripts: [],
			client_scripts: ["client.lua"],
			targetDir: "fx/resources/loading"
		})
	]
};

type WebpackExport = {
	parallelism?: number;
} & Array<Configuration>;

const output: WebpackExport = [client, server, web, loading];

export default output;
