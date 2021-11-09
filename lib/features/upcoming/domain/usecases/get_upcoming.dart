import 'package:dartz/dartz.dart';
import 'package:demo_tdd_clean/core/error/failures.dart';
import 'package:demo_tdd_clean/core/usecases/usecase.dart';
import 'package:demo_tdd_clean/features/upcoming/domain/entities/upcoming.dart';
import 'package:demo_tdd_clean/features/upcoming/domain/repositories/upcoming_repository.dart';

class GetUpcoming implements UseCase<List<Upcoming>, NoParams> {
  final UpcomingRepository repository;

  GetUpcoming(this.repository);

  @override
  Future<Either<Failure, List<Upcoming>>> call(NoParams params) async {
    return await repository.getConcreteUpcoming();
  }

}