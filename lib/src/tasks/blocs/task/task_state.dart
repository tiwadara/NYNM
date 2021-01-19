part of 'task_bloc.dart';

@immutable
abstract class TaskState extends Equatable {
  const TaskState();
}

class InitialTaskState extends TaskState {
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
  @override
  List<Object> get props => [];
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
class TaskErrorState extends TaskState {
  final String error;
  TaskErrorState(this.error);
  @override
  List<Object> get props => [error];
}
