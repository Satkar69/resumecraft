import mongoose from "mongoose";
import { Schema } from "mongoose";

const education = new Schema({
  userdetail: {
    type: Schema.Types.ObjectId,
    ref: "userdetail",
  },
  course: {
    type: String,
    trim: true,
    default: null,
  },
  university: {
    type: String,
    trim: true,
    default: null,
  },
  gpa: {
    type: String,
    trim: true,
    default: null,
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
