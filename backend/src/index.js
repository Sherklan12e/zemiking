const express = require('express');
const cors = require('cors');
const path = require('path');
const app = express();

// Settings
app.set('port', process.env.PORT || 3000);

// Middlewares
app.use(cors());
app.use(express.json());

// Servir archivos estáticos
app.use('/uploads', express.static(path.join(__dirname, 'public/uploads')));

// Routes
app.use('/api', require('./routes/movies'));
app.use('/comments', require('./routes/comments'));

// Starting the server
app.listen(app.get('port'), () => {
  console.log(`Servidor en puerto ${app.get('port')}`);
});