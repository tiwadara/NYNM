part of 'task_bloc.dart';

@immutable
abstract class TaskState extends Equatable {
  const TaskState();
}

class InitialResolutionState extends TaskState {
  @override
  List<Object> get props => [];
}

class SavingTask extends TaskState {
  @override
  List<Object> get props => [];
}

class LoadingTasks extends TaskState {
  @override
  List<Object> get props => [];
}

class UpdatingResolution extends TaskState {
  @override
  List<Object> get props => [];
}

@immutable
class TaskSaved extends TaskState {
  @override
  List<Object> get props => [];
}

@immutable
class TaskUpdated extends TaskState {
  final Task task;
  TaskUpdated(this.task);
  @override
  List<Object> get props => [task];
}

@immutable
class TaskListReceived extends TaskState {
  final List<dynamic> tasks;
  final int year;
  TaskListReceived(this.tasks, this.year);
  @override
  List<Object> get props => [tasks, year];
}

@immutable
class ErrorWithMessageState extends TaskState {
  final String error;
  ErrorWithMessageState(this.error);
  @override
  List<Object> get props => [error];
}
