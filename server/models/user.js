import mongoose from "mongoose";
import { Schema } from "mongoose";

const user = new Schema({
  username: {
    type: String,
    required: [true, "username is a required field"],
    maxLength: [10, "username must not have more than 10 characters"],
    minLength: [5, "username must not have less than 5 characters"],
    unique: true,
    trim: true,
  },
  email: {
    type: String,
    required: [true, "email is a required field"],
    unique: true,
    trim: true,
    lowercase: true,
  },
  password: {
    type: String,
    required: [true, "password is a required field"],
  },
  resume: {
    type: [String],
    default: [],
  },
  created_at: {
    type: Date,
    default: Date.now,
  },
  updated_at: {
    type: Date,
    default: Date.now,
  },
});

// Middleware to update `updated_at` field on save
user.pre("save", function (next) {
  this.updated_at = Date.now();
  next();
});

const User = mongoose.model("user", user);

export default User;
