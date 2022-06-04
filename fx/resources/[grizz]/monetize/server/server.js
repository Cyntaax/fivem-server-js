const crypto = require("crypto")

global.exports("GenerateSHA256", (data) => {
    const hash = crypto.createHash("sha256").update(data)
    return hash.digest("hex")
})