const express = require("express");

const app = express();
const port = process.env.PORT || 3000;

app.use(express.json());

app.get("/", (req, res) => {
  res.json({
    service: "Function Hall Booking - Node.js Service",
    status: "running"
  });
});

app.get("/api/health", (req, res) => {
  res.json({ status: "UP" });
});

app.listen(port, () => {
  console.log(`Node service running on port ${port}`);
});
