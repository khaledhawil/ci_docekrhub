const express = require('express');
const app = express();
const port = 8000;

app.get('/', (req, res) => {
     res.send('Hello World!!!!! And Why U are So Seruce');
});

app.listen(port, () => {
     console.log(`Example app listening at http://localhost:${port}`);
});

