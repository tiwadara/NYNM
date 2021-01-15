import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:resolution/src/commons/constants/app_strings.dart';
import 'package:resolution/src/tasks/models/task.dart';
import 'package:resolution/src/tasks/services/task_service.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskService taskService;

  TaskBloc(this.taskService) : super(InitialResolutionState());

  TaskState get initialState => InitialResolutionState();

  @override
  Stream<TaskState> mapEventToState(TaskEvent event) async* {
    if (event is SaveTask) {
      yield SavingTask();
      Task response = await taskService.saveTask(event.task, event.year);
      if (response != null) {
        yield TaskSaved();
      } else {
        yield ErrorWithMessageState(AppStringConstants.saveFailed);
      }
    } else if (event is GetTasks) {
      yield LoadingTasks();
      try {
        var response = await taskService.getAllTasks(event.year);
        if (response != null) {
          yield TaskListReceived(response, event.year);
        } else {
          yield ErrorWithMessageState(AppStringConstants.gettingFailed);
        }
      } catch (e) {
        yield ErrorWithMessageState(AppStringConstants.gettingFailed);
      }
    } else if (event is UpdateTaskStatus) {
      yield UpdatingResolution();
      Task response = await taskService.updateTask(
          event.resolution, event.year, event.index);
      if (response is Task) {
        yield TaskUpdated(response);
      } else {
        yield ErrorWithMessageState(AppStringConstants.saveFailed);
      }
    }
  }

  Future<int> getTaskCount(int year) async {
    List tasks = await taskService.getAllTasks(year);
    return tasks.length;
  }
}
