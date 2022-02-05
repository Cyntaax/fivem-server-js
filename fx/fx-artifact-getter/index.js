import axios from 'axios';
import cheerio from "cheerio";

import fs from 'fs'

const baseURL = "https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/"

const versionGex = /(\d+)-(.*)/gm

const FiveMGetter = {
    /**
     * @type {import('cheerio').CheerioAPI}
     */
    page: null,
    async fetchPage() {
        try {
            const { data } = await axios.get(baseURL);
            const $ = cheerio.load(data);
            this.page = $;
        } catch (e) {

        }
    },
    /**
     *
     * @param {number} version
     */
    async getVersion(version) {
        return new Promise(async (resolve, reject) => {
            this.page(".panel-block").each(async (i, el) => {
                if (el.attribs.href) {
                    const href = el.attribs.href
                    const matches = href.matchAll(versionGex)
                    for (const match of matches) {
                        if (match[1]) {
                            if (match[1] === String(version)) {
                                const url = `${baseURL}${match[1]}-${match[2]}`;
                                console.log(`fetching`, url)
                                const writer = fs.createWriteStream("./fx.tar.xz")
                                const response = await axios.get(`${baseURL}${match[1]}-${match[2]}`, {
                                    responseType: "stream",
                                })

                                response.data.pipe(writer)
                                console.log(`download complete`);
                                resolve(true);
                                break
                            }
                        }
                    }
                    return false
                }
            })
        })
    }
}

const main = async () => {
    try {
        const version = process.argv.slice(2)[0]
        if(!version) {
            throw new Error("version not specified")
        }
        await FiveMGetter.fetchPage()
        const url = FiveMGetter.getVersion(Number(version));
    } catch (e) {
        console.log(e.message)
    }
}

main();
