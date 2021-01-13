import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:resolution/src/commons/constants/storage_constants.dart';
import 'package:resolution/src/resolutions/models/resolution.dart';

class StorageService {
  Future<List<Resolution>> deleteResolution(Resolution resolution) async {
    List<Resolution> resolutions = List<Resolution>();
    final resolutionBox = await Hive.openBox(StorageConstants.USER_RESOLUTIONS);
    resolutionBox.delete(resolution);
    resolutions.addAll(resolutionBox.values.map((e) => e));
    return resolutions;
  }

  Future<void> clearAllResolutions() async {
    final resolutionBox = await Hive.openBox(StorageConstants.USER_RESOLUTIONS);
    await resolutionBox.clear();
  }

  Future<Resolution> saveResolution(Resolution resolution) async {
    final resolutionBox = await Hive.openBox(StorageConstants.USER_RESOLUTIONS);
    await resolutionBox.add(resolution);
    return resolutionBox.values.singleWhere((element) => element == resolution);
  }

  Future<Resolution> getResolution(Resolution resolution) async {
    final resolutionBox = await Hive.openBox(StorageConstants.USER_RESOLUTIONS);
    log("message" + resolutionBox.values.toString());
    return resolutionBox.values.singleWhere((element) => element == resolution);
  }
}
