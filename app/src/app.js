const express = require("express");
const app = express();
const port = process.env.PORT || 3000;

app.get("/", (req, res) => {
  res.send(
    `<body style="background: black; color: white;"><h1><center>
    Hello Eyego 
    </center></h1></body `
  );
});

app.listen(port, () => console.log(`App running on port ${port}`));
