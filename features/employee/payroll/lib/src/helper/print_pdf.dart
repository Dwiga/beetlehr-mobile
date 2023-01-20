import 'dart:typed_data';

import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:files/files.dart';
import 'package:preferences/preferences.dart';

import '../../payroll.dart';

class PayrollHelper {
  final PayrollDetailEntity payroll;

  PayrollHelper(this.payroll);

  Future<void> print() async {
    var result = await _buildPdf(PdfPageFormat.a4);

    final datePaidOn = payroll.paidOn != null
        ? DateFormat('y_M_d').format(payroll.paidOn!)
        : '';

    var fileName = 'Slip_Gaji'
        '${datePaidOn.isNotEmpty ? '_' : ''}$datePaidOn'
        '.pdf';

    GetIt.I<SaveFileDownloadFolderUseCase>().call(SaveFileDownloadFolderParams(
      result,
      fileName: fileName,
      openOnSuccess: true,
    ));
  }

  final PdfColor baseColor = PdfColors.blue800;

  Future<Uint8List> _buildPdf(PdfPageFormat pageFormat) async {
    // Create a PDF document.
    final doc = pw.Document();

    final _logo = pw.MemoryImage((await rootBundle
            .load(GetIt.I<GlobalConfiguration>().getValue('company_logo')))
        .buffer
        .asUint8List());

    // Add page to the PDF
    doc.addPage(
      pw.MultiPage(
        pageTheme: _buildTheme(pageFormat),
        build: (context) => [
          _contentHeader(context, _logo),
          pw.SizedBox(height: 16),
          _contentTableEarning(context),
          pw.SizedBox(height: 16),
          _contentTableDeduction(context),
          pw.SizedBox(height: 4),
          _buildPolicyInformation(),
          pw.SizedBox(height: 24),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              _contentFooter(context),
              _buildQRCode(context),
            ],
          ),
        ],
      ),
    );

    // Return the PDF file content
    return doc.save();
  }

  pw.PageTheme _buildTheme(PdfPageFormat pageFormat) {
    return pw.PageTheme(
      pageFormat: pageFormat,
    );
  }

  pw.Widget _contentHeader(pw.Context context, pw.MemoryImage image) {
    return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Row(
                children: [
                  pw.Image(image, width: 75, height: 75),
                  pw.SizedBox(width: Dimens.dp16),
                  pw.Text(
                    GetIt.I<GlobalConfiguration>()
                        .getValue('company_name')
                        .toString()
                        .toUpperCase(),
                    maxLines: 2,
                    style: pw.TextStyle(
                      fontSize: Dimens.dp24,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: Dimens.dp16),
          pw.Center(
            child: pw.Text(
              'SLIP GAJI',
              style: pw.TextStyle(
                fontSize: Dimens.dp24,
                decoration: pw.TextDecoration.underline,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
          pw.SizedBox(height: Dimens.dp16),
          _buildUserData(),
        ]);
  }

  pw.Widget _buildUserData() {
    var payrollStatus = PayrollStatusConverter.convertToString(payroll.status);
    var paidOn = payroll.paidOn != null
        ? DateFormat.yMMMEd().format(payroll.paidOn!).toString()
        : '';
    return pw.Row(
      children: [
        pw.Container(
            width: 60,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Name',
                  style: const pw.TextStyle(
                    fontSize: Dimens.dp10,
                  ),
                ),
                pw.SizedBox(height: 2),
                pw.Text(
                  'Designation',
                  style: const pw.TextStyle(
                    fontSize: Dimens.dp10,
                  ),
                ),
                pw.SizedBox(height: 2),
                pw.Text(
                  'Paid On',
                  style: const pw.TextStyle(
                    fontSize: Dimens.dp10,
                  ),
                ),
                pw.SizedBox(height: 2),
                pw.Text(
                  'Status',
                  style: const pw.TextStyle(
                    fontSize: Dimens.dp10,
                  ),
                ),
              ],
            )),
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                ': ${payroll.name}',
                style: const pw.TextStyle(
                  fontSize: Dimens.dp10,
                ),
              ),
              pw.SizedBox(height: 2),
              pw.Text(
                ': ${payroll.designation}',
                style: const pw.TextStyle(
                  fontSize: Dimens.dp10,
                ),
              ),
              pw.SizedBox(height: 2),
              pw.Text(
                ': $paidOn',
                style: const pw.TextStyle(
                  fontSize: Dimens.dp10,
                ),
              ),
              pw.SizedBox(height: 2),
              pw.Text(
                ': ${payrollStatus ?? ''}',
                style: const pw.TextStyle(
                  fontSize: Dimens.dp10,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget _buildPolicyInformation() {
    return pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
      pw.Text('*', style: const pw.TextStyle(color: PdfColors.red)),
      pw.SizedBox(width: 4),
      pw.Expanded(
        child: pw.Text(
          'Sesuai ketentuan perusahaan, slip gaji ini telah ditandatangani '
          'secara elektronik sehingga tidak diperlukan tanda '
          'tangan basah pada slip gaji ini.',
          style: const pw.TextStyle(fontSize: 8),
        ),
      ),
    ]);
  }

  pw.Widget _contentFooter(pw.Context context) {
    return pw.Center(
        child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Take Home Pay: ',
          style: const pw.TextStyle(color: PdfColors.blue800, fontSize: 12),
        ),
        pw.SizedBox(height: 4),
        pw.Text(Utils.rupiahFormatter(_getTakeHomePay()) ?? '',
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(fontSize: 26, fontWeight: pw.FontWeight.bold)),
      ],
    ));
  }

  pw.Widget _buildQRCode(pw.Context context) {
    return pw.BarcodeWidget(
      data: payroll.publicUrl,
      width: 60,
      height: 60,
      barcode: pw.Barcode.qrCode(),
      drawText: false,
    );
  }

  double _getTakeHomePay() {
    if (payroll.totalAmountAfterPinalty != null) {
      return payroll.totalAmountAfterPinalty ?? 0;
    }
    return payroll.totalAmount;
  }

  pw.Widget _contentTableEarning(pw.Context context) {
    const tableHeaders = [
      'Name',
      'Amount',
    ];

    return pw.Column(children: [
      pw.Table.fromTextArray(
        border: null,
        cellAlignment: pw.Alignment.centerLeft,
        cellPadding: const pw.EdgeInsets.all(6),
        headerDecoration: pw.BoxDecoration(
          borderRadius: const pw.BorderRadius.all(pw.Radius.circular(2)),
          color: baseColor,
        ),
        headerHeight: 25,
        columnWidths: const {
          0: pw.FlexColumnWidth(5),
          1: pw.FlexColumnWidth(2),
        },
        cellAlignments: {
          0: pw.Alignment.centerLeft,
          1: pw.Alignment.centerLeft,
        },
        headerStyle: pw.TextStyle(
          fontSize: Dimens.dp10,
          fontWeight: pw.FontWeight.bold,
          color: PdfColors.white,
        ),
        cellStyle: const pw.TextStyle(
          fontSize: Dimens.dp10,
        ),
        rowDecoration: const pw.BoxDecoration(
          border: pw.Border(
            bottom: pw.BorderSide(
              color: PdfColors.grey300,
              width: .5,
            ),
          ),
        ),
        headers: List<String>.generate(
          tableHeaders.length,
          (col) => tableHeaders[col],
        ),
        data: List<List<String>>.generate(
          payroll.earnings.length,
          (row) {
            return [
              payroll.earnings[row].name,
              Utils.rupiahFormatter(payroll.earnings[row].amount) ?? '',
            ];
          },
        ),
      ),
      pw.SizedBox(height: 8),
      _buildBoldComponent(
          'Total Earning', Utils.rupiahFormatter(payroll.totalEarning) ?? ''),
    ]);
  }

  pw.Widget _contentTableDeduction(pw.Context context) {
    const tableHeaders = [
      'Name',
      'Amount',
    ];

    return pw.Column(children: [
      pw.Table.fromTextArray(
        border: null,
        cellAlignment: pw.Alignment.centerLeft,
        cellPadding: const pw.EdgeInsets.all(6),
        headerDecoration: pw.BoxDecoration(
          borderRadius: const pw.BorderRadius.all(pw.Radius.circular(2)),
          color: baseColor,
        ),
        headerHeight: 25,
        cellAlignments: {
          0: pw.Alignment.centerLeft,
          1: pw.Alignment.centerLeft,
        },
        columnWidths: const {
          0: pw.FlexColumnWidth(5),
          1: pw.FlexColumnWidth(2),
        },
        headerStyle: pw.TextStyle(
          fontSize: Dimens.dp10,
          fontWeight: pw.FontWeight.bold,
          color: PdfColors.white,
        ),
        cellStyle: const pw.TextStyle(
          fontSize: Dimens.dp10,
        ),
        rowDecoration: const pw.BoxDecoration(
          border: pw.Border(
            bottom: pw.BorderSide(
              color: PdfColors.grey300,
              width: .5,
            ),
          ),
        ),
        headers: List<String>.generate(
          tableHeaders.length,
          (col) => tableHeaders[col],
        ),
        data: List<List<String>>.generate(
          payroll.deductions?.length ?? 0,
          (row) {
            return [
              payroll.deductions?[row].name ?? '',
              Utils.rupiahFormatter(payroll.deductions?[row].amount) ?? '',
            ];
          },
        ),
      ),
      pw.SizedBox(height: 8),
      _buildBoldComponent('Total Deduction',
          Utils.rupiahFormatter(payroll.totalDeduction) ?? ''),
      pw.SizedBox(height: 8),
      payroll.resignPinaltyAmount != null
          ? _buildBoldComponent('Total Resign Pinalities',
              Utils.rupiahFormatter(payroll.resignPinaltyAmount) ?? '')
          : pw.SizedBox(),
    ]);
  }

  pw.Widget _buildBoldComponent(String title, String value) {
    return pw.Row(children: [
      pw.SizedBox(width: Dimens.dp10),
      pw.Expanded(
        flex: 5,
        child: pw.Text(
          title,
          style: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
          ),
        ),
      ),
      pw.Expanded(
        flex: 2,
        child: pw.Text(
          value,
          style: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    ]);
  }
}
