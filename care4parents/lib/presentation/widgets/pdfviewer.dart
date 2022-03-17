
import 'package:auto_route/auto_route.dart';
import 'package:care4parents/presentation/widgets/custom_app_bar.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class PdfViewer extends StatefulWidget {
  final String pdfUrl,title;
  PdfViewer({this.pdfUrl,this.title});

  @override
  _PdfViewerState createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {

  bool loading=true;

  String url;


  @override
  void initState() {
    // TODO: implement initState
    initpdf();
    super.initState();
  }


  void initpdf() async{
    print("pdfviewer>> "+widget.pdfUrl);
    setState(() {
      loading=true;
    });
    setState(() {

      loading=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    url=widget.pdfUrl;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Sizes.HEIGHT_56),
          child: CustomAppBar(
            title: StringConst.View_pdf,
            hasLeading: true,
            leading: InkWell(
              onTap: () => ExtendedNavigator.root.pop(),
              child: Icon(
                Icons.arrow_back_outlined,
                color: AppColors.white,
              ),
            ),
            hasTrailing: false,
          ),
        ),
      body:
      Container(
    child:const PDF().fromUrl(
      url,
      placeholder: (double progress) => Center(child: Text('$progress %')),
      errorWidget: (dynamic error) => Center(child: Text(error.toString())),
    ),)
        );
  }
}
