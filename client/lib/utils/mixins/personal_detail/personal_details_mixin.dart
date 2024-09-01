import 'package:flutter/material.dart';

import 'package:resumecraft/api_services/personal_detail_api_service.dart';
import 'package:resumecraft/utils/shared_prefs/user_shared_prefs.dart';
import 'package:resumecraft/models/profile_section/personal_detail/read/personal_details_model.dart';

mixin PersonalDetailsMixin<T extends StatefulWidget> on State<T> {
  List<Userdetails> personalDetails = [];

  @override
  void initState() {
    super.initState();
    loadPersonalDetails();
  }

  Future<void> loadPersonalDetails() async {
    final prefs = await UserSharedPrefs.getLoginResponse();
    final token = prefs?.token ?? '';
    if (token.isNotEmpty) {
      try {
        final data = await PersonalDetailAPIService.getPersonalDetails(token);
        final details = PersonalDetailsModel.fromJson(data);
        setState(() {
          personalDetails = details.userdetails ?? [];
        });
      } catch (e) {
        print('Failed to set personal details: $e');
      }
    }
  }
}
