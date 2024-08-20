import mongoose from "mongoose";
import { Schema } from "mongoose";

const objective = new Schema({
  userdetail: {
    type: Schema.ObjectId,
    ref: "userdetail",
  },
  details: {
    type: String,
    default: "",
  },
});

const Objective = mongoose.model("objective", objective);

export default Objective;
