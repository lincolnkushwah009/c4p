import 'dart:async';
import 'dart:io';

import 'package:care4parents/presentation/layout/adaptive.dart';
import 'package:care4parents/presentation/widgets/app_loading.dart';
import 'package:care4parents/presentation/widgets/bg_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import 'package:care4parents/data/models/vital_type_result.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import 'constants.dart';

class EcgPdf extends StatefulWidget {
  const EcgPdf({
    Key key,
    @required this.ecgFile,
  }) : super(key: key);

  final String ecgFile;

  @override
  _EcgPdfState createState() => _EcgPdfState();
}

class _EcgPdfState extends State<EcgPdf> {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  String remotePDFpath = "";

  @override
  void initState() {
    print('ecgFile' + widget.ecgFile.toString());
    super.initState();

    createFileOfPdfUrl().then((f) {
      setState(() {
        remotePDFpath = f.path;
      });
      print('remotePDFpath >> ' + remotePDFpath.toString());
    });
  }
  File file;
  Future<File> createFileOfPdfUrl() async {
    Completer<File> completer = Completer();
    print("Start download file from internet!");
    try {
      final url = widget.ecgFile;
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getExternalStorageDirectory();
      print("Download files");
      print("${dir.path}/$filename");
       file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    double widthOfScreen = assignWidth(context: context, fraction: 1.0);
    double heightOfScreen = assignHeight(context: context, fraction: 1.0);

    return (remotePDFpath != null || remotePDFpath.isNotEmpty)
        ? Container(
            height: heightOfScreen * 0.3,
            child: PDFView(
                 filePath: file.path,
              enableSwipe: true,
              swipeHorizontal: true,
              autoSpacing: false,
              pageFling: false,
              onRender: (_pages) {
                // setState(() {
                //   pages = _pages;
                //   isReady = true;
                // });
              },
              onError: (error) {
                print('error error error error errorerrorerrorerror' +
                    error.toString());
              },
              onPageError: (page, error) {
                print('$page: ${error.toString()}');
              },
              onViewCreated: (PDFViewController pdfViewController) {
                _controller.complete(pdfViewController);
              },
              onPageChanged: (int page, int total) {
                print('page change: $page/$total');
              },
            ),
          )
        : AppLoading();
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
// // import 'package:toast/toast.dart';

// class EcgPdfPage extends StatefulWidget {
//   final String url;
//   EcgPdfPage({Key key, @required this.url}) : super(key: key);

//   @override
//   _EcgPdfPageState createState() => _EcgPdfPageState();
// }

// class _EcgPdfPageState extends State<EcgPdfPage> {
//   bool _isLoading = true;
//   PDFDocument document;

//   @override
//   initState() {
//     super.initState();
//     print("EcgPdfPage");
//     print(widget.url);
//     loadDocument();
//   }

//   loadDocument() async {
//     var url = widget.url;
//     try {
//       if (url != null && url != "") {
//         print(url.toLowerCase());
//         print(url.toLowerCase().indexOf(".pdf"));

//         if (url.toLowerCase().indexOf(".pdf") > -1) {
//           document = await PDFDocument.fromURL(url);
//           if (document != null) setState(() => _isLoading = false);
//         } else {
//           setState(() => _isLoading = false);
//           //return Image.network(url);
//         }
//       }
//     } catch (err) {
//       print("EcgPdfPage loadDocument");
//       print(err);
//       // Toast.show("Invalid Report Format!", context,
//       //     duration: Toast.LENGTH_LONG,
//       //     gravity: Toast.BOTTOM,
//       //     backgroundColor: Colors.white,
//       //     textColor: Colors.black);
//       Navigator.pop(context);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('ECG', style: TextStyle(color: Color(0xFF0059A5))),
//         backgroundColor: Colors.white,
//       ),
//       body: GestureDetector(
//         child: Center(
//             child: _isLoading
//                 ? Center(child: CircularProgressIndicator())
//                 : (widget.url.toLowerCase().indexOf(".pdf") > -1)
//                     ? PDFViewer(document: document)
//                     : Image.network(widget.url)),
//         onTap: () {
//           Navigator.pop(context);
//         },
//       ),
//     );
//   }
// }
