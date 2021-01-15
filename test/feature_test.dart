import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:resolution/src/commons/services/storage_service.dart';
import 'package:resolution/src/tasks/services/task_service.dart';

class MockStorageService extends Mock implements StorageService {}

class MockResolutionService extends Mock implements TaskService {}

class MockHiveInterface extends Mock implements HiveInterface {}

class MockHiveBox extends Mock implements Box {}

main() {
  // **************  FEATURE TESTS ***********************

  group('Feature Test | ', () {
    TaskService resolutionService;
    StorageService storageService;

    setUp(() async {
      storageService = MockStorageService();
    });

    test('Constructing Service should find correct dependencies', () {
      expect(resolutionService != null, true);
      expect(storageService != null, true);
    });
  });
}
