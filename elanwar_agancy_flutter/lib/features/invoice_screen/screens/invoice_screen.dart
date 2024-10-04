import 'dart:typed_data';
import 'package:elanwar_agancy_client/elanwar_agancy_client.dart';
import 'package:elanwar_agancy_flutter/core/app_router.dart';
import 'package:elanwar_agancy_flutter/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:elanwar_agancy_flutter/features/dashboard/main_screen/providers/get_all_reservations_provider.dart';

class InvoiceScreen extends ConsumerStatefulWidget {
  const InvoiceScreen({super.key, required this.clientId});
  static String route(int clientId) => "/invoice/$clientId";
  final int clientId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends ConsumerState<InvoiceScreen> {
  late Future<Uint8List> _pdfFuture;

  @override
  void initState() {
    super.initState();
    _pdfFuture = _generateInvoicePdf();
  }

  @override
  Widget build(BuildContext context) {
    final reservations = ref.read(getAllReservationsProvider);
    final clientName = reservations[widget.clientId]!.fullName.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice for Client $clientName'),
      ),
      body: FutureBuilder<Uint8List>(
        future: _pdfFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error loading PDF: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            return Column(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: PdfPreview(
                      pdfFileName: "$clientName.pdf",
                      build: (format) async =>
                          snapshot.data!, // Use loaded PDF data
                      allowPrinting: true,
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            );
          } else {
            return Center(
              child: Text('Something went wrong!'),
            );
          }
        },
      ),
    );
  }

  Future<Uint8List> _generateInvoicePdf() async {
    final reservations = ref.read(getAllReservationsProvider);
    final clientName = reservations[widget.clientId]!.fullName.toString();
    final adress = reservations[widget.clientId]!.adress.toString();
    final hotelName = reservations[widget.clientId]!.hotel.toString();
    final roomNumber = reservations[widget.clientId]!.room.toString();
    final reservationID = reservations[widget.clientId]!.id.toString();
    final reservationStart = reservations[widget.clientId]!.createAt.toString();
    final reservationEnd = reservations[widget.clientId]!.endDate.toString();
    final price = reservations[widget.clientId]!.totalPrice.toString();
    final payed = reservations[widget.clientId]!.payed.toString();
    final debt = reservations[widget.clientId]!.debt.toString();
    final phoneNumber = reservations[widget.clientId]!.phoneNumber.toString();

    final pdf = pw.Document();
    var arabicFont =
        pw.Font.ttf(await rootBundle.load("assets/fonts/Hacen-Tunisia.ttf"));

    pdf.addPage(
      pw.Page(
        theme: pw.ThemeData.withFont(base: arabicFont),
        pageFormat: PdfPageFormat.a4,
        textDirection: pw.TextDirection.rtl,
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'وكالة انوار الصباح للسياحة والأسفار ادرار',
                        style: pw.TextStyle(
                          fontSize: 24,
                          fontWeight: pw.FontWeight.bold,
                          font: arabicFont,
                        ),
                      ),
                      pw.Text('حي 400 مسكن أدرار, الجزائر'),
                      pw.Text('0661429999|0661417777'),
                      pw.Text('anouaradrar001@gmail.com'),
                    ],
                  ),
                  pw.BarcodeWidget(
                    drawText: false,
                    data: "https://maps.app.goo.gl/KFxsmJcCokg137rq7",
                    barcode: pw.Barcode.code128(),
                    width: 100,
                    height: 50,
                  ),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('وصل الحجز',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 24,
                        font: arabicFont,
                      )),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('تاريخ الطلب'),
                      pw.Text(DateTime.now().toString()),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Container(
                decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.grey)),
                padding: const pw.EdgeInsets.all(10),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('فاتورة إلى',
                            textDirection: pw.TextDirection.rtl,
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              font: arabicFont,
                            )),
                        pw.Text('الإسم: $clientName'),
                        pw.Text('مكان السكن: $adress'),
                        pw.Text('رقم الهاتف: $phoneNumber'),
                      ],
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 20),
              pw.TableHelper.fromTextArray(
                headers: [
                  'الدين الياقي',
                  'المدفوع',
                  'المبلغ',
                  'نهاية الحجز',
                  'بداية الحجز',
                  'رقم الغرفة',
                  'إسم الفندق',
                ],
                tableWidth: pw.TableWidth.max,
                tableDirection: pw.TextDirection.rtl,
                cellAlignment: pw.Alignment.center,
                defaultColumnWidth: pw.FixedColumnWidth(12),
                headerStyle: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold, font: arabicFont),
                cellStyle: pw.TextStyle(fontSize: 12),
                data: [
                  [
                    debt,
                    payed,
                    price,
                    reservationEnd.toString(),
                    reservationStart,
                    roomNumber,
                    hotelName
                  ],
                ],
              ),
              pw.SizedBox(height: 10),
              pw.Divider(),
              pw.SizedBox(height: 10),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Row(
                        children: [
                          pw.Text('دج $price'),
                          pw.Text('TOTAL HT: ',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        ],
                      ),
                      pw.Row(
                        children: [
                          pw.Text('دج 0.00'),
                          pw.Text('TVA: ',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        ],
                      ),
                      pw.Row(
                        children: [
                          pw.Text('دج $price'),
                          pw.Text('TOTAL: ',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        ],
                      ),
                      pw.Row(
                        children: [
                          pw.Text('دج $debt'),
                          pw.Text('DEBT: ',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Container(
                padding: const pw.EdgeInsets.all(10),
                decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.grey)),
                child: pw.Text(
                  'شكرا جزيلا لتعاملكم معنا، وكالة أنوار الصباح السياحية تتمنى لكم يوم سعيد',
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(fontSize: 12),
                ),
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}
