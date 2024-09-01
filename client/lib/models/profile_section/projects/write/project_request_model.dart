class ProjectRequestModel {
  String? userdetail;
  String? projectTitle;
  String? projectDesc;
  List<String>? links;

  ProjectRequestModel(
      {this.userdetail, this.projectTitle, this.projectDesc, this.links});

  ProjectRequestModel.fromJson(Map<String, dynamic> json) {
    userdetail = json['userdetail'];
    projectTitle = json['project_title'];
    projectDesc = json['project_desc'];

    if (json['links'] != null) {
      links = List<String>.from(json['links']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userdetail'] = userdetail;
    data['project_title'] = projectTitle;
    data['project_desc'] = projectDesc;

    if (links != null) {
      data['links'] = links;
    }

    return data;
  }
}
