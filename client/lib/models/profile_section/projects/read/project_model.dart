class ProjectModel {
  String? status;
  int? statusCode;
  Project? project;

  ProjectModel({this.status, this.statusCode, this.project});

  ProjectModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    project =
        json['project'] != null ? Project.fromJson(json['project']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['statusCode'] = statusCode;
    if (project != null) {
      data['project'] = project!.toJson();
    }
    return data;
  }
}

class Project {
  String? id;
  String? userdetail;
  String? projectTitle;
  String? projectDesc;
  List<String>? links;

  Project({
    this.id,
    this.userdetail,
    this.projectTitle,
    this.projectDesc,
    this.links,
  });

  Project.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    userdetail = json['userdetail'];
    projectTitle = json['project_title'];
    projectDesc = json['project_desc'];

    if (json['links'] != null) {
      links = List<String>.from(json['links']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['user'] = userdetail;
    data['fullname'] = projectTitle;
    data['address'] = projectDesc;

    if (links != null) {
      data['links'] = links;
    }
    return data;
  }
}
