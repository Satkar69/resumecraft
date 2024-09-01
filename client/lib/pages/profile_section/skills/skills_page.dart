import 'package:flutter/material.dart';
import 'package:resumecraft/models/delete/delete_model.dart';
import 'package:resumecraft/api_services/skill_api_service.dart';
import 'package:resumecraft/utils/mixins/user/user_mixin.dart';
import 'package:snippet_coder_utils/hex_color.dart';

import 'package:resumecraft/utils/mixins/skill/skills_mixin.dart';

class SkillssPage extends StatefulWidget {
  const SkillssPage({super.key});

  @override
  State<SkillssPage> createState() => SkillssPageState();
}

class SkillssPageState extends State<SkillssPage>
    with UserProfileMixin, SkillsMixin {
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
        title: const Text('Skills', style: TextStyle(color: Colors.white)),
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
            if (skills.isNotEmpty)
              ...skills.map((skill) {
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
                        child: Icon(Icons.star, color: Colors.white),
                      ),
                      title: Text(skill.skillName ?? 'No skill name'),
                      subtitle:
                          Text(skill.skillPercentage ?? 'No skill percentage'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _showConfirmDeleteDialog(skill.id!);
                        },
                      ),
                      onTap: () async {
                        final result = await Navigator.pushNamed(
                          context,
                          '/skill',
                          arguments: {
                            'skillID': skill.id,
                            'personalDetailID': personalDetailID
                          },
                        );
                        if (result == true) {
                          setState(() {
                            loadSkills();
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
                  'No skills available. Please create a new skill.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: ElevatedButton(
                child: const Text('+ Add New Skill'),
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
                    '/skill',
                    arguments: {'personalDetailID': personalDetailID},
                  );
                  if (result == true) {
                    setState(() {
                      loadSkills();
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

  void _showConfirmDeleteDialog(String skillId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Delete"),
          content: Text("Are you sure you want to delete this skill?"),
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
                  final response = await SkillAPIService.deleteSkill(
                    DeleteModel(
                      status: 'success',
                      statusCode: 200,
                      message: 'skill delete success',
                    ),
                    userToken,
                    skillId,
                  );

                  if (mounted) {
                    if (response.statusCode == 200) {
                      _showResultDialog(response.message!);
                      setState(() {
                        loadSkills();
                      });
                    } else {
                      _showResultDialog("Unable to delete this skill");
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
