import 'package:resolution/src/commons/services/storage_service.dart';
import 'package:resolution/src/resolutions/models/resolution.dart';

class ResolutionService {
  final StorageService storageService;
  ResolutionService(this.storageService);

  Future<Resolution> saveResolution(Resolution resolution) async {
    return Resolution(name: "One");
    // return storageService.saveResolution(resolution);
  }

  Future<Resolution> getResolution(Resolution resolution) async {
    return Resolution(name: "One");
    return storageService.getResolution(resolution);
  }

  Future<void> clearAllResolutions() async {
    storageService.clearAllResolutions();
  }

  Future<List<Resolution>> removeResolution(Resolution resolution) async {
    return storageService.deleteResolution(resolution);
  }
}
