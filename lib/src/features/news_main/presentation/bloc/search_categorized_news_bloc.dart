import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/src/core/failures.dart';
import 'package:news_app/src/features/news_main/domain/entities/news_entities.dart';
import 'package:news_app/src/features/news_main/domain/usecases/search_categorized_news_usecase.dart';
import 'package:news_app/src/features/news_main/presentation/bloc/get_categorized_news_bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'search_categorized_news_event.dart';
part 'search_categorized_news_state.dart';

class SearchCategorizedNewsBloc
    extends Bloc<SearchCategorizedNewsEvent, SearchCategorizedNewsState> {
  final SearchCategorizedNewsUsecase usecase;

  SearchCategorizedNewsBloc(this.usecase)
      : super(const SearchCategorizedNewsState()) {
    on<SearchCategorizedNews>(
      (event, emit) async {
        emit(
          state.copyWith(
            status: () => CategorizedNewsState.loading,
            message: () => 'Loading',
          ),
        );

        final category = event.category;
        final query = event.query;
        final result = await usecase.execute(category, query);

        result.match(
          (failure) => emit(
            state.copyWith(
              status: () => CategorizedNewsState.error,
              message: () => errorToString(failure),
            ),
          ),
          (data) => emit(
            state.copyWith(
              status: () => CategorizedNewsState.loaded,
              message: () => 'Loaded',
              data: () => data,
            ),
          ),
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );

    on<SortSearchedNews>(
      (event, emit) {
        emit(
          state.copyWith(
            status: () => CategorizedNewsState.loading,
            message: () => 'Loading',
          ),
        );

        final currentData = state.data;

        if (currentData == null) {
          emit(
            state.copyWith(
              status: () => CategorizedNewsState.loaded,
              data: () => state.data,
              message: () => 'Loaded',
            ),
          );
          return;
        }

        if (!event.isLatest) {
          currentData.articles
              .sort((a, b) => a.publishedAt.compareTo(b.publishedAt));
          emit(
            state.copyWith(
              status: () => CategorizedNewsState.loaded,
              data: () => currentData,
              message: () => 'Loaded',
            ),
          );
          return;
        }

        currentData.articles
            .sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
        emit(
          state.copyWith(
            status: () => CategorizedNewsState.loaded,
            data: () => currentData,
            message: () => 'Loaded',
          ),
        );
      },
    );
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
