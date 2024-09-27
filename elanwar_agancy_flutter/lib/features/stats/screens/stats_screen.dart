import 'dart:math';

import 'package:elanwar_agancy_client/elanwar_agancy_client.dart';
import 'package:elanwar_agancy_flutter/features/stats/providers/max_price_provider.dart';
import 'package:elanwar_agancy_flutter/features/stats/providers/total_debts_provider.dart';
import 'package:elanwar_agancy_flutter/features/stats/providers/total_money_provider.dart';
import 'package:elanwar_agancy_flutter/features/stats/providers/total_price_per_month_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StartsScreen extends ConsumerStatefulWidget {
  const StartsScreen({super.key});

  @override
  ConsumerState<StartsScreen> createState() => _StartsScreenState();
}

class _StartsScreenState extends ConsumerState<StartsScreen> {
  @override
  Widget build(BuildContext context) {
    // Fetch all required providers
    final maxPrice = ref.watch(maxPriceProvider);
    final totalPricePerMonth = ref.watch(totalPricePerMonthProvider);
    final totalDebts = ref.watch(totalDebtsProvider);
    final totalMoney = ref.watch(totalMoneyProvider);
    bool isLoading() {
      return [maxPrice, totalPricePerMonth, totalDebts, totalMoney]
          .every((data) => data != null);
    }

    // If any provider is still loading, show a progress indicator
    if (!isLoading()) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final List<IncomeData> data = totalPricePerMonth.entries.map((entry) {
      final month = entry.key; // Month number (1 for January, etc.)
      final totalPrice = entry.value; // Total price for that month
      return IncomeData(
        DateTime(DateTime.now().year, month), // Create DateTime using the month
        totalPrice, // Total price for the month
      );
    }).toList();

    // Once data is loaded, show the normal UI
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                ref.refresh(maxPriceProvider);
                ref.refresh(totalPricePerMonthProvider);
                ref.refresh(totalDebtsProvider);
                ref.refresh(totalMoneyProvider);
              },
              child: const Text(
                "Refresh",
                style: TextStyle(color: Colors.black),
              )),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.1,
                right: MediaQuery.of(context).size.width * 0.1),
            child: SfCartesianChart(
              title: const ChartTitle(text: "مداخيل السنة بالشهر"),
              primaryXAxis: DateTimeAxis(
                minimum: DateTime(DateTime.now().year, 1),
                maximum: DateTime(DateTime.now().year, 12),
                intervalType: DateTimeIntervalType.months,
              ),
              primaryYAxis: NumericAxis(
                minimum: 0,
                maximum: data.isNotEmpty
                    ? data
                        .map((e) => e.totalPrice)
                        .reduce((a, b) => a > b ? a : b)
                    : 0, // Max value for Y-axis is the highest total price
              ),
              series: <ColumnSeries>[
                ColumnSeries<IncomeData, DateTime>(
                  width: 1,
                  dataSource: data, // The list of data points
                  xValueMapper: (IncomeData data, _) =>
                      data.createdDate, // X-axis: Date
                  yValueMapper: (IncomeData data, _) =>
                      data.totalPrice, // Y-axis: Total Price

                  // Adding animation effects
                  animationDuration: 3000, // Animation duration (2 seconds)
                  animationDelay: 500, // Delay before the animation starts

                  // Data label settings
                  dataLabelMapper: (datum, index) {
                    return "                  ${datum.totalPrice.toString()} دج";
                  },
                  dataLabelSettings: const DataLabelSettings(
                    isVisible: true, // Show labels
                    labelAlignment: ChartDataLabelAlignment
                        .auto, // Position labels at the top of points
                  ),

                  // Marker settings to show dots on the data points
                  markerSettings: const MarkerSettings(
                      isVisible: true, // Show markers on the line
                      shape: DataMarkerType.circle,
                      borderWidth: 5, // Width of the marker border
                      borderColor: Colors.blue),
                ),
              ],
            ),
          ),
          SfCircularChart(
            title: const ChartTitle(text: "المداخيل الكاملة مع الديون"),
            centerX: "50%",
            centerY: "50%",
            series: <CircularSeries>[
              RadialBarSeries<double, String>(
                dataSource: [totalMoney!, totalDebts!, totalMoney - totalDebts],
                dataLabelMapper: (datum, index) {
                  return "${datum} دج";
                },
                xValueMapper: (double value, _) =>
                    value.toString(), // Label for each segment
                yValueMapper: (double value, _) =>
                    value, // Value for each segment
                dataLabelSettings: const DataLabelSettings(
                  isVisible: true, // Show labels on the chart
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.05,
              color: const Color(0xff06aee0),
              child: const Center(
                  child: Text(
                "المجموع",
                style: TextStyle(color: Colors.white),
              )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.05,
              color: const Color(0xff315a74),
              child: const Center(
                  child: Text(
                "المدفوعات",
                style: TextStyle(color: Colors.white),
              )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.05,
              color: const Color(0xff6355c7),
              child: const Center(
                  child: Text(
                "الديون",
                style: TextStyle(color: Colors.white),
              )),
            ),
          )
        ],
      ),
    );
  }
}

class IncomeData {
  final DateTime createdDate;
  final double totalPrice;

  IncomeData(this.createdDate, this.totalPrice);
}
