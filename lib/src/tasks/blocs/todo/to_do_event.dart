part of '../../../tasks/blocs/todo/to_do_bloc.dart';

@immutable
abstract class ToDoEvent extends Equatable {
  const ToDoEvent();
}

@immutable
class SaveResolution extends ToDoEvent {
  final Task resolution;

  SaveResolution(this.resolution);
  @override
  List<Object> get props => [resolution];
}

@immutable
class UpdateResolutionStatus extends ToDoEvent {
  final Task resolution;
  final int index;

  UpdateResolutionStatus(this.resolution, this.index);
  @override
  List<Object> get props => [resolution, index];
}

@immutable
class GetResolutions extends ToDoEvent {
  @override
  List<Object> get props => [];
}
