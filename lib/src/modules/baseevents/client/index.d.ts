export default class BaseEvents {
    dead: boolean;
    onKill(): Promise<void>;
}
