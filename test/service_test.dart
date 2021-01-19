import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:resolution/src/commons/services/storage_service.dart';
import 'package:resolution/src/resolutions/services/resolution_service.dart';

import 'mocks.dart';

void initHive() {
  var path = Directory.current.path;
  Hive.init(path + '/test/hive_testing_path');
}

main() {
  group('ResolutionService Test | ', () {
    ResolutionService resolutionService;
    StorageService storageService;

    setUp(() async {
      storageService = MockStorageService();
      resolutionService = ResolutionService(storageService);
    });

    test('Constructing Service should find correct dependencies', () {
      expect(resolutionService != null, true);
      expect(storageService != null, true);
    });

    // test('save resolution when resolution year is new', () async {
    //   Resolution testResolution = Resolution(motto: "Two", year: 2021);
    //   Box box = await storageService.openBox("test");
    //   box.put(2021, testResolution);
    //   // when(storageService.openBox(any)).thenAnswer((_) => Future.value(box));
    //   // when(box.get(any)).thenAnswer((_) => Future.value(box));
    //   Resolution newResolution = await resolutionService.saveResolution(Resolution(motto: "One", year: 2021));
    //   verify(resolutionService.resolutionExists(testResolution)).called(1);
    //
    //
    //   expect(newResolution, testResolution);
    // });

    // test('get resolutions', () async {
    //   when(storageService.openBox(any)).thenAnswer((_) => Future.value(box));
    //   when(box.get(any)).thenAnswer((_) => Future.value(box));
    //   List<Resolution> resolutions = await resolutionService.getAllResolution();
    //   expect(resolutions, []);
    // });
  });

  group('StorageService Test | ', () {
    StorageService storageService;

    setUp(() async {
      initHive();
      storageService = StorageService();
    });

    test('Constructing Service should find correct dependencies', () {
      expect(storageService != null, true);
    });

    test('open a  hive box, save and recall', () async {
      String testBoxName = "test_box_name";
      Box createdBox = await storageService.openBox(testBoxName);
      createdBox.add("value");
      var savedValue = await createdBox.getAt(0);
      expect("value", savedValue);
    });
  });
}
