const express = require('express');
const router = express.Router();
const mysqlConnection = require('../database.js');

// Obtener todos los comentarios
router.get('/', (req, res) => {
  mysqlConnection.query('SELECT * FROM comments ORDER BY created_at DESC', (err, rows) => {
    if (!err) {
      res.json(rows);
    } else {
      console.log(err);
      res.status(500).json({ error: err });
    }
  });
});

// Crear un nuevo comentario
router.post('/', (req, res) => {
  const { name, comment } = req.body;
  const query = 'INSERT INTO comments (name, comment) VALUES (?, ?)';
  
  mysqlConnection.query(query, [name || 'Anónimo', comment], (err, rows) => {
    if (!err) {
      res.json({
        status: 'Comentario guardado',
        id: rows.insertId
      });
    } else {
      console.log(err);
      res.status(500).json({ error: err });
    }
  });
});

module.exports = router; 