import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/src/core/failures.dart';
import 'package:news_app/src/features/news_main/domain/entities/news_entities.dart';
import 'package:news_app/src/features/news_main/domain/usecases/get_categorized_news_usecase.dart';

part 'get_categorized_news_event.dart';
part 'get_categorized_news_state.dart';

class GetCategorizedNewsBloc
    extends Bloc<GetCategorizedNewsEvent, GetCategorizedNewsState> {
  final GetCategorizedNewsUsecase usecase;

  GetCategorizedNewsBloc(this.usecase)
      : super(const GetCategorizedNewsState()) {
    on<GetCategorizedNews>((event, emit) async {
      emit(state.copyWith(
        status: () => CategorizedNewsState.loading,
        message: () => 'Loading',
      ));

      final category = event.category;
      final result = await usecase.execute(category);

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
            data: () => data,
            message: () => 'Loaded',
          ),
        ),
      );
    });
  }
}
