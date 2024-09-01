import mongoose from "mongoose";
import dotenv from "dotenv";

dotenv.config();

// mongoose.connect(process.env.LOCAL_DATABASE_URI).then(function (err, done) {
//   console.log("Database connected successfully.");
// });

mongoose
  .connect("mongodb://localhost:27017/resume-craft")
  .then(function (err, done) {
    console.log("Database connected successfully.");
  });
