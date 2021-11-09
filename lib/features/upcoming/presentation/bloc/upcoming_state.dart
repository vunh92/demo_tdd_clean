import 'package:demo_tdd_clean/features/upcoming/domain/entities/upcoming.dart';
import 'package:equatable/equatable.dart';

abstract class UpcomingState extends Equatable {
  // final bool isLoading;
  // final List<Upcoming> upcomingList;
  //
  // UpcomingState({this.isLoading, this.upcomingList});

  @override
  List<Object> get props => [];
  // List<Object> get props => [isLoading, upcomingList];

}

class EmptyState extends UpcomingState {}

class LoadingState extends UpcomingState {}

class LoadedState extends UpcomingState {
  final List<Upcoming> upcomingList;
  LoadedState({this.upcomingList});

  @override
  List<Object> get props => [upcomingList];
}

class ErrorState extends UpcomingState {
  final String message;

  ErrorState({this.message});

  @override
  List<Object> get props => [message];
}