class CompanyStockDetails {
  String? companyName;
  double? stockValue;
  double? stockValueChange;
  double? changePercentage;
  String? nseValue1;
  String? nseValue2;

  CompanyStockDetails({
    this.changePercentage,
    this.companyName,
    this.nseValue1,
    this.nseValue2,
    this.stockValue,
    this.stockValueChange,
  });

  CompanyStockDetails.fromJson(Map<String, dynamic> data) {
    companyName = data["company_name"];
    stockValue = data["current_stock_value"];
    stockValueChange = data["stock_value_change"];
    changePercentage = data["stock_value_percentage"];
    nseValue1 = data["nse_value1"];
    nseValue2 = data["nse_value2"];
  }
}
