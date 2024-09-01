import 'dart:convert';

DeleteModel deleteModel(String str) => DeleteModel.fromJson(json.decode(str));

class DeleteModel {
  String? status;
  int? statusCode;
  String? message;

  DeleteModel({this.status, this.statusCode, this.message});

  DeleteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['statusCode'] = statusCode;
    data['message'] = message;
    return data;
  }
}
