import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/feature/watchlist/bloc/watchlist_bloc.dart';
import 'package:test_app/feature/watchlist/data/models/company_stock_details.dart';
import 'package:test_app/feature/watchlist/ui/company_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // List<CompanyStockDetails> companyStockDetailsList = [];
  List<CompanyStockDetails> filteredData = [];

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    final state = context.watch<WatchlistBloc>().state;
    if (state is InitialDataFetchSuccessState) {
      filteredData = state.filteredList;
    }
    // filteredData = [...companyStockDetailsList].toList();
    super.didChangeDependencies();
  }

  // void filterData(String searchText) {
  //   if (searchText == "") {
  //     filteredData = [];
  //     filteredData = [...companyStockDetailsList].toList();
  //   } else {
  //     filteredData = [];
  //     companyStockDetailsList.map((e) {
  //       if (e.companyName!.toLowerCase().contains(searchText.toLowerCase())) {
  //         filteredData.add(e);
  //       }
  //     }).toList();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search List")),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.05,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(8),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(flex: 1, child: Icon(Icons.search)),
                Expanded(
                  flex: 4,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search and Add Scripts",
                      hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                    ),
                    onChanged: (value) {
                      // filterData(value);
                      context.read<WatchlistBloc>().add(OnSearchEvent(value));
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredData.length,
              itemBuilder: (context, index) {
                return CompanyCard(companyStockDetails: filteredData[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
