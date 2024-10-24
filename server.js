// server.js
const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const dotenv = require('dotenv');
const userRoutes = require('./routes/userRoutes'); // Asegúrate de que esta ruta sea correcta

dotenv.config();

const app = express();
const PORT = process.env.PORT || 5000;

// Middleware
app.use(cors());
app.use(express.json());

// Ruta básica de prueba
app.get('/', (req, res) => {
  res.send('API de DisPets está funcionando');
});

// Rutas de usuarios
app.use('/api/users', userRoutes); // Esto debe estar después de app.use(cors()) y app.use(express.json())

// Conexión a MongoDB
mongoose.connect(process.env.MONGODB_URI, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
}).then(() => {
  console.log('Conectado a MongoDB');
}).catch((error) => {
  console.log('Error conectando a MongoDB:', error);
});

app.listen(PORT, () => {
  console.log(`Servidor ejecutándose en el puerto ${PORT}`);
});
