const dotenv = require("dotenv");
dotenv.config();

const express = require("express");
const app = express();
const PORT = process.env.API_PORT;

const hospedesRoute = require("./routes/hospedesRoute");
const quartosRoute = require("./routes/quartosRoute");
const reservasRoute = require("./routes/reservasRoute");

app.use(express.json());

app.listen(PORT, () => {
    console.log(`API rodando em http://localhost:${PORT}`);
});