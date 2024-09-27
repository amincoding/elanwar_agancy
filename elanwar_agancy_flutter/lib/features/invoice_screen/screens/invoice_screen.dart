import 'dart:typed_data';
import 'package:elanwar_agancy_client/elanwar_agancy_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:elanwar_agancy_flutter/features/dashboard/main_screen/providers/get_all_reservations_provider.dart';

class InvoiceScreen extends ConsumerWidget {
  final int clientId;

  const InvoiceScreen({super.key, required this.clientId});

  // Define a route method to generate the correct path
  static String route(int clientId) => "/invoice/$clientId";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Access the reservations from Riverpod provider
    final reservations = ref.read(getAllReservationsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice for Client $clientId'),
      ),
      body: Column(
        children: [
          // Display the invoice PDF in a small window
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: PdfPreview(
                build: (format) => generateInvoicePdf(
                    reservations, clientId), // Generates the PDF
                allowPrinting: false, // Disable the default print button
              ),
            ),
          ),
          SizedBox(height: 20),
          // Action buttons: Print, Email, Cancel
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton.icon(
                onPressed: () => _printPdf(reservations, clientId),
                icon: Icon(Icons.print),
                label: Text('Print'),
              ),
              ElevatedButton.icon(
                onPressed: () => _emailPdf(),
                icon: Icon(Icons.email),
                label: Text('Email'),
              ),
              ElevatedButton.icon(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.cancel),
                label: Text('Cancel'),
                style: ElevatedButton.styleFrom(foregroundColor: Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _printPdf(List<Reservation?> reservations, int clientId) async {
    final pdfBytes = await generateInvoicePdf(reservations, clientId);
    await Printing.layoutPdf(onLayout: (format) => pdfBytes);
  }

  void _emailPdf() {
    // Add logic to send email with PDF attachment.
  }

  Future<Uint8List> generateInvoicePdf(reservations, clientId) async {
    final pdf = pw.Document();
    var arabicFont =
        pw.Font.ttf(await rootBundle.load("assets/fonts/Hacen-Tunisia.ttf"));

    // Define your invoice layout
    pdf.addPage(
      pw.Page(
        theme: pw.ThemeData.withFont(
          base: arabicFont,
        ),
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Logo and Invoice Header
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'LuxuryStore',
                        style: pw.TextStyle(
                          fontSize: 24,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text('6146 Honey Bluff Parkway'),
                      pw.Text('Calder, Michigan, 49628-7978'),
                      pw.Text('United States'),
                    ],
                  ),
                  pw.BarcodeWidget(
                    data: '6000000001',
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
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('INVOICE NUMBER',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('#6000000001'),
                      pw.Text('ORDER'),
                      pw.Text('#6000000001'),
                      pw.Text('ORDER DATE'),
                      pw.Text('Dec 14, 2020, 4:18:34 PM'),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 20),
              // Billed To Section
              pw.Container(
                decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.grey)),
                padding: const pw.EdgeInsets.all(10),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('BILLED TO',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        pw.Text('Customer Name: Veronica Costello'),
                        pw.Text('Address: 6146 Honey Bluff Parkway'),
                        pw.Text('Calder, Michigan, 49628-7978'),
                        pw.Text('United States'),
                        pw.Text('T: (555) 229-3326'),
                      ],
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('PAYMENT & SHIPPING',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        pw.Text('Shipping Method: Flat Rate - Fixed'),
                        pw.Text('Payment Method: Check / Money order'),
                      ],
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 20),

              // Itemized Table
              pw.TableHelper.fromTextArray(
                headers: [
                  'إسم الفندق',
                  'Room number',
                  'Resirvation start',
                  'Resirvation end',
                  'Amount',
                  'Payed',
                  'Debt ',
                ],
                cellAlignment: pw.Alignment.centerLeft,
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                cellStyle: pw.TextStyle(fontSize: 12),
                data: [
                  ['Luma Analog Watch', '1', '\$43.00'],
                  ['Fusion Backpack', '1', '\$50.00'],
                ],
              ),
              pw.SizedBox(height: 10),
              pw.Divider(),
              pw.SizedBox(height: 10),
              // Subtotal, Shipping, Tax, and Grand Total
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Row(
                        children: [
                          pw.Text('SUBTOTAL: ',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                          pw.Text('\$93.00'),
                        ],
                      ),
                      pw.Row(
                        children: [
                          pw.Text('SHIPPING & HANDLING: ',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                          pw.Text('\$10.00'),
                        ],
                      ),
                      pw.Row(
                        children: [
                          pw.Text('TAX: ',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                          pw.Text('\$7.67'),
                        ],
                      ),
                      pw.Row(
                        children: [
                          pw.Text('GRAND TOTAL: ',
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColors.red)),
                          pw.Text('\$110.67',
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColors.red)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 20),
              // Thank you note
              pw.Container(
                padding: const pw.EdgeInsets.all(10),
                decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.grey)),
                child: pw.Text(
                  'THANK YOU FOR YOUR ORDER!\nIf you have questions about your order, you can email us at support@example.com.',
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
