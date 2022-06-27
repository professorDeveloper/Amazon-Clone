import 'package:flutter/material.dart';

import '../../../common/widgets/widgets.dart';
import '../model/sales.dart';
import '../service/admin_services.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../widgets/category_products_chart.dart';
class AnaltyicsScreenState extends StatefulWidget {
  const AnaltyicsScreenState({Key? key}) : super(key: key);

  @override
  State<AnaltyicsScreenState> createState() => _AnaltyicsScreenStateState();
}

class _AnaltyicsScreenStateState extends State<AnaltyicsScreenState> {
  final AdminServices adminServices = AdminServices();
  int? totalSales;
  List<Sales>? earnings;

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  getEarnings() async {
    var earningData = await adminServices.getEarnings(context);
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales == null
        ? const Loader()
        : Column(
      children: [
        Text(
          '\$$totalSales',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 250,
          child: CategoryProductsChart(seriesList: [
            charts.Series(
              id: 'Sales',
              data: earnings!,
              domainFn: (Sales sales, _) => sales.label,
              measureFn: (Sales sales, _) => sales.earning,
            ),
          ]),
        )
      ],
    );
    ;
  }
}
