import { Sequelize } from "sequelize-typescript";
export default class DbDriver {
    instance: Sequelize;
    $onReady(): Promise<void>;
}
