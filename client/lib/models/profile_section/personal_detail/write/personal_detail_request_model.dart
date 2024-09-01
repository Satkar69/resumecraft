class PersonalDetailRequestModel {
  String? user;
  String? fullname;
  String? address;
  String? email;
  String? contact;
  String? image;
  List<String>? socials;

  PersonalDetailRequestModel({
    this.user,
    this.fullname,
    this.address,
    this.email,
    this.contact,
    this.image,
    this.socials,
  });

  PersonalDetailRequestModel.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    fullname = json['fullname'];
    address = json['address'];
    email = json['email'];
    contact = json['contact'];
    image = json['image'];

    if (json['socials'] != null) {
      socials = List<String>.from(json['socials']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = user;
    data['fullname'] = fullname;
    data['address'] = address;
    data['email'] = email;
    data['contact'] = contact;
    data['image'] = image;

    if (socials != null) {
      data['socials'] = socials;
    }

    return data;
  }
}
