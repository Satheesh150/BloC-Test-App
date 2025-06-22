part of 'watchlist_bloc.dart';

@immutable
abstract class WatchListState {}

class WatchListInitialState extends WatchListState {}

class InitialDataFetchLoadingState extends WatchListState {}

class InitialDataFetchSuccessState extends WatchListState {
  final List<CompanyStockDetails> companyStockDetailsList;
  final List<CompanyStockDetails> filteredList;

  InitialDataFetchSuccessState({
    required this.companyStockDetailsList,
    required this.filteredList,
  });
}

class InitialDataFetchErrorState extends WatchlistEvent {}
