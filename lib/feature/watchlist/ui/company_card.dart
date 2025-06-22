import 'package:flutter/material.dart';
import 'package:test_app/feature/watchlist/data/models/company_stock_details.dart';

class CompanyCard extends StatelessWidget {
  final CompanyStockDetails companyStockDetails;
  const CompanyCard({required this.companyStockDetails, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(flex: 3, child: Text(companyStockDetails.companyName!)),
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      companyStockDetails.changePercentage! > 0
                          ? Icons.arrow_upward
                          : Icons.arrow_downward,
                      color: companyStockDetails.changePercentage! > 0
                          ? Colors.green
                          : Colors.red,
                    ),
                    Text(
                      companyStockDetails.stockValue!.toString(),
                      style: TextStyle(
                        color: companyStockDetails.changePercentage! > 0
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Text(
                      "NSE",
                      style: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                    SizedBox(width: 5),
                    Text(
                      companyStockDetails.nseValue1.toString(),
                      style: TextStyle(color: Colors.green, fontSize: 10),
                    ),
                    SizedBox(width: 5),
                    Text(
                      companyStockDetails.nseValue2.toString(),
                      style: TextStyle(color: Colors.red, fontSize: 10),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      companyStockDetails.stockValueChange.toString(),
                      style: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                    SizedBox(width: 2),
                    Text(
                      "(${companyStockDetails.changePercentage})",
                      style: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
