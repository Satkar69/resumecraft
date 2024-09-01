import 'package:flutter/material.dart';
import 'package:resumecraft/models/delete/delete_model.dart';
import 'package:resumecraft/api_services/project_api_service.dart';
import 'package:resumecraft/utils/mixins/user/user_mixin.dart';
import 'package:snippet_coder_utils/hex_color.dart';

import 'package:resumecraft/utils/mixins/project/projects_mixin.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => ProjectsPageState();
}

class ProjectsPageState extends State<ProjectsPage>
    with UserProfileMixin, ProjectsMixin {
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
        title: const Text('Projects', style: TextStyle(color: Colors.white)),
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
            if (projects.isNotEmpty)
              ...projects.map((project) {
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
                        child: Icon(Icons.build, color: Colors.white),
                      ),
                      title: Text(project.projectTitle ?? 'No project title'),
                      subtitle:
                          Text(project.projectDesc ?? 'No project description'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _showConfirmDeleteDialog(project.id!);
                        },
                      ),
                      onTap: () async {
                        final result = await Navigator.pushNamed(
                          context,
                          '/project',
                          arguments: {
                            'projectID': project.id,
                            'personalDetailID': personalDetailID
                          },
                        );
                        if (result == true) {
                          setState(() {
                            loadProjects();
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
                  'No projects available. Please create a new project.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: ElevatedButton(
                child: const Text('+ Add New Project'),
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
                    '/project',
                    arguments: {'personalDetailID': personalDetailID},
                  );
                  if (result == true) {
                    setState(() {
                      loadProjects();
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

  void _showConfirmDeleteDialog(String projectId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Delete"),
          content: Text("Are you sure you want to delete this project?"),
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
                  final response = await ProjectAPIService.deleteProject(
                    DeleteModel(
                      status: 'success',
                      statusCode: 200,
                      message: 'project delete success',
                    ),
                    userToken,
                    projectId,
                  );

                  if (mounted) {
                    if (response.statusCode == 200) {
                      _showResultDialog(response.message!);
                      setState(() {
                        loadProjects();
                      });
                    } else {
                      _showResultDialog("Unable to delete this project");
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
