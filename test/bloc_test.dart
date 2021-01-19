import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:resolution/src/commons/constants/app_strings.dart';
import 'package:resolution/src/resolutions/blocs/resolution/resolution_bloc.dart';
import 'package:resolution/src/resolutions/models/resolution.dart';
import 'package:resolution/src/resolutions/services/resolution_service.dart';
import 'package:resolution/src/tasks/blocs/task/task_bloc.dart';
import 'package:resolution/src/tasks/models/task.dart';
import 'package:resolution/src/tasks/services/task_service.dart';

import 'mocks.dart';

main() {
  group('ResolutionBloc Test -', () {
    ResolutionService resolutionService;
    ResolutionBloc resolutionBloc;

    setUp(() {
      resolutionService = MockResolutionService();
      resolutionBloc = ResolutionBloc(resolutionService);
    });

    tearDown(() {
      resolutionBloc?.close();
    });

    test('initial state is correct', () {
      expect(resolutionBloc.initialState, InitialResolutionState());
    });

    group('createResolution -', () {
      Resolution testResolution = Resolution();

      blocTest(
        'emits [SavingResolution, ResolutionSaved] when SaveResolution is added and saveResolution succeeds',
        build: () {
          when(resolutionService.saveResolution(testResolution)).thenAnswer(
            (_) => Future.value(testResolution),
          );
          return resolutionBloc;
        },
        act: (bloc) => bloc.add(SaveResolution(testResolution)),
        expect: [SavingResolution(), ResolutionSaved(testResolution)],
      );

      blocTest(
        'emits [SavingResolution, ResolutionErrorState] when SaveResolution is added and saveResolution fails',
        build: () {
          when(resolutionService.saveResolution(testResolution))
              .thenThrow((_) => Future.value("error string"));
          return resolutionBloc;
        },
        act: (bloc) => bloc.add(SaveResolution(testResolution)),
        expect: [
          SavingResolution(),
          ResolutionErrorState(AppStringConstants.saveFailed)
        ],
      );
      blocTest(
        'emits [LoadingResolution, ResolutionsReceived] when GetResolutions is added and getAllResolution succeeds',
        build: () {
          when(resolutionService.getAllResolution()).thenAnswer(
            (_) => Future.value(List<Resolution>.empty()),
          );
          return resolutionBloc;
        },
        act: (bloc) => bloc.add(GetResolutions()),
        expect: [
          LoadingResolution(),
          ResolutionsReceived(List<Resolution>.empty())
        ],
      );

      blocTest(
        'emits [LoadingResolution, ResolutionErrorState] when GetResolutions is added and getAllResolution fails',
        build: () {
          when(resolutionService.getAllResolution()).thenThrow(
            (_) => Future.value("error string "),
          );
          return resolutionBloc;
        },
        act: (bloc) => bloc.add(GetResolutions()),
        expect: [
          LoadingResolution(),
          ResolutionErrorState(AppStringConstants.saveFailed)
        ],
      );
    });
  });

  group('TaskBloc Test -', () {
    TaskService taskService;
    TaskBloc taskBloc;
    Task testTask = Task();
    int year = 2020;

    setUp(() {
      taskService = MockTaskService();
      taskBloc = TaskBloc(taskService);
      when(taskService.getAllTasks(year))
          .thenAnswer((_) => Future.value(List<Task>.empty(growable: true)));
      when(taskService.getTask(year,any)).thenAnswer((_) => Future.value(testTask));
    });

    tearDown(() {
      taskBloc?.close();
    });

    test('initial state is correct', () {
      expect(taskBloc.initialState, InitialTaskState());
    });

    group('createTask -', () {
      blocTest(
        'emits [SavingTask, TaskSaved] when SaveTask is added and saveTask succeeds',
        build: () {
          when(taskService.saveTask(testTask, year)).thenAnswer(
            (_) => Future.value(testTask),
          );
          return taskBloc;
        },
        act: (bloc) => bloc.add(SaveTask(testTask, year)),
        expect: [SavingTask(), TaskSaved()],
      );

      blocTest(
        'emits [SavingTask, TaskErrorState] when SaveTask is added and saveTask fails',
        build: () {
          when(taskService.saveTask(testTask, year))
              .thenAnswer((_) => Future.value(null));
          return taskBloc;
        },
        act: (bloc) => bloc.add(SaveTask(testTask, year)),
        expect: [SavingTask(), TaskErrorState(AppStringConstants.saveFailed)],
      );
    });

    group('getAllTasks -', () {
      blocTest(
        'emits [LoadingTasks, TaskListReceived] when GetTasks is added and getAllTasks succeeds',
        build: () {
          when(taskService.getAllTasks(year)).thenAnswer(
            (_) => Future.value(List<Task>.empty(growable: true)),
          );
          return taskBloc;
        },
        act: (bloc) => bloc.add(GetTasks(year)),
        expect: [
          LoadingTasks(),
          TaskListReceived(List<Task>.empty(growable: true), year)
        ],
      );

      blocTest(
        'emits [LoadingTasks, TaskListReceived] when GetTasks is added and getAllTask fails',
        build: () {
          when(taskService.getAllTasks(year))
              .thenAnswer((_) => Future.value(null));
          return taskBloc;
        },
        act: (bloc) => bloc.add(GetTasks(year)),
        expect: [
          LoadingTasks(),
          TaskErrorState(AppStringConstants.gettingFailed)
        ],
      );
    });

    group('updateTask -', () {
      blocTest(
        'emits [UpdateTaskStatus, TaskUpdated] when UpdateTaskStatus is added and updateTask succeeds',
        build: () {
          when(taskService.updateTask(testTask, year, any)).thenAnswer(
            (_) => Future.value(testTask),
          );
          return taskBloc;
        },
        act: (bloc) => bloc.add(UpdateTaskStatus(testTask, year, 1)),
        expect: [UpdatingResolution(), TaskUpdated()],
      );

      blocTest(
        'emits [UpdateTaskStatus, TaskErrorState] when UpdateTaskStatus is added and updateTask fails',
        build: () {
          when(taskService.updateTask(testTask, year, any))
              .thenAnswer((_) => Future.value(null));
          return taskBloc;
        },
        act: (bloc) => bloc.add(UpdateTaskStatus(testTask, year, 1)),
        expect: [
          UpdatingResolution(),
          TaskErrorState(AppStringConstants.saveFailed)
        ],
      );
    });

    group('testTaskBLocFunctions -', () {
      test('get task count', () async {
        var taskCount = await taskBloc.getTaskCount(year);
        expect(taskCount, [].length);
      });

      test('get completed task count', () async {
        var completedTaskCount = await taskBloc.getCompletedTaskCount(year);
        expect(completedTaskCount, [].length);
      });

      test('get task', () async {
        var task = await taskBloc.getTask(year, 0);
        expect(task, testTask);
      });
    });
  });
}
