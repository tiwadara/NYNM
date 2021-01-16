import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:resolution/src/commons/constants/app_strings.dart';
import 'package:resolution/src/commons/services/notification_service.dart';
import 'package:resolution/src/commons/services/storage_service.dart';
import 'package:resolution/src/resolutions/blocs/resolution/resolution_bloc.dart';
import 'package:resolution/src/resolutions/models/resolution.dart';
import 'package:resolution/src/resolutions/services/resolution_service.dart';
import 'package:resolution/src/tasks/blocs/task/task_bloc.dart';
import 'package:resolution/src/tasks/models/task.dart';
import 'package:resolution/src/tasks/services/task_service.dart';

class MockStorageService extends Mock implements StorageService {}

class MockResolutionService extends Mock implements ResolutionService {}

class MockTaskService extends Mock implements TaskService {}

class MockNotificationService extends Mock implements NotificationService {}

class MockHiveInterface extends Mock implements HiveInterface {}

class MockHiveBox extends Mock implements Box {}

main() {
  // **************  UNIT TESTS ***********************

  // unit test Services
  // group('ResolutionService Test | ', () {
  //   ResolutionService resolutionService;
  //   StorageService storageService;
  //   Box box;
  //
  //   setUp(() async {
  //     storageService = MockStorageService();
  //     box = MockHiveBox();
  //     resolutionService = ResolutionService(storageService);
  //   });
  //
  //   test('Constructing Service should find correct dependencies', () {
  //     expect(resolutionService != null, true);
  //     expect(storageService != null, true);
  //   });
  //
  //   test('save resolution when resolution year is new', () async {
  //     Resolution testResolution = Resolution(motto: "Two", year: 2021);
  //     when(storageService.openBox(any)).thenAnswer((_) => Future.value(box));
  //     when(box.get(any)).thenAnswer((_) => Future.value(box));
  //     // when(resolutionService.resolutionExists(testResolution)).thenAnswer((_) => Future.value(true));
  //
  //     Resolution newResolution = await resolutionService.saveResolution(Resolution(motto: "One", year: 2021));
  //     expect(newResolution, testResolution);
  //   });
  //
  //   test('get resolutions', () async {
  //     List<Resolution> resolutions = await resolutionService.getAllResolution();
  //     expect(resolutions, []);
  //   });
  // });

  // unit test blocs

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
              .thenThrow((_) => Future.value("testResolution"));
          return resolutionBloc;
        },
        act: (bloc) => bloc.add(SaveResolution(testResolution)),
        expect: [
          SavingResolution(),
          ResolutionErrorState(AppStringConstants.saveFailed)
        ],
      );
    });
  });

  group('TaskBloc Test -', () {
    TaskService taskService;
    TaskBloc taskBloc;

    setUp(() {
      taskService = MockTaskService();
      taskBloc = TaskBloc(taskService);
    });

    tearDown(() {
      taskBloc?.close();
    });

    test('initial state is correct', () {
      expect(taskBloc.initialState, InitialTaskState());
    });

    group('createTask -', () {
      Task testTask = Task();
      int year = 2020;

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
  });
}
