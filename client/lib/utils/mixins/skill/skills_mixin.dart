import 'package:flutter/material.dart';

import 'package:resumecraft/api_services/skill_api_service.dart';
import 'package:resumecraft/utils/shared_prefs/user_shared_prefs.dart';
import 'package:resumecraft/models/profile_section/skills/read/skills_model.dart';

mixin SkillsMixin<T extends StatefulWidget> on State<T> {
  List<Skills> skills = [];
  String? personalDetailID;
  bool _detailsLoaded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      final personalDetailID = args?['personalDetailID'] as String?;
      if (personalDetailID != null && !_detailsLoaded) {
        setPersonalDetailID(personalDetailID);
      }
    });
  }

  void setPersonalDetailID(String? id) {
    if (personalDetailID != id) {
      personalDetailID = id;
      loadSkills();
    }
  }

  Future<void> loadSkills() async {
    final prefs = await UserSharedPrefs.getLoginResponse();
    final token = prefs?.token ?? '';
    if (token.isNotEmpty) {
      try {
        final data = await SkillAPIService.getSkillsByPersonalDetail(
            token, personalDetailID!);
        final sks = SkillsModel.fromJson(data);
        setState(() {
          skills = sks.skills ?? [];
        });
      } catch (e) {
        print('Failed to set skills: $e');
      }
    }
  }
}
