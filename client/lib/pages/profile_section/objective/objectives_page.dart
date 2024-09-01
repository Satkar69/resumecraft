import 'package:flutter/material.dart';
import 'package:resumecraft/models/delete/delete_model.dart';
import 'package:resumecraft/api_services/objective_api_service.dart';
import 'package:resumecraft/utils/mixins/user/user_mixin.dart';
import 'package:snippet_coder_utils/hex_color.dart';

import 'package:resumecraft/utils/mixins/objective/objectives_mixin.dart';

class ObjectivesPage extends StatefulWidget {
  const ObjectivesPage({super.key});

  @override
  State<ObjectivesPage> createState() => ObjectivesPageState();
}

class ObjectivesPageState extends State<ObjectivesPage>
    with UserProfileMixin, ObjectivesMixin {
  final Color primaryColor = HexColor('#283B71');

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final personalDetailID = args?['personalDetailID'] as String?;

    if (personalDetailID != null) {
      setPersonalDetailID(personalDetailID);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Objectives', style: TextStyle(color: Colors.white)),
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (objectives.isNotEmpty)
              ...objectives.map((objective) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: primaryColor,
                        child: Icon(Icons.flag, color: Colors.white),
                      ),
                      title: Text(objective.details ?? 'No objective details'),
                      subtitle:
                          Text(objective.details ?? 'No objective details'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _showConfirmDeleteDialog(objective.id!);
                        },
                      ),
                      onTap: () async {
                        final result = await Navigator.pushNamed(
                          context,
                          '/objective',
                          arguments: {
                            'objectiveID': objective.id,
                            'personalDetailID': personalDetailID
                          },
                        );
                        if (result == true) {
                          setState(() {
                            loadObjectives();
                          });
                        }
                      },
                    ),
                  ),
                );
              })
            else
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'No objectives available. Please create a new objective.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: ElevatedButton(
                child: const Text('+ Add New Objective'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                onPressed: () async {
                  final result = await Navigator.pushNamed(
                    context,
                    '/objective',
                    arguments: {'personalDetailID': personalDetailID},
                  );
                  if (result == true) {
                    setState(() {
                      loadObjectives();
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmDeleteDialog(String objectiveId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Delete"),
          content: Text("Are you sure you want to delete this objective?"),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text("Delete"),
              onPressed: () async {
                Navigator.of(context).pop(); // Close the confirmation dialog

                // Perform delete operation
                try {
                  final response = await ObjectiveAPIService.deleteObjective(
                    DeleteModel(
                      status: 'success',
                      statusCode: 200,
                      message: 'objective delete success',
                    ),
                    userToken,
                    objectiveId,
                  );

                  if (mounted) {
                    if (response.statusCode == 200) {
                      _showResultDialog(response.message!);
                      loadObjectives();
                    } else {
                      _showResultDialog("Unable to delete this objective");
                    }
                  }
                } catch (e) {
                  // Handle error and show result dialog if widget is still mounted
                  if (mounted) {
                    _showResultDialog("An error occurred: ${e.toString()}");
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showResultDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Result"),
          content: Text(message),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the result dialog
              },
            ),
          ],
        );
      },
    );
  }
}
