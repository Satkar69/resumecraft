import mongoose from "mongoose";
import { Schema } from "mongoose";

const education = new Schema({
  userdetail: {
    type: Schema.ObjectId,
    ref: "userdetail",
  },
  course: {
    type: String,
    trim: true,
    default: "",
  },
  university: {
    type: String,
    trim: true,
    default: "",
  },
  gpa: {
    type: String,
    trim: true,
    default: "",
  },
  start_date: {
    type: Date,
    default: null,
  },
  end_date: {
    type: Date,
    default: null,
  },
});

const Education = mongoose.model("education", education);

export default Education;
