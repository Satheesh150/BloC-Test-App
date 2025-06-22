part of 'watchlist_bloc.dart';

@immutable
abstract class WatchlistEvent {}

class InitialDataFetchEvent extends WatchlistEvent {}

class OnSearchEvent extends WatchlistEvent {
  final String query;
  OnSearchEvent(this.query);
}
