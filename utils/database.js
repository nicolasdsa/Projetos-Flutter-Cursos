const mysql = require("mysql2/promise");

class DataBase {
  constructor() {
    this.host = process.env.DATABASE_HOST;
    this.database = process.env.DATABASE_DATABASE;
    this.user = process.env.DATABASE_USER;
    this.password = process.env.DATABASE_PASSWORD;
  }

  async init() {
    this.connection = await mysql.createConnection({
      host: this.host,
      user: this.user,
      database: this.database,
      password: this.password,
    });
  }

  async query(sql, params) {
    if(!this.connection){
      await this.init();
    }

    return await this.connection.execute(sql, params);
  }
}

module.exports = new DataBase();
