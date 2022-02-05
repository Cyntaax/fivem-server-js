import * as path from "path";
import { Compiler } from "webpack";
import * as fs from "fs";

const fxManifestTemplate = `
fx_version "{fx_version}"

games {'gta5'}

client_scripts {
	{client_scripts}
}

server_scripts {
	{server_scripts}
}

files {
	{files}
}

{ui_page}

{loadscreen}
`;

type FxManifestPluginOptions = {
	fx_version: "adamant" | "bodacious" | "cerulean";
	client_scripts: string[];
	server_scripts: string[];
	shared_scripts: string[];
	files: string[];
	ui_page?: string;
	loading_screen?: string;
	targetDir?: string;
};

const defaultOptions: FxManifestPluginOptions = {
	fx_version: "bodacious",
	server_scripts: [],
	client_scripts: [],
	shared_scripts: [],
	ui_page: undefined,
	loading_screen: undefined,
	files: []
};

export class FxManifestPlugin {
	public options: FxManifestPluginOptions = defaultOptions;
	constructor(options?: FxManifestPluginOptions) {
		this.options = { ...defaultOptions, ...options };
	}
	apply(compiler: Compiler) {
		compiler.hooks.afterDone.tap("FxManifestPlugin", (data) => {
			let myTemplate = fxManifestTemplate.replace("{fx_version}", this.options.fx_version);
			myTemplate = myTemplate.replace(
				"{client_scripts}",
				this.options.client_scripts.map((v) => `"${v}"`).join(",\n")
			);
			myTemplate = myTemplate.replace(
				"{server_scripts}",
				this.options.server_scripts.map((v) => `"${v}"`).join(",\n")
			);
			myTemplate = myTemplate.replace("{files}", this.options.files.map((v) => `"${v}"`).join(",\n"));
			if (this.options.ui_page) {
				myTemplate = myTemplate.replace("{ui_page}", `ui_page "${this.options.ui_page}"`);
			} else {
				myTemplate = myTemplate.replace("{ui_page}", "");
			}

			if (this.options.loading_screen) {
				myTemplate = myTemplate.replace("{loadscreen}", `loadscreen "${this.options.loading_screen}"`);
			} else {
				myTemplate = myTemplate.replace("{loadscreen}", "");
			}

			const targetDir = this.options.targetDir || data.compilation.options.output.path;
			fs.writeFile(path.resolve(targetDir, "fxmanifest.lua"), myTemplate, () => {
				console.log(`Created fxmanifest.lua`);
			});
		});
	}
}
