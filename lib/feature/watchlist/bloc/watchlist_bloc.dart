import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/feature/watchlist/data/models/company_stock_details.dart';
import 'package:test_app/feature/watchlist/repository/watchlist_repository.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchListState> {
  WatchlistBloc() : super(WatchListInitialState()) {
    void fetchInitialData(event, emit) {
      emit(InitialDataFetchLoadingState());
      List<CompanyStockDetails> companyStockDetailsList =
          WatchlistRepository.fetchCompanyDetails();
      emit(
        InitialDataFetchSuccessState(
          companyStockDetailsList: companyStockDetailsList,
          filteredList: companyStockDetailsList,
        ),
      );
    }

    on<InitialDataFetchEvent>(fetchInitialData);

    void filterSearchedData(event, emit) {
      if (state is InitialDataFetchSuccessState) {
        final currentState = state as InitialDataFetchSuccessState;
        final companyStockDetailsList = currentState
            .companyStockDetailsList; // full original data (store this in state)

        final filteredList = companyStockDetailsList
            .where(
              (item) => item.companyName!.toLowerCase().contains(
                event.query.toLowerCase(),
              ),
            )
            .toList();

        emit(
          InitialDataFetchSuccessState(
            companyStockDetailsList: companyStockDetailsList,
            filteredList: filteredList,
          ),
        );
      }
    }

    on<OnSearchEvent>(filterSearchedData);
  }
}
