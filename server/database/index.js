import mongoose from "mongoose";

mongoose
  .connect("mongodb://localhost:27017/resume-craft")
  .then(function (err, done) {
    console.log("Database connected successfully.");
  });
