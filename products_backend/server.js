// products_backend/server.js

const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
require('dotenv').config();

const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// Routes
const productRoutes = require('./routes/productRoutes');
app.use('/api/products', productRoutes);

// MongoDB connection
mongoose.connect(process.env.MONGO_URI)
  .then(() => {
    console.log('MongoDB connected');
    app.listen(process.env.PORT, () => {
      console.log(`Server running on port ${process.env.PORT}`);
    });
  })
  .catch(err => console.log(err));

//   mongoose.connect('mongodb+srv://smkumar210:42uGjMX1px3idGDh@cluster0.akvlh.mongodb.net/CRUDAPI?retryWrites=true&w=majority&appName=Cluster0')
//   .then(() => {
//       console.log('Connected to MongoDB')
//   })
//   .catch((err) => {
//       console.log('Connection failed', err);
//   })