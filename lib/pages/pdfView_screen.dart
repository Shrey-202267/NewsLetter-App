// import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:lottie/lottie.dart';

// class pdfViewerScreen extends StatefulWidget {
//   final String pdfUrl;
//   final bool showNavigation;
//   final bool showIndicator;

//   const pdfViewerScreen(
//       {super.key,
//       required this.pdfUrl,
//       required this.showIndicator,
//       required this.showNavigation});

//   @override
//   State<pdfViewerScreen> createState() => _pdfViewerScreenState();
// }

// class _pdfViewerScreenState extends State<pdfViewerScreen> {
//   PDFDocument? document;

//   void initialisePdf() async {
//     document = await PDFDocument.fromURL(widget.pdfUrl);
//     setState(() {});
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     initialisePdf();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//       ),
//       body: document != null
//           ? Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height,
//               child: PDFViewer(
//                 backgroundColor: Colors.white,
//                 document: document!,
//                 pickerButtonColor: Color(0xFFf58634),
//                 showIndicator: widget.showIndicator,
//                 indicatorBackground: Colors.grey.shade500,
//                 showNavigation: widget.showNavigation,
//                 showPicker: false,
//                 lazyLoad: false,
//                 progressIndicator: CircularProgressIndicator(
//                   color: Color(0xFFf58634),
//                 ),
//               ),
//             )
//           : Center(
//               child: CircularProgressIndicator(
//                 color: Color(0xFFf58634),
//               ),
//               // child: Lottie.asset('lib/Images/Loading.json', repeat: true),
//             ),
//     );
//   }
// }

import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';

class pdfViewerScreen extends StatefulWidget {
  final String pdfUrl;
  final bool showNavigation;
  final bool showIndicator;

  const pdfViewerScreen({
    super.key,
    required this.pdfUrl,
    required this.showIndicator,
    required this.showNavigation,
  });

  @override
  State<pdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<pdfViewerScreen> {
  PDFDocument? document;

  void initialisePdf() async {
    document = await PDFDocument.fromURL(widget.pdfUrl);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initialisePdf();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'PDF Viewer',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: document != null
          ? Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: PDFViewer(
                backgroundColor: Colors.white,
                document: document!,
                pickerButtonColor: Color(0xFFf58634),
                showIndicator: widget.showIndicator,
                showNavigation: widget.showNavigation,
                showPicker: false,
                lazyLoad: false,
                progressIndicator: CircularProgressIndicator(
                  color: Color(0xFFf58634),
                ),
                navigationBuilder:
                    (context, page, totalPages, jumpToPage, animateToPage) {
                  return Container(
                    color: Colors.grey
                        .shade200, // Set the background color of the navigation bar to grey
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.first_page_rounded,
                              size: 30, color: Colors.grey.shade600),
                          onPressed: (totalPages != null)
                              ? () {
                                  jumpToPage(page: 0);
                                }
                              : null,
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios,
                              size: 20, color: Colors.grey.shade600),
                          onPressed: (page != null && page > 1)
                              ? () {
                                  jumpToPage(page: page! - 2);
                                }
                              : null,
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_forward_ios,
                              size: 20, color: Colors.grey.shade600),
                          onPressed: (page != null &&
                                  totalPages != null &&
                                  page < totalPages)
                              ? () {
                                  jumpToPage(page: page!);
                                }
                              : null,
                        ),
                        IconButton(
                          icon: Icon(Icons.last_page_rounded,
                              size: 30, color: Colors.grey.shade600),
                          onPressed: (totalPages != null)
                              ? () {
                                  jumpToPage(page: totalPages - 1);
                                }
                              : null,
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          : Center(
              child: CircularProgressIndicator(
                color: Color(0xFFf58634),
              ),
            ),
    );
  }
}
