function ToJSON(object)
    local tmp = {}

    local mt = getmetatable(object)
    for k,v in pairs(mt) do
        if k ~= "__call" and k ~= "__index" and k ~= "new" then
            tmp[k] = v(object)
        end
    end

    for k,v in pairs(object) do
        if type(v) == "function" then
            tmp[k] = v()
        elseif type(v) == "table" then
            local tmp2 = {}
            local mt2 = getmetatable(v)
            if mt2 ~= nil then
                for b,z in pairs(mt2) do
                    if b ~= "_call" and b ~= "__index" and b~= "new" then
                        tmp2[b] = z(v)
                    end
                end
                tmp[k] = tmp2
            else
                tmp[k] = v
            end
        else
            tmp[k] = v
        end
    end

    return tmp
end

API = {}

function API:Emit(event, ...)
    local np = NetPlayer.new(GetPlayerServerId(PlayerId()))
    local no = ToJSON(np)

    TriggerServerEvent("fivem-lua:api:on", event, no, ...)
end

function API:Receive(target, func, ...)
    if type(_G[target]) == nil then
        Error.new("Invalid target " .. target):Print()
        return
    end

    if target == "Player" then
        _G[target][func](Player, ...)
    end
end

RegisterNetEvent("fivem-lua:api:dispatch")
AddEventHandler("fivem-lua:api:dispatch", function(target, func, ...)
    API:Receive(target, func, ...)
end)


---@class Camera
Camera = setmetatable({}, Camera)

Camera.__index = Camera

Camera.__call = function()
    return "Camera"
end

function Camera.new(handle)
    local _Camera = {
        Handle = handle
    }

    return setmetatable(_Camera, Camera)
end

---@param position Vector3
---@return Vector3
function Camera:Position(position)
    if position == nil then
        local pos = GetCamCoord(self.Handle)
        return Vector3.new(pos.x, pos.y, pos.z)
    end

    SetCamCoord(self.Handle,position.X, position.Y, position.Z)
    return self:Position()
end

---@param rotation Vector3
---@return Vector3
function Camera:Rotation(rotation)
    if rotation == nil then
        local rot = GetCamRot(self.Handle, 2)
        return Vector3.new(rot.x, rot.y, rot.z)
    end

    SetCamRot(self.Handle, rotation.X, rotation.Y, rotation.Z)
    return self:Rotation()
end

---@return Vector3
function Camera:ForwardVector()
    local rotation = self:Rotation():Multiply(math.pi / 180)
    local normalized = Vector3.new(
            -math.sin(rotation.X) * math.abs(math.cos(rotation.X)),
    math.cos(rotation.Z * math.abs(math.cos(rotation.X))),
    math.sin(rotation.X))

    return Vector3.new(normalized.X, normalized.Y, normalized.Z)
end

function Camera:FieldOfView(fov)
    if fov == nil then
        return GetCamFov(self.Handle)
    end

    SetCamFov(self.Handle, fov)
    return self:FieldOfView()
end

---@param target Ped|Vehicle|Vector3
function Camera:PointAt(target, offset)
    if type(target) == "table" then
        if not target.__call then
            print("Error")
            return
        end
        if target.__call() == "Ped" or target.__call() == "Vehicle" then
            PointCamAtEntity(self.Handle, target.Handle, offset.X, offset.y, offset.Z, true)
        elseif target.__call() == "Vector3" then
            PointCamAtCoord(self.Handle, target.X, target.Y, target.Z)
        end
    end
end

function Camera:StopPointing()
    StopCamPointing(self.Handle)
end

function Camera:InterpTo(to, duration, easePosition, easeRotation)
    SetCamActiveWithInterp(to.Handle, self.Handle, duration, tonumber(easePosition) or 0, tonumber(easeRotation) or 0)
end

function Camera:Active(val)
    if type(val) == "boolean" then
        SetCamActive(self.Handle, val)
        return self:Active()
    end

    return IsCamActive(self.Handle)
end

function Camera:IsInterpolating()
    return IsCamInterpolating(self.Handle)
end


Events = {}

--- Creates a non-networked event
--- @param eventName string Th name of the event
--- @param eventHandler fun(...):nil The handler for this event
function Events:On(eventName, eventHandler)
    AddEventHandler(eventName, eventHandler)
end

--- Creates a networked event
--- @param eventName string The name of the event
--- @param eventHandler fun(...):nil The handler for this event
function Events:OnNet(eventName, eventHandler)
    RegisterNetEvent(eventName)
    AddEventHandler(eventName, eventHandler)
end

--- Triggers a non-networked event
--- @param eventName string The event to trigger
function Events:Emit(eventName, ...)
    TriggerEvent(eventName, ...)
end

--- Triggers a networked event
--- @param eventName string The event to trigger
function Events:EmitNet(eventName, ...)
    TriggerServerEvent(eventName, ...)
end





HUD = {}

--- Sets blurriness or something `Citizen.InvokeNative(0xBA3D65906822BED5, 1, 1, 0.0, 0.0, 0.0, 100.0)`
function HUD:Fov(p1, p2, nearPlaneOut, nearPlaneIn, farPlaneOut, farPlaneIn)
    Citizen.InvokeNative(0xBA3D65906822BED5, p1, p2, nearPlaneOut + 0.0, nearPlaneIn + 0.0, farPlaneOut + 0.0, farPlaneIn + 0.0)
end


Control = {
    ESC = 322,
    F1 = 288,
    F2 = 289,
    F3 = 170,
    F5 = 166,
    F6 = 167,
    F7 = 168,
    F8 = 169,
    F9 = 56,
    F10 = 57,
    TILDE = 243,
    NUM1 = 157,
    NUM2 = 158,
    NUM3 = 160,
    NUM4 = 164,
    NUM5 = 165,
    NUM6 = 159,
    NUM7 = 161,
    NUM8 = 162,
    NUM9 = 163,
    MINUS = 84,
    EQUALS = 83,
    BACKSPACE = 177,
    TAB = 37,
    Q = 44,
    W = 32,
    E = 38,
    R = 45,
    T = 245,
    Y = 246,
    U = 303,
    P = 199,
    LEFTBRACKET = 39,
    RIGHTBRACKET = 40,
    ENTER = 18,
    CAPS = 137,
    A = 34,
    S = 8,
    D = 9,
    F = 23,
    G = 47,
    H = 74,
    K = 311,
    L = 182,
    LEFTSHIFT = 21,
    Z = 20,
    X = 73,
    C = 26,
    V = 0,
    B = 29,
    N = 249,
    M = 244,
    COMMA = 82,
    PERIOD = 81,
    LEFTCTRL = 36,
    LEFTALT = 19,
    SPACE = 22,
    RIGHTCTRL = 70,
    HOME = 213,
    PAGEUP = 10,
    PAGEDOWN = 11,
    DELETE = 178,
    LEFT = 174,
    RIGHT = 175,
    TOP = 27,
    DOWN = 173,
}


Marker = setmetatable({}, Marker)

Marker.__index = Marker

Marker.__call = function()
    return "Marker"
end

--- @param markerType MarkerType
--- @param color table e.g. { 255, 255, 255, 255 }
--- @param position table
--- @param direction table
--- @param rotation table
--- @param scale table
--- @param bobble boolean
--- @param faceCamera boolean
--- @param param19 boolean
--- @param rotate boolean
--- @param textureDict string
--- @param textureName string
--- @param drawOnEntity boolean
function Marker.new(
        markerType,
        color,
        position,
        direction,
        scale,
        rotation,
        bobble,
        faceCamera,
        param19,
        rotate,
        textureDict,
        textureName,
        drawOnEntity
)
    _Marker = {
        _Color = color or { 255, 255, 255, 255 },
        _MarkerType = markerType or MarkerType.CircleSkinny,
        _Position = position or {0,0,0},
        _Direction = direction or {0,0,0},
        _Rotation = rotation or 0,
        _Bobble = bobble or false,
        _FaceCamera = faceCamera or false,
        _Param19 = param19 or 0,
        _Rotate = rotate or false,
        _TextureDict = textureDict or 0,
        _TextureName = textureName or 0,
        _DrawOnEntity = drawOnEntity or false,
        _Scale = scale or { 1.0, 1.0, 1.0 },
        _Drawing = false
    }

    return setmetatable(_Marker, Marker)
end

function table.valsToFloat(input)
    for i = 1, #input, 1 do
        if type(input[i]) == "number" then
            input[i] = input[i] + 0.0
        end
    end

    return input
end

--- Draws the marker. Creates its own thread, only needs run once.
function Marker:Draw()
    if self._Drawing == true then
        return
    end

    print(self._MarkerType,
            self._Position.X,
            self._Position.Y,
            self._Position.Z,
            self._Direction[1],
            self._Direction[2],
            self._Direction[3],
            self._Rotation[1],
            self._Rotation[2],
            self._Rotation[3],
            self._Scale[1],
            self._Scale[2],
            self._Scale[3],
            self._Color[1],
            self._Color[2],
            self._Color[3],
            self._Color[4],
            self._Bobble,
            self._FaceCamera,
            self._Param19,
            self._Rotate,
            self._TextureDict,
            self._TextureName,
            self._DrawOnEntity)
    --                                         (----- dir ---)|(    rotation )|
-- DrawMarker(2, loc["x"], loc["y"], loc["z"], 0.0, 0.0, 0.0, ( 0.0, 0.0, 0.0, ) (0.25, 0.2, 0.1,) (255, 255, 255, 155), 0, 0, 0, 1, 0, 0, 0)
    self._Drawing = true
    Citizen.CreateThread(function()
        while self._Drawing == true do
            Citizen.Wait(0)
            DrawMarker(
                    self._MarkerType,
                    self._Position.X,
                    self._Position.Y,
                    self._Position.Z,
                    self._Direction[1],
                    self._Direction[2],
                    self._Direction[3],
                    self._Rotation[1],
                    self._Rotation[2],
                    self._Rotation[3],
                    self._Scale[1],
                    self._Scale[2],
                    self._Scale[3],
                    self._Color[1],
                    self._Color[2],
                    self._Color[3],
                    self._Color[4],
                    self._Bobble,
                    self._FaceCamera,
                    self._Param19,
                    self._TextureDict,
                    self._TextureName,
                    self._DrawOnEntity
            )
        end
    end)
end

--- Stops the marker from being drawn
function Marker:Destroy()
    self._Drawing = false
end

--- Gets or sets the color of the marker
--- @param color table | nil the current color value. If `nil`, returns the current color value
function Marker:Color(color)
    if color == nil then
        return self._Color
    end

    if type(color) == "table" then
        if #color ~= 4 then
            print("^1Error setting color:^0 Requires 4 fields, but got " .. #color)
            return
        end

        color = table.valsToFloat(color)

        self._Color = color

        return self._Color
    else
        print("^1Error: Invalid type.^0 Expected (table) got (" .. type(color) .. ")")
    end
end

function Marker:Position(position)
    if position == nil then
        return self._Position
    end

    if type(position) == "table" then
        if #position ~= 3 then
            print("^1Error setting color:^0 Requires 3 fields, but got " .. #position)
            return
        end

        position = table.valsToFloat(position)

        self._Position = position

        return self._Position
    else
        print("^1Error: Invalid type.^0 Expected (table) got (" .. type(position) .. ")")
    end
end

function Marker:Direction(direction)
    if direction == nil then
        return self._Direction
    end

    if type(direction) == "table" then
        if #direction ~= 3 then
            print("^1Error setting color:^0 Requires 3 fields, but got " .. #direction)
            return
        end

        direction = table.valsToFloat(direction)

        self._Direction = direction

        return self._Direction
    else
        print("^1Error: Invalid type.^0 Expected (table) got (" .. type(direction) .. ")")
    end
end

function Marker:Scale(scale)
    if scale == nil then
        return self._Scale
    end

    if type(scale) == "table" then
        if #scale ~= 3 then
            print("^1Error setting color:^0 Requires 3 fields, but got " .. #scale)
            return
        end

        scale = table.valsToFloat(scale)

        self._Scale = scale

        return self._Scale
    else
        print("^1Error: Invalid type.^0 Expected (table) got (" .. type(scale) .. ")")
    end
end

function Marker:Rotation(rotation)
    if rotation == nil then
        return self._Rotation
    end

    if type(rotation) == "table" then
        if #rotation ~= 3 then
            print("^1Error setting color:^0 Requires 3 fields, but got " .. #rotation)
            return
        end

        rotation = table.valsToFloat(rotation)

        self._Rotation = rotation

        return self._Rotation
    else
        print("^1Error: Invalid type.^0 Expected (table) got (" .. type(rotation) .. ")")
    end
end

function Marker:Bobble(bobble)
    if bobble == nil then
        return self._Bobble
    end

    if type(bobble) == "boolean" then
        self._Bobble = bobble
        return self._Bobble
    else
        print("^Error: Invalid type.^0 Expected (boolean) got (" .. type(bobble) .. ")")
    end
end

function Marker:FaceCamera(faceCamera)
    if faceCamera == nil then
        return self._FaceCamera
    end

    if type(faceCamera) == "boolean" then
        self._FaceCamera = faceCamera
        return self._FaceCamera
    else
        print("^Error: Invalid type.^0 Expected (boolean) got (" .. type(faceCamera) .. ")")
    end
end

function Marker:Rotate(rotate)
    if rotate == nil then
        return self._Rotate
    end

    if type(rotate) == "boolean" then
        self._Rotate = rotate
        return self._Rotate
    else
        print("^Error: Invalid type.^0 Expected (boolean) got (" .. type(rotate) .. ")")
    end
end

function Marker:MarkerType(markerType)
    if markerType == nil then
        return self._MarkerType
    end

    if type(markerType) == "number" then
        local valid = false
        for k,v in pairs(MarkerType) do
            if v == markerType then
                valid = true
                break
            end
        end

        if valid == false then
            print("^1Error: Marker type not found")
            return
        end

        self._MarkerType = markerType
    end
end

--- @class MarkerType
MarkerType = {
    --- [Image Reference](https://docs.fivem.net/markers/0.png)
    UpsideDownCone = 0,
    --- [Image Reference](https://docs.fivem.net/markers/1.png)
    VerticalCylinder = 1,
    --- [Image Reference](https://docs.fivem.net/markers/2.png)
    ThickChevronUp = 2,
    --- [Image Reference](https://docs.fivem.net/markers/3.png)
    ThinChevronUp = 3,
    --- [Image Reference](https://docs.fivem.net/markers/4.png)
    CheckeredFlagRect = 4,
    --- [Image Reference](https://docs.fivem.net/markers/5.png)
    CheckeredFlagCircle = 5,
    --- [Image Reference](https://docs.fivem.net/markers/6.png)
    VerticleCircle = 6,
    --- [Image Reference](https://docs.fivem.net/markers/7.png)
    PLaneModel = 7,
    --- [Image Reference](https://docs.fivem.net/markers/8.png)
    LostMCTransparent = 8,
    --- [Image Reference](https://docs.fivem.net/markers/9.png)
    LostMC = 9,
    --- [Image Reference](https://docs.fivem.net/markers/10.png)
    Number0 = 10,
    --- [Image Reference](https://docs.fivem.net/markers/11.png)
    Number1 = 11,
    --- [Image Reference](https://docs.fivem.net/markers/12.png)
    Number2 = 12,
    --- [Image Reference](https://docs.fivem.net/markers/13.png)
    Number3 = 13,
    --- [Image Reference](https://docs.fivem.net/markers/14.png)
    Number4 = 14,
    --- [Image Reference](https://docs.fivem.net/markers/15.png)
    Number5 = 15,
    --- [Image Reference](https://docs.fivem.net/markers/16.png)
    Number6 = 16,
    --- [Image Reference](https://docs.fivem.net/markers/17.png)
    Number7 = 17,
    --- [Image Reference](https://docs.fivem.net/markers/18.png)
    Number8 = 18,
    --- [Image Reference](https://docs.fivem.net/markers/19.png)
    Number9 = 19,
    --- [Image Reference](https://docs.fivem.net/markers/20.png)
    ChevronUpx1 = 20,
    --- [Image Reference](https://docs.fivem.net/markers/21.png)
    ChevronUpx2 = 21,
    --- [Image Reference](https://docs.fivem.net/markers/22.png)
    ChevronUpx3 = 22,
    --- [Image Reference](https://docs.fivem.net/markers/23.png)
    HorizontalCircleFat = 23,
    --- [Image Reference](https://docs.fivem.net/markers/24.png)
    ReplayIcon = 24,
    --- [Image Reference](https://docs.fivem.net/markers/25.png)
    CircleSkinny = 25,
    --- [Image Reference](https://docs.fivem.net/markers/26.png)
    CircleSkinny_Arrow = 26,
    --- [Image Reference](https://docs.fivem.net/markers/27.png)
    HorizontalSplitArrowCircle = 27,
    --- [Image Reference](https://docs.fivem.net/markers/28.png)
    DebugSphere = 28,
    --- [Image Reference](https://docs.fivem.net/markers/29.png)
    DollarSign = 29,
    --- [Image Reference](https://docs.fivem.net/markers/30.png)
    HorizontalBars = 30,
    --- [Image Reference](https://docs.fivem.net/markers/31.png)
    WolfHead = 31,
    --- [Image Reference](https://docs.fivem.net/markers/32.png)
    QuestionMark = 32,
    --- [Image Reference](https://docs.fivem.net/markers/33.png)
    PlaneSymbol = 33,
    --- [Image Reference](https://docs.fivem.net/markers/34.png)
    HelicopterSymbol = 34,
    --- [Image Reference](https://docs.fivem.net/markers/35.png)
    BoatSymbol = 35,
    --- [Image Reference](https://docs.fivem.net/markers/36.png)
    CarSymbol = 36,
    --- [Image Reference](https://docs.fivem.net/markers/37.png)
    MotorcycleSymbol = 37,
    --- [Image Reference](https://docs.fivem.net/markers/38.png)
    BikeSymbol = 38,
    --- [Image Reference](https://docs.fivem.net/markers/39.png)
    TruckSymbol = 39,
    --- [Image Reference](https://docs.fivem.net/markers/40.png)
    ParachuteSymbol = 40,
    --- [Image Reference](https://docs.fivem.net/markers/41.png)
    JetPack = 41,
    --- [Image Reference](https://docs.fivem.net/markers/42.png)
    SawbladeSymbol = 42,
    --- [Image Reference](https://docs.fivem.net/markers/43.png)
    Unknown = 43
}


--- @class Model
Model = setmetatable({}, Model)

Model.__index = Model

Model.__call = function()
    return "Model"
end

--- @param model number | string the model hash or name
function Model.new(model)
    if type(model) == "string" then
        if tonumber(model) ~= nil then
            model = GetHashKey(model)
        end
    end
    local _Model = {
        Raw = model,
        Hash = model
    }

    return setmetatable(_Model, Model)
end

function Model:Load()
    if not IsModelValid(self.Hash) then
        print("^1Error: Invalid model " .. self.Hash)
    end

    RequestModel(self.Hash)
    local time = GetGameTimer()
    while not HasModelLoaded(self.Hash) do
        if GetGameTimer() - time > 5000 then
            print("^1Error: Failed to load model " .. self.Hash)
            return false
        end
        Wait(100)
    end

    return true
end

function Model:Unload()
    SetModelAsNoLongerNeeded(self.Hash)
end


--- @class NetPlayer
NetPlayer = setmetatable({}, NetPlayer)

NetPlayer.__index = NetPlayer

NetPlayer.__call = function()
    return "NetPlayer"
end

function NetPlayer.new(serverId)
    local _NetPlayer = {
        ServerID = serverId,
        LocalID = GetPlayerFromServerId(serverId),
        Ped = Ped.new(GetPlayerPed(GetPlayerFromServerId(serverId)))
    }

    _NetPlayer._Name = GetPlayerName(_NetPlayer.LocalID)

    return setmetatable(_NetPlayer, NetPlayer)
end

---@return Ped
function NetPlayer:GetPed()
    return self.Ped
end

---@return string
function NetPlayer:Name()
    return self._Name
end

---@param entity table|number
---@return boolean
function NetPlayer:OwnsEntity(entity)
    if entity == nil then return end
    local checker
    if type(entity) == "table" then
        if type(entity.Handle) == "number" then
            checker = entity
        end
    elseif type(tonumber(entity)) == "number" then
        checker = tonumber(entity)
    else
        Error.new("Invalid entity. Please pass an instance of an entity or a handle"):Print()
        return false
    end

    return self:GetPed().Handle == NetworkGetEntityOwner(checker)
end


--- @class Ped
Ped = setmetatable({}, Ped)

Ped.__index = Ped

Ped.__call = function()
    return "Ped"
end

--- Creates a new instance of the `Ped` class.
function Ped.new(handle)
    local _Ped = {
        Handle = handle,
        Appearance = {
        }
    }
    return setmetatable(_Ped, Ped)
end

--- Gets or sets the ped's current health
--- @param health number | nil value to set current health to.
--- If `nil`, returns the peds health
--- @return number the ped's current health
function Ped:Health(health)
    if type(health) ~= "number" then
        print("self is", self)
        return GetEntityHealth(self.Handle)
    end
    print(self)
    SetEntityHealth(self.Handle, health + 0.0)
    return self:Health()
end

---@param distance number
---@return Vector3
function Ped:ForwardVector(distance)
    distance = tonumber(distance) or 1
    local forward = GetEntityForwardVector(self.Handle)
    local x, y, z = table.unpack(self:Position():Native() + forward * distance)
    return Vector3.new(x,y,z)
end

--- Gets or sets the ped's current position
--- @param position Vector3 | nil the position to set. If `nil`, returns the current position
--- @return Vector3
function Ped:Position(position)
    if type(position) ~= "table" then
        local rawpos = GetEntityCoords(self.Handle)
        local posVec = Vector3.new(rawpos.x, rawpos.y, rawpos.z)
        return posVec
    end

    SetEntityCoords(self.Handle, position.x, position.y, position.z)
end

--- Gets or sets the ped's current armor
--- @param armor number | nil the value to set current armor to. If `nil`, returns the current armor
function Ped:Armor(armor)
    if type(armor) ~= "number" then
        return GetPedArmour(self.Handle)
    end

    SetPedArmour(self.Handle, armor)
end

PedComponent = {
    Face = 0,
    Mask = 1,
    Hair = 2,
    Torso = 3,
    Leg = 4,
    Bag = 5,
    Shoes = 6,
    Accessory = 7,
    Undershirt = 8,
    Kevlar = 9,
    Badge = 10,
    Torso2 = 11
}


--- @class Player
Player = setmetatable({}, nil)

Player.__index = Player

Player.__call = function()
    return "Player"
end

function Player.new()
    local _Player = {

    }

    local ped = Ped.new(PlayerPedId())

    for k,v in pairs(ped) do
        print("assigning", k, v)
        _Player[k] = v
    end

    local mt = getmetatable(ped)

    for k,v in pairs(mt) do
        if k ~= "__call" and k ~= "__index" and k ~= "new" then
            print("assigning", k)
            _Player[k] = v
        end
    end

    return setmetatable(_Player, Player)
end

Player = Player.new()


--- @class HelpPrompt
HelpPrompt = setmetatable({}, HelpPrompt)

HelpPrompt.__index = HelpPrompt

HelpPrompt.__call = function()
    return "HelpPrompt"
end

function HelpPrompt.new(text)
    local _HelpPrompt = {
        _Text = text,
        EachFrame = eachFrame or false,
        _Drawing = false,
        _Actions = {},
        _WaitingForAction = false
    }

    return setmetatable(_HelpPrompt, HelpPrompt)
end

function HelpPrompt:Draw(duration)
    if self._Drawing == true then return end
    self._Drawing = true
    if type(duration) == "number" then
        if duration > 0 then
            self:WaitForAction()
            Citizen.CreateThread(function()
                SetTimeout(duration * 1000, function()
                    self:Destroy()
                end)
                while self._Drawing == true do
                    Citizen.Wait(0)
                    SetTextComponentFormat("STRING")
                    AddTextComponentString(self._Text)
                    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
                end
            end)
        elseif duration == -1 then
            self:WaitForAction()
            Citizen.CreateThread(function()
                while self._Drawing == true do
                    Citizen.Wait(0)
                    SetTextComponentFormat("STRING")
                    AddTextComponentString(self._Text)
                    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
                end
            end)
        end
    elseif duration == nil then
        SetTextComponentFormat("STRING")
        AddTextComponentString(self._Text)
        DisplayHelpTextFromStringLabel(0, 0, 1, -1)
    end
end

--- Sets an action for the prompt
--- @param key number The key to trigger the action
--- @param handler fun(prompt: HelpPrompt): void The handler function
function HelpPrompt:Action(key, handler)
    for k,v in pairs(self._Actions) do
        if v.key == key then
            Self._Actions.handler = handler
            return
        end
    end

    table.insert(self._Actions, {
        key = key,
        handler = handler
    })
end

function HelpPrompt:WaitForAction()
    if self._WaitingForAction == true then return end
    self._WaitingForAction = true
    Citizen.CreateThread(function()
        while self._WaitingForAction == true do
            Citizen.Wait(0)
            for k,v in pairs(self._Actions) do
                if IsControlJustReleased(0, v.key) then
                    v.handler(self)
                end
            end
        end
    end)
end

function HelpPrompt:Text(text)
    if type(text) == "string" then
        self._Text = text
        return self._Text
    end

    return self._Text
end

function HelpPrompt:Destroy()
    if self._Drawing == true then
        self._Drawing = false
    end

    if self._WaitingForAction == true then
        self._WaitingForAction = false
    end
end


Tests = {}
Lester = {}

if not GetGameTimer then
    GetGameTimer = function()
        return os.time()
    end
end

--- @class Context
Context = setmetatable({}, Context)

Context.__index = Context

Context.__call = function()
    return "Context"
end

function Context.new(parent)
    local _Context = {
        _Parent = parent,
        Tests ={},
        Cleaner = function()

        end
    }
    return setmetatable(_Context, Context)
end

---@param description string
---@param handler fun(context: Context): void
---@return Context
function Context:Should(description, handler)
    table.insert(self.Tests, {
        description = description,
        handler = handler
    })
    return self
end

function Context:Clean(handler)
    self.Cleaner = handler
end

function Context:Assert(val1, val2)
    return val1 == val2
end

---@param description string
---@param handler fun(context: Context): void
---@return Context
function Lester.Describe(description, handler)
    table.insert(Tests, {
        description = description,
        handler = handler
    })
end

function Lester.Assert(val, check)
    return val == check
end

function Lester.Run()
    for k,v in pairs(Tests) do
        local context = v.handler(Context.new())
        local testStr = ColorString.new():LightGreen("Testing: "):LightBlue(v.description):End()
        print(testStr)
        local passed = 0
        local failed = 0
        if type(context) == "table" then
            if context.__call() == "Context" then
                for b,z in pairs(context.Tests) do
                    local startTime = GetGameTimer()
                    local res = z.handler()
                    local endTime = GetGameTimer()
                    local diff = endTime - startTime
                    local seconds = math.floor(diff / 1000)
                    local rawRemainder = diff % 1000
                    local remainder
                    if rawRemainder < 10 then
                        remainder = "00" .. rawRemainder
                    elseif rawRemainder < 100 then
                        remainder = "0" .. rawRemainder
                    end
                    if res == true then
                        if not ColorString then
                            print("    ✅ should " .. z.description .. " ⏱️: " .. diff)
                        else
                            local output = ColorString.new():LightGreen("+ " .. z.description):LightBlue(" => " .. seconds .. "." .. remainder .. "s"):End()
                            print(output)
                        end
                        passed = passed + 1
                    else
                        if not ColorString then
                            print("    ❌ should " .. z.description .. " ⏱️: " .. diff)
                        else
                            local output = ColorString.new():RedOrange("!"  .. z.description):LightBlue(" => " .. seconds .. "." .. remainder .. "s"):End()
                            print(output)
                        end
                        failed = failed + 1
                    end
                end
                context.Cleaner()
            else
                print(ColorString.new():LightYellow("Skipping because of invalid config"))
            end
        else
            print(ColorString.new():LightYellow("Skipping because of invalid config"))
        end

        print("Passed: " .. passed .. " - Failed: " .. failed .. " - " .. (passed / (passed + failed) * 100) .. " % of tests passed")
    end
end

if not Vehicle then
    --- @class Vehicle
    Vehicle = setmetatable({}, Vehicle)

    Vehicle.__index = Vehicle

    Vehicle.__call = function()
        return "Vehicle"
    end

    function Vehicle.new()
        local _Vehicle = {}
        return setmetatable(_Vehicle, Vehicle)
    end
end

function CreateTruck()
    local veh = World:CreateVehicle("panto", Player:ForwardVector(3), 0, true)
    print("Created vehicle", veh)
    Citizen.Wait(2000)
    return veh
end

Lester.Describe("CreateTruck()", function(context)
    local val = CreateTruck()
    context:Should("return an instance of the Vehicle class", function()
        local response = context:Assert(val.__call(), "Vehicle")
        Citizen.Wait(2000)
        return response
    end)

    val:Model("sultan")


    context:Should("have a model equal to 'sultan'", function()
        local response = context:Assert(val:Model(), GetHashKey("sultan"))
        return response
    end)

    context:Clean(function()
        val:Delete()
    end)

    print("Returning ", context)

    return context
end)

Lester.Describe("Getting net player name", function(context)
    local testVehicle = World:CreateVehicle("zentorno",Player:ForwardVector(5), 0, true)
    local owner = testVehicle:GetNetworkOwner():Name()
    print("Owner is", owner)
    context:Should("be owned by Cyntaax", function()
        return context:Assert(owner, "Cyntaax")
    end)

    context:Clean(function()
        testVehicle:Delete()
    end)

    return context
end)

RegisterCommand("test", function()
    Lester.Run()
end)

-- RegisterCommand('cammit', function()


    -- local coords = GetGameplayCamCoord()

    -- local vcoords = Vector3.new(coords.x, coords.y, coords.z)

    -- local rot = GetGameplayCamRot()

    -- local rcoords = Vector3.new(rot.x, rot.y, rot.z)

    -- local tcam = World:CreateCamera(vcoords, rcoords, 120)
    -- local newpos = tcam:ForwardVector():Multiply(3)
    -- tcam:Position(newpos)
    -- tcam:Active(true)
    -- World:RenderScriptCams(true, true, 300)
-- end)

Command.new("json"):SetHandler(function()
    local p = NetPlayer.new(GetPlayerServerId(PlayerId()))
    print(json.encode(ToJSON(p)))
end):Register()


--- @class Vehicle
Vehicle = setmetatable({}, Vehicle)

Vehicle.__index = Vehicle

Vehicle.__call = function()
    return "Vehicle"
end

function Vehicle.new(handle)
    local _Vehicle = {
        Handle = handle,
        PassengerCapacity = GetVehicleMaxNumberOfPassengers(handle),
    }

    return setmetatable(_Vehicle, Vehicle)
end

function Vehicle:Model(model)
    if model == nil then
        return GetEntityModel(self.Handle)
    end
    local pos = self:Position()
    local heading = self:Heading()
    self:Delete(true)
    local newveh = World:CreateVehicle(model,pos, heading,true)

    self.Handle = newveh.Handle
end

---@param wait boolean Whether to actually wait for the vehicle to delete
function Vehicle:Delete(wait)
    SetEntityAsMissionEntity(self.Handle)
    if wait == true then
        DeleteVehicle(self.Handle)
        while DoesEntityExist(self.Handle) do
            Citizen.Wait(5)
        end
        return
    end

    DeleteVehicle(self.Handle)
end


--- @return Vector3
function Vehicle:Position(pos)
    if type(pos) == "table" then
        if pos.X and pos.Y and pos.Z then
            SetEntityCoords(self.Handle, pos.X, pos.Y, pos.Z)
            return
        end
        Error.new("Invalid position"):Print()
    end

    local _pos = GetEntityCoords(self.Handle)
    return Vector3.new(_pos.x, _pos.y, _pos.z)
end

function Vehicle:Heading(heading)
    if type(heading) == "number" then
        SetEntityHeading(self.Handle, heading + 0.0)
        return self:Heading()
    end

    return GetEntityHeading(self.Handle)
end

function Vehicle:GetNetworkOwner()
    return NetPlayer.new(GetPlayerServerId(NetworkGetEntityOwner(self.Handle)))
end

--- opens a vehicle door
--- @param door VehicleDoor the door to open
--- @param loosely boolean to open the door loosely (Optional. Default: false)
--- @param instantly boolean to open the door instantly (Optional. Default true)
function Vehicle:OpenDoor(door, loosely, instantly)
    SetVehicleDoorOpen(self.Handle, door, loosely or false, instantly or false)
end

--- gets the first free seat of the vehicle
--- @return number the the index of the free seat
function Vehicle:GetFreeSeat()
    local maxSeats, freeSeat = self.PassengerCapacity

    for i=maxSeats - 1, 0, -1 do
        if IsVehicleSeatFree(self.Handle, i) then
            freeSeat = i
            break
        end
    end
end

function Vehicle:Plate(plate)
    if type(plate) == "string" then
        SetVehicleNumberPlateText(self.Handle, plate)
        return self:Plate()
    end

    return GetVehicleNumberPlateText(self.Handle)
end

function Vehicle:EngineHealth(health)
    if type(health) == "number" then
        SetVehicleEngineHealth(self.Handle, health + 0.0)
        return self:EngineHealth()
    end

    return GetVehicleEngineHealth(self.Handle)
end

function Vehicle:BodyHealth(health)
    if type(health) == "number" then
        SetVehicleBodyHealth(self.Handle, health + 0.0)
        return self:BodyHealth()
    end
    return GetVehicleBodyHealth(self.Handle)
end

function Vehicle:TankHealth(health)
    if type(health) == "number" then
        SetVehiclePetrolTankHealth(self.Handle, health + 0.0)
        return self:TankHealth()
    end
    return GetVehiclePetrolTankHealth(self.Handle)
end

function Vehicle:FuelLevel(fuel)
    if type(fuel) == "number" then
        SetVehicleFuelLevel(self.Handle, fuel + 0.0)
        return self:FuelLevel()
    end

    return GetVehicleFuelLevel(self.Handle)
end

function Vehicle:DirtLevel(dirt)
    if type(dirt) == "number" then
        SetVehicleDirtLevel(self.Handle, dirt)
        return self:DirtLevel()
    end

    return GetVehicleDirtLevel(self.Handle)
end

function Vehicle:GetProperties()
    local _data = {}

    _data.StandardMods = {}

    for k,v in pairs(VehicleMod) do
        if not table.contains(ToggleMods, k) then
            _data.StandardMods[k] = GeVehicleMod(self.Handle, v)
        else
            _data.StandardMods[k] = IsToggleModOn(self.Handle, v)
        end
    end

    _data.Levels = {
        fuel = self:FuelLevel(),
        dirt = self:DirtLevel()
    }

    _data.Health = {
        body = self:BodyHealth(),
        engine = self:EngineHealth(),
        tank = self:TankHealth()
    }
    local c1, c2 = GetVehicleColours(self.Handle)
    local pearlColor, wheelColor = GetVehicleExtraColours(self.Handle)
    _data.Colors = {
        primary = c1,
        secondary = c2,
        pearl = pearlColor,
        wheels = wheelColor
    }

    _data.Extras = {}

    for i = 0, 12 do
        local state = IsVehicleExtraTurnedOn(self.Handle, i) == 1
        _data.Extras[tostring(i)] = state
    end

    _data.Wheels = GetVehicleWheelType(self.Handle)
    _data.windowTint = GetVehicleWindowTint(self.Handle)
    _data.XenonColor = GetVehicleXenonLightsColour(self.Handle)

    _data.Neons = {}

    _data.Neons.Enabled = {}

    for i = 0, 3 do
        table.insert(_data.Neons.Enabled, IsVehicleNeonLightEnabled(self.Handle, i))
    end

    _data.Neons.Color = table.pack(GetVehicleNeonLightsColour(self.Handle))

    _data.TireSmokeColor = table.pack(GetVehicleTyreSmokeColor(self.Handle))

    _data.Livery = GetVehicleLivery(self.Handle)
end



--- @class VehicleDoor
VehicleDoor = {
    FrontLeft = 0,
    FrightRight = 1,
    BackLeft = 2,
    BackRight = 3,
    Hood = 4,
    Trunk = 5,
    Back = 6,
    Back2 = 7
}

VehicleMod = {
    Spoiler = 0,
    FrontBumper = 1,
    RearBumper = 2,
    SideSkirt = 3,
    Exhaust = 4,
    Chassis = 5,
    Grille = 6,
    Hood = 7,
    Fender = 8,
    RightFender = 9,
    Roof = 10,
    Engine = 11,
    Brakes = 12,
    Transmission = 13,
    Horns = 14,
    Suspension = 15,
    Armor = 16,
    Turbo = 18,
    TireSmoke = 20,
    Xenon = 22,
    FrontWheels = 23,
    BackWheels = 24,
    PlateHolder = 25,
    VanityPlate = 26,
    Trim = 27,
    Ornaments = 28,
    Dashboard = 29,
    Dial = 30,
    DoorSpeaker = 31,
    Seats = 32,
    SteeringWheel = 33,
    Shifter = 34,
    Plaque = 35,
    Speakers = 36,
    Trunk = 37,
    Hydraulics = 38,
    EngineBlock = 39,
    AirFilter = 40,
    Struts = 41,
    ArchCover = 42,
    Aerials = 43,
    Trim = 44,
    Tank = 45,
    Windows = 46,
    Livery = 48
}

ToggleMods = {
    "Turbo",
    "TireSmoke",
    "Xenon"
}


World = {}

--- creates a vehicle in the world at a given position
--- @param model number | string the model of the vehicle to spawn
--- @param position Vector3 the position to spawn the vehicle at
--- @param heading number the heading of the vehicle (optional. Default: `true`)
--- @param networked boolean  whether the vehicle will be networked (optional. Default: `true`)
--- @return Vehicle
function World:CreateVehicle(model, position, heading, networked)
    local vehModel = Model.new(model)
    if not vehModel:Load() then return end
    local veh = CreateVehicle(vehModel.Hash, position.X, position.Y, position.Z, heading or 0, networked or true, true)
    vehModel:Unload()
    if veh == 0 then
        print("^1Error: An Unknown error happened while creating the vehicle")
        return
    end

    return Vehicle.new(veh)
end

--- Creates a ped in the world
--- @param model number | string the model hash
--- @param position Vector3 the position to spawn the ped at
--- @param heading number | nil the heading to of the ped (optional. Default `0.0`)
--- @param networked boolean | nil whether to create the ped as a networked entity (optional. Default: `true`)
--- @return Ped
function World:CreatePed(model, position, heading, networked, pedType)
    local pedModel = Model.new(model)
    if not pedModel:Load() then return end
    local ped = CreatePed(pedType or PedType.CIVMALE, pedModel.Hash, position.x, position.y, position.z, heading or 0.0, networked or true)
    pedModel:Unload()

    if ped == 0 then
        return Error.new("Failed to create ped"):Print()
    end

    return Ped.new(ped)
end

---@return Camera
function World:CreateCamera(position, rotation, fov)
    local cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", position.X, position.Y, position.Z, rotation.X, rotation.Y, rotation.Z, fov, true, 2)
    print("Created Camera", cam)
    return Camera.new(cam)
end

---@param render boolean
---@param ease boolean
---@param easeTime number
function World:RenderScriptCams(render, ease, easeTime)
    RenderScriptCams(render, ease or false, tonumber(easeTime) or 0, true, true)
end

function World:Weather(weatherType)
    if type(weatherType) == "string" then
        for k,v in pairs(WeatherType) do
            if v == weatherType then
                return SetWeatherTypeNow(weatherType)
            end
        end

        return Error.new("Invalid weather type"):Print()
    end

end

PedType = {
    PLAYER_0 = 0,
    PLAYER_1 = 1,
    NETWORK_PLAYER = 2,
    PLAYER_2 = 3,
    CIVMALE = 4,
    CIVFEMALE = 5,
    COP = 6,
    GANG_ALBANIAN = 7,
    GANG_BIKER_1 = 8,
    GANG_BIKER_2 = 9,
    GANG_ITALIAN = 10,
    GANG_RUSSIAN = 11,
    GANG_RUSSIAN_2 = 12,
    GANG_IRISH = 13,
    GANG_JAMAICAN = 14,
    GANG_AFRICAN_AMERICAN = 15,
    GANG_KOREAN = 16,
    GANG_CHINESE_JAPANESE = 17,
    GANG_PUERTO_RICAN = 18,
    DEALER = 19,
    MEDIC = 20,
    FIREMAN = 21,
    CRIMINAL = 22,
    BUM = 23,
    PROSTITUTE = 24,
    SPECIAL = 25,
    MISSION = 26,
    SWAT = 27,
    ANIMAL = 28,
    ARMY = 29
}

WeatherType = {
    Clear = "CLEAR",
    ExtraSunny = "EXTRASUNNY",
    Clouds = "CLOUDS",
    Overcast = "OVECAST",
    Rain = "RAIN",
    Clearing = "CLEARING",
    Thunder = "THUNDER",
    Smog = "SMOG",
    Foggy = "FOGGY",
    Christmas = "XMAS",
    LightSnow = "SNOWLIGHT",
    Blizzard = "BLIZZARD"
}


