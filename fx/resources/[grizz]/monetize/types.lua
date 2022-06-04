---@class PackagePurchase
PackagePurchase = {
    payment = {
        txn_id = "",
        timestamp = 0,
        date = "",
        price = 0,
        currency = "",
        gateway = "",
        status = "",
    },
    customer = {
        email = "",
        country = "",
        ign = "",
        uuid = "",
        ip = "",
        name = "",
        address = "",
    },
    coupons = {},
    gift_cards = {},
    ---@type PurchasedPackage[]
    packages = {}
}

---@class PurchasedPackage
PurchasedPackage = {
    package_id = 0,
    name = "",
    purchase_data = {
        payment = 0,
        package = 0,
        quantity = 0,
        expire = 0,
        server = "",
        price = 0,
        notified = 0,
        gift_username_id = "",
        options = {},
        commands_generated = {},
        base_price = 0,
    },
    variables = {}
}

---@class PackagePacket
PackagePacket = {
    payment = {
        txn_id = "",
        timestamp = 0,
        date = "",
        price = 0,
        currency = "",
        gateway = "",
        status = "",
    },
    customer = {
        email = "",
        country = "",
        ign = "",
        uuid = "",
        ip = "",
        name = "",
        address = "",
    },
    coupons = {},
    gift_cards = {},
    ---@type PurchasedPackage
    package = {}
}