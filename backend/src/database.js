require('dotenv').config({ path: '../.env' });

const mysql = require('mysql2');

// Logs para depuración
console.log('Variables de entorno cargadas:', {
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  database: process.env.DB_DATABASE
});

const mysqlConnection = mysql.createConnection({
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || '',
  database: process.env.DB_DATABASE || 'movies',
  multipleStatements: true
});

mysqlConnection.connect(function (err) {
  if (err) {
    console.error('Error conectando a la base de datos:', err);
    return;
  }
  console.log('¡Conectado exitosamente a la base de datos!');
});

module.exports = mysqlConnection;
