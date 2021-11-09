import 'package:dartz/dartz.dart';
import 'package:demo_tdd_clean/core/error/failures.dart';
import 'package:demo_tdd_clean/core/usecases/usecase.dart';
import 'package:demo_tdd_clean/core/util/input_converter.dart';
import 'package:demo_tdd_clean/features/upcoming/domain/entities/upcoming.dart';
import 'package:demo_tdd_clean/features/upcoming/domain/usecases/get_upcoming.dart';
import 'package:demo_tdd_clean/features/upcoming/domain/usecases/get_upcoming_id.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE = 'Invalid Input - The number must be a positive integer or zero.';

class UpcomingBloc extends Bloc<UpcomingEvent, UpcomingState> {
  final GetUpcomingId getUpcomingId;
  final GetUpcoming getUpcoming;
  final InputConverter inputConverter;

  UpcomingBloc({this.getUpcoming, this.getUpcomingId, this.inputConverter, });

  @override
  UpcomingState get initialState => EmptyState();
  // UpcomingState get initialState => LoadingState(isLoading: true);

  @override
  Stream<UpcomingState> mapEventToState(UpcomingEvent event) async* {
    if (event is UpcomingIdLoadDataEvent) {
      final inputEither = inputConverter.stringToUnsignedInteger(event.numberString);
      yield* inputEither.fold(
            (failure) async* {
          yield ErrorState(message: INVALID_INPUT_FAILURE_MESSAGE);
        },
            (integer) async* {
          yield LoadingState();
          final failureOrTrivia = await getUpcomingId(Params(number: integer));
          yield* _eitherLoadedOrErrorState(failureOrTrivia);
        },
      );
    }
    if (event is UpcomingLoadDataEvent) {
      yield LoadingState();
      final failureOrTrivia = await getUpcoming(NoParams());
      yield* _eitherLoadedOrErrorState(failureOrTrivia);
    }
  }

  Stream<UpcomingState> _eitherLoadedOrErrorState(
      Either<Failure, List<Upcoming>> failureOrUpcoming,
      ) async* {
    yield failureOrUpcoming.fold(
          (failure) => ErrorState(message: _mapFailureToMessage(failure)),
          (upcoming) => LoadedState(upcomingList: upcoming),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }

}