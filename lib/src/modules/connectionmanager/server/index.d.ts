export default class ConnectionManager {
    onPlayerConnecting(name: string, setKickReason: KickFunc, deferral: Deferral): Promise<void>;
}
