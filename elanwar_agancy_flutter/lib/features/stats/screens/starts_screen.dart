import 'package:elanwar_agancy_flutter/features/stats/providers/stats_provider.dart';
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

    bool isLoading() {
      return [maxPrice].every((data) => data != null);
    }

    // If any provider is still loading, show a progress indicator
    if (!isLoading()) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Once data is loaded, show the normal UI
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.1,
                right: MediaQuery.of(context).size.width * 0.1),
            child: SfCartesianChart(
              title: const ChartTitle(text: "مداخيل السنة مقابل الشهر"),
              primaryXAxis: DateTimeAxis(
                minimum: DateTime(DateTime.january),
                maximum: DateTime(DateTime.december),
              ),
              primaryYAxis: NumericAxis(
                minimum: 0,
                maximum: maxPrice!.totalPrice,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
