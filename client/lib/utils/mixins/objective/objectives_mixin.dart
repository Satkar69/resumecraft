import 'package:flutter/material.dart';

import 'package:resumecraft/api_services/objective_api_service.dart';
import 'package:resumecraft/utils/shared_prefs/user_shared_prefs.dart';
import 'package:resumecraft/models/profile_section/objective/read/objectives_model.dart';

mixin ObjectivesMixin<T extends StatefulWidget> on State<T> {
  List<Objectives> objectives = [];
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
      loadObjectives();
    }
  }

  Future<void> loadObjectives() async {
    if (_detailsLoaded) return;

    final prefs = await UserSharedPrefs.getLoginResponse();
    final token = prefs?.token ?? '';
    if (token.isNotEmpty) {
      try {
        final data = await ObjectiveAPIService.getObjectivesByPersonalDetail(
            token, personalDetailID!);
        final objs = ObjectivesModel.fromJson(data);
        setState(() {
          objectives = objs.objectives ?? [];
        });
      } catch (e) {
        print('Failed to set objectives: $e');
      }
    }
  }
}
