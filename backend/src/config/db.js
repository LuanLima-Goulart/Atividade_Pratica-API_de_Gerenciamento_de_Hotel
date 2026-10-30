const mysql = require("mysql2/promise");
const dotenv = require("dotenv");
dotenv.config();

const connection = mysql.createPool ({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    port: process.env.DB_PORT,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    dateStrings: true
});

module.exports = connection;