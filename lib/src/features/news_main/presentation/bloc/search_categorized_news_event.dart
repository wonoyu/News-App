part of 'search_categorized_news_bloc.dart';

abstract class SearchCategorizedNewsEvent extends Equatable {
  const SearchCategorizedNewsEvent();

  @override
  List<Object> get props => [];
}

class SearchCategorizedNews extends SearchCategorizedNewsEvent {
  const SearchCategorizedNews(this.category, this.query);

  final String category;
  final String query;

  @override
  List<Object> get props => [category, query];
}
