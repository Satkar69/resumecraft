import 'package:flutter/material.dart';
import 'package:resumecraft/api_services/objective_api_service.dart';
import 'package:resumecraft/utils/shared_prefs/user_shared_prefs.dart';
import 'package:resumecraft/models/profile_section/objective/read/objective_model.dart';

mixin ObjectiveMixin<T extends StatefulWidget> on State<T> {
  Objective? objective;
  String? objectiveID;
  String? personalDetailID;
  bool _detailsLoaded = false;

  @override
  void initState() {
    super.initState();
    // Optionally, you might not call _loadEducation here if id is not set
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      final objectiveID = args?['objectiveID'] as String?;
      final personalDetailID = args?['personalDetailID'] as String?;

      setPersonalDetailID(personalDetailID);

      if (objectiveID != null && !_detailsLoaded) {
        setObjectiveID(objectiveID);
      }
    });
  }

  // Method to set the personalDetailID and load details

  void setPersonalDetailID(String? id) {
    if (personalDetailID != id) {
      personalDetailID = id;
    }
  }

  void setObjectiveID(String? id) {
    if (objectiveID != id) {
      objectiveID = id;
    }
    if (objectiveID != null) {
      _loadObjective();
    }
  }

  Future<void> _loadObjective() async {
    if (_detailsLoaded) return;

    final prefs = await UserSharedPrefs.getLoginResponse();
    final token = prefs?.token ?? '';
    if (token.isNotEmpty && personalDetailID != null) {
      try {
        final data =
            await ObjectiveAPIService.getObjective(token, objectiveID!);
        if (data != null) {
          final obj = ObjectiveModel.fromJson(data);
          if (mounted) {
            setState(() {
              objective = obj.objective ?? Objective();
              _detailsLoaded = true;
            });
          }
        }
      } catch (e) {
        print('Failed to set objective: $e');
      }
    }
  }
}
