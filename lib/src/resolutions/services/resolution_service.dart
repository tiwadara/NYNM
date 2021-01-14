import 'package:resolution/src/commons/services/storage_service.dart';
import 'package:resolution/src/resolutions/models/resolution.dart';

class ResolutionService {
  final StorageService storageService;
  ResolutionService(this.storageService);

  Future<Resolution> saveResolution(Resolution resolution) async {
    return storageService.saveResolution(resolution);
  }

  Future<Resolution> getResolution(Resolution resolution) async {
    return storageService.getResolution(resolution);
  }

  Future<List<Resolution>> getAllResolution() async {
    print("callll" + toString());
    return await storageService.getAllResolutions();
  }

}
