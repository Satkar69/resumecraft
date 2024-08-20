import mongoose from "mongoose";
import { Schema } from "mongoose";

const userdetail = new Schema({
  user: {
    type: Schema.ObjectId,
    ref: "user",
  },
  fullname: {
    type: String,
    required: [true, "fullname is a required field"],
    trim: true,
  },
  address: {
    type: String,
    required: [true, "address is a required field"],
    trim: true,
  },
  email: {
    type: String,
    required: [true, "email is a required field"],
    trim: true,
  },
  contact: {
    type: String,
    required: [true, "contact is a required field"],
    trim: true,
  },
  image: {
    type: String,
    trim: true,
    default: "",
  },
  socials: {
    type: [String],
    default: [],
  },
});

const UserDetail = mongoose.model("userdetail", userdetail);

export default UserDetail;
