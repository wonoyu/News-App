part of 'search_categorized_news_bloc.dart';

class SearchCategorizedNewsState extends Equatable {
  const SearchCategorizedNewsState(
      {this.status = CategorizedNewsState.initial,
      this.data,
      this.message = 'NoData'});

  final CategorizedNewsState status;
  final NewsResponseEntity? data;
  final String message;

  SearchCategorizedNewsState copyWith({
    CategorizedNewsState Function()? status,
    NewsResponseEntity? Function()? data,
    String Function()? message,
  }) {
    return SearchCategorizedNewsState(
      status: status != null ? status() : this.status,
      data: data != null ? data() : this.data,
      message: message != null ? message() : this.message,
    );
  }

  @override
  List<Object?> get props => [status, data, message];
}
