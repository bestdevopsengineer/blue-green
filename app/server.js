const express = require("express");
const app = express();

const VERSION = process.env.VERSION || "blue";

app.get("/", (req, res) => {
  res.send(`Hello from ${VERSION} environment`);
});

app.get("/health", (req, res) => {
  res.status(200).send("OK");
});

app.listen(3000, () => {
  console.log(`App running on port 3000 - ${VERSION}`);
});
