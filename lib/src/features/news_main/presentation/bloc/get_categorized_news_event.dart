part of 'get_categorized_news_bloc.dart';

abstract class GetCategorizedNewsEvent extends Equatable {
  const GetCategorizedNewsEvent();

  @override
  List<Object> get props => [];
}

class GetCategorizedNews extends GetCategorizedNewsEvent {
  const GetCategorizedNews(this.category);

  final String category;

  @override
  List<Object> get props => [category];
}
