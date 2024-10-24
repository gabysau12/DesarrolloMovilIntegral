// routes/userRoutes.js
const express = require('express');
const router = express.Router();
const User = require('../models/User'); // Asegúrate de que la ruta al modelo sea correcta
const bcrypt = require('bcrypt');

// Ruta para registrar un nuevo usuario
router.post('/register', async (req, res) => {
  const { username, email, password } = req.body;

  try {
    const userExist = await User.findOne({ email });
    if (userExist) return res.status(400).json({ message: 'Usuario ya existe' });

    const hashedPassword = await bcrypt.hash(password, 10);
    const newUser = new User({ username, email, password: hashedPassword });
    await newUser.save();
    res.status(201).json({ message: 'Usuario creado con éxito' });
  } catch (error) {
    console.error('Error al crear usuario:', error); // Añadir este log
    res.status(500).json({ message: 'Error al crear usuario' });
  }
});

// Ruta para iniciar sesión
router.post('/login', async (req, res) => {
  const { email, password } = req.body;

  try {
    const user = await User.findOne({ email });
    if (!user) return res.status(400).json({ message: 'Usuario no encontrado' });

    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) return res.status(400).json({ message: 'Contraseña incorrecta' });

    res.status(200).json({ message: 'Inicio de sesión exitoso' });
  } catch (error) {
    console.error('Error al iniciar sesión:', error); // Añadir este log
    res.status(500).json({ message: 'Error al iniciar sesión' });
  }
});

// Ruta para actualizar usuario
router.put('/:id', async (req, res) => {
  const { username, email, password } = req.body;
  const { id } = req.params;

  try {
    const updatedUser = await User.findByIdAndUpdate(
      id,
      { username, email, password },
      { new: true }
    );

    if (!updatedUser) {
      return res.status(404).json({ message: 'Usuario no encontrado' });
    }

    res.status(200).json({ message: 'Usuario actualizado', user: updatedUser });
  } catch (error) {
    console.error('Error al actualizar usuario:', error); // Añadir este log
    res.status(500).json({ message: 'Error al actualizar el usuario' });
  }
});

module.exports = router;
