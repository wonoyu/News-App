part of 'get_categorized_news_bloc.dart';

enum CategorizedNewsState { initial, loading, loaded, error }

class GetCategorizedNewsState extends Equatable {
  const GetCategorizedNewsState(
      {this.status = CategorizedNewsState.initial,
      this.data,
      this.message = 'NoData'});

  final CategorizedNewsState status;
  final NewsResponseEntity? data;
  final String message;

  GetCategorizedNewsState copyWith({
    CategorizedNewsState Function()? status,
    NewsResponseEntity? Function()? data,
    String Function()? message,
  }) {
    return GetCategorizedNewsState(
      status: status != null ? status() : this.status,
      data: data != null ? data() : this.data,
      message: message != null ? message() : this.message,
    );
  }

  @override
  List<Object?> get props => [status, data, message];
}
