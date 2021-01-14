part of '../../../tasks/blocs/todo/to_do_bloc.dart';

@immutable
abstract class ToDoState extends Equatable {
  const ToDoState();
}

class InitialResolutionState extends ToDoState {
  @override
  List<Object> get props => [];
}

class SavingResolution extends ToDoState {
  @override
  List<Object> get props => [];
}

class LoadingResolution extends ToDoState {
  @override
  List<Object> get props => [];
}

class UpdatingResolution extends ToDoState {
  @override
  List<Object> get props => [];
}

@immutable
class ResolutionSaved extends ToDoState {
  final Task resolution;
  ResolutionSaved(this.resolution);
  @override
  List<Object> get props => [resolution];
}

@immutable
class ResolutionUpdated extends ToDoState {
  final Task resolution;
  ResolutionUpdated(this.resolution);
  @override
  List<Object> get props => [resolution];
}

@immutable
class ResolutionsReceived extends ToDoState {
  final List<Task> resolutions;
  ResolutionsReceived(this.resolutions);
  @override
  List<Object> get props => [resolutions];
}

@immutable
class ErrorWithMessageState extends ToDoState {
  final String error;
  ErrorWithMessageState(this.error);
  @override
  List<Object> get props => [error];
}
