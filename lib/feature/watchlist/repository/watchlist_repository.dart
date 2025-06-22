import 'package:test_app/feature/watchlist/data/mock_data.dart';
import 'package:test_app/feature/watchlist/data/models/company_stock_details.dart';

class WatchlistRepository {
  static List<CompanyStockDetails> fetchCompanyDetails() {
    List<CompanyStockDetails> companyStockDetailsList = [];
    try {
      listData["data"].map((e) {
        companyStockDetailsList.add(CompanyStockDetails.fromJson(e));
      }).toList();
      return companyStockDetailsList;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
