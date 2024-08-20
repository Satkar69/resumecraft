import mongoose from "mongoose";
import { Schema } from "mongoose";

const experience = new Schema({
  userdetail: {
    type: Schema.ObjectId,
    ref: "userdetail",
  },
  company_name: {
    type: String,
    trim: true,
    default: "",
  },
  job_title: {
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
  details: {
    type: String,
    default: "",
  },
});

const Experience = mongoose.model("experience", experience);

export default Experience;
