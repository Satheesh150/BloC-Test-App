import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/feature/watchlist/bloc/watchlist_bloc.dart';
import 'package:test_app/feature/watchlist/ui/search_screen.dart';
import 'package:test_app/feature/watchlist/data/mock_data.dart';
import 'package:test_app/feature/watchlist/data/models/company_stock_details.dart';
import 'package:test_app/feature/watchlist/data/models/tab_model.dart';
import 'package:test_app/feature/watchlist/ui/company_card.dart';

class WatchListScreen extends StatefulWidget {
  const WatchListScreen({super.key});

  @override
  State<WatchListScreen> createState() => _WatchListScreenState();
}

class _WatchListScreenState extends State<WatchListScreen>
    with SingleTickerProviderStateMixin {
  List<TabName> tabList = [];
  List<CompanyStockDetails> companyStockDetailsList = [];
  int selectedIndex = 0;
  int selectedBottomNavIndex = 0;

  @override
  void initState() {
    tabNameList["data"].map((e) {
      tabList.add(TabName.fromJson(e));
    }).toList();
    context.read<WatchlistBloc>().add(InitialDataFetchEvent());
    super.initState();
  }

  void onItemTapped(int index) {
    setState(() {
      selectedBottomNavIndex = index;
    });
  }

  void onTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabList.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text("WatchList", style: TextStyle(color: Colors.black)),
          actions: [Icon(Icons.push_pin_outlined, color: Colors.grey)],
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.green[50],
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.save), label: "Watchlist"),
            BottomNavigationBarItem(
              icon: Icon(Icons.car_crash),
              label: "Orders",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.travel_explore),
              label: "Portfolio",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.volume_down),
              label: "Mavers",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: "IOU007"),
          ],
          currentIndex: selectedBottomNavIndex,
          onTap: onItemTapped,
        ),
        body: Column(
          children: [
            TabBar(
              isScrollable: true,
              indicatorColor: Colors.green,
              dividerColor: Colors.transparent,
              tabAlignment: TabAlignment.start,
              onTap: onTapped,
              tabs: List.generate(tabList.length, (index) {
                return Tab(
                  child: Text(
                    tabList[index].name!,
                    style: TextStyle(
                      color: selectedIndex == index
                          ? Colors.green
                          : Colors.grey,
                    ),
                  ),
                );
              }),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ...tabList.map((e) {
                    return Column(
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
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SearchScreen(),
                                      ),
                                    );
                                  },
                                  child: TextField(
                                    enabled: false,
                                    decoration: InputDecoration(
                                      hintText: "Search and Add Scripts",
                                      hintStyle: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              VerticalDivider(color: Colors.grey, thickness: 2),
                              Expanded(flex: 1, child: Icon(Icons.apps)),
                              Expanded(flex: 1, child: Icon(Icons.tune)),
                            ],
                          ),
                        ),
                        BlocConsumer<WatchlistBloc, WatchListState>(
                          builder: (context, state) {
                            switch (state.runtimeType) {
                              // ignore: type_literal_in_constant_pattern
                              case InitialDataFetchLoadingState:
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              // ignore: type_literal_in_constant_pattern
                              case InitialDataFetchSuccessState:
                                final successState =
                                    state as InitialDataFetchSuccessState;
                                return Expanded(
                                  child: ListView.builder(
                                    itemBuilder: (context, index) {
                                      return CompanyCard(
                                        companyStockDetails: successState
                                            .companyStockDetailsList[index],
                                      );
                                    },
                                    itemCount: successState
                                        .companyStockDetailsList
                                        .length,
                                  ),
                                );
                              // ignore: type_literal_in_constant_pattern
                              case InitialDataFetchErrorState:
                                return Center(
                                  child: Text("Something went wrong"),
                                );
                              default:
                                return Container();
                            }
                          },
                          listener: (context, state) {},
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
