import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:resumecraft/config.dart';
import 'package:resumecraft/utils/mixins/user/user_mixin.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class PDFPreviewPage extends StatefulWidget {
  const PDFPreviewPage({Key? key}) : super(key: key);

  @override
  _PDFPreviewPageState createState() => _PDFPreviewPageState();
}

class _PDFPreviewPageState extends State<PDFPreviewPage> with UserProfileMixin {
  List<PDFData> _localPdfPaths = [];
  bool _isLoading = true;
  bool _isProfileLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadUserProfileAndDownloadPdfs();
  }

  Future<void> _loadUserProfileAndDownloadPdfs() async {
    await loadUserProfile();
    setState(() {
      _isProfileLoaded = true; // Mark profile as loaded
    });
    _downloadPdfs();
  }

  Future<void> _downloadPdfs() async {
    try {
      List<PDFData> pdfDataList = [];
      for (String pdfUrl in resume) {
        String fileName = path.basename(pdfUrl); // Extract the file name
        String localPath = await _downloadFile('${Config.getPdfs}$pdfUrl');
        if (localPath.isNotEmpty) {
          pdfDataList.add(PDFData(localPath: localPath, fileName: fileName));
        }
      }
      if (pdfDataList.isNotEmpty) {
        setState(() {
          _localPdfPaths = pdfDataList;
          _isLoading = false;
        });
      } else {
        print('Error: No PDFs were downloaded.');
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error downloading PDFs: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<String> _downloadFile(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        final directory = await getApplicationDocumentsDirectory();
        final filePath = path.join(directory.path, path.basename(url));

        final file = File(filePath);
        await file.writeAsBytes(bytes);
        print('Downloaded PDF to: $filePath');

        // Verify the file size
        if (await file.length() > 0) {
          return filePath;
        } else {
          print('Error: Downloaded file is empty.');
          return '';
        }
      } else {
        print(
            'Error: Failed to download PDF. Status code: ${response.statusCode}');
        return '';
      }
    } catch (e) {
      print('Error: $e');
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = HexColor('#283B71');
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [primaryColor, const Color.fromARGB(255, 26, 101, 162)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: Text('Resumes', style: TextStyle(color: Colors.white)),
              ),
              _isLoading
                  ? Expanded(
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : Expanded(
                      child: _localPdfPaths.isEmpty
                          ? Center(child: Text('No PDFs available'))
                          : LayoutBuilder(
                              builder: (context, constraints) {
                                return GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        constraints.maxWidth > 600 ? 2 : 1,
                                    childAspectRatio: 0.7,
                                  ),
                                  itemCount: _localPdfPaths.length,
                                  itemBuilder: (context, index) {
                                    return PDFPreviewCard(
                                      pdfData: _localPdfPaths[index],
                                      onDownload: () => _downloadSelectedPdf(
                                          context,
                                          _localPdfPaths[index].localPath,
                                          _localPdfPaths[index].fileName),
                                    );
                                  },
                                );
                              },
                            ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _downloadSelectedPdf(
      BuildContext context, String filePath, String fileName) async {
    try {
      final directory = await getExternalStorageDirectory();
      final downloadsDir = Directory(path.join(directory!.path, 'Download'));

      if (!await downloadsDir.exists()) {
        await downloadsDir.create(recursive: true);
      }

      final newFilePath = path.join(downloadsDir.path, fileName);
      final file = File(filePath);
      final newFile = await file.copy(newFilePath);

      print('PDF downloaded to: $newFilePath');

      // Optionally, show a confirmation dialog or a toast
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Downloaded to $newFilePath')),
      );
    } catch (e) {
      print('Error downloading PDF: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to download PDF')),
      );
    }
  }
}

class PDFData {
  final String localPath;
  final String fileName;

  PDFData({required this.localPath, required this.fileName});
}

class PDFPreviewCard extends StatelessWidget {
  final PDFData pdfData;
  final VoidCallback onDownload;

  const PDFPreviewCard({
    Key? key,
    required this.pdfData,
    required this.onDownload,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 4,
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              child: PDFView(
                filePath: pdfData.localPath,
                enableSwipe: true,
                swipeHorizontal: true,
                autoSpacing: false,
                pageFling: false,
                onError: (error) {
                  print('Error loading PDF: $error');
                },
                onRender: (pages) {
                  print('PDF Rendered with $pages pages');
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    pdfData.fileName,
                    style: TextStyle(fontSize: 12),
                    overflow: TextOverflow.ellipsis, // Prevents text overflow
                    maxLines: 1, // Ensures text stays on one line
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.download_rounded),
                  onPressed: onDownload,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
