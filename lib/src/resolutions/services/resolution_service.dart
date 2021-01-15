import 'package:hive/hive.dart';
import 'package:resolution/src/commons/constants/storage_constants.dart';
import 'package:resolution/src/commons/services/storage_service.dart';
import 'package:resolution/src/resolutions/models/resolution.dart';

class ResolutionService {
  final StorageService storageService;
  ResolutionService(this.storageService);

  Future<Resolution> saveResolution(Resolution resolution) async {
    Resolution savedResolution;
    if (await resolutionExists(resolution)) {
      throw Error();
    } else {
      Box resolutionBox =
          await storageService.openBox(StorageConstants.RESOLUTION_BOX);
      await resolutionBox.put(resolution.year, resolution);
      savedResolution =
          resolutionBox.values.singleWhere((element) => element == resolution);
    }
    return savedResolution;
  }

  Future<List<Resolution>> getAllResolution() async {
    List<Resolution> resolutions = List<Resolution>();
    Box resolutionBox =
        await storageService.openBox(StorageConstants.RESOLUTION_BOX);
    resolutions.addAll(resolutionBox.values.map((e) => e));
    return resolutions;
  }

  Future<bool> resolutionExists(Resolution resolution) async {
    bool exists = false;
    Box resolutionBox =
        await storageService.openBox(StorageConstants.RESOLUTION_BOX);
    resolutionBox.values.map((e) {
      if (e.year == resolution.year) {
        print("resolution exists");
        exists = true;
      }
    });
    return exists;
  }
}
