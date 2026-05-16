// lib/features/scanner/data/repositories/scanner_repository_impl.dart
import 'dart:io';
import 'package:srws_app/features/scanner/data/data_sources/ai_service.dart';
import 'package:srws_app/features/scanner/data/data_sources/camera_service.dart';
import 'package:srws_app/features/scanner/domain/entities/waste_result.dart';
import 'package:srws_app/features/scanner/domain/repositories/scanner_repository.dart';
import 'package:srws_app/core/services/local_history_service.dart';
import 'package:srws_app/core/services/api_service.dart';

class ScannerRepositoryImpl implements ScannerRepository {
  final CameraService      cameraService;
  final IAiService         aiService;
  final LocalHistoryService localHistory;

  ScannerRepositoryImpl({
    required this.cameraService,
    required this.aiService,
    required this.localHistory,
  });

  @override
  Future<WasteResult> scanWithCamera() async {
    // 1. Fotoğraf çek
    final xFile = await cameraService.controller!.takePicture();
    final imageFile = File(xFile.path);
    return _runAnalysis(imageFile);
  }

  @override
  Future<WasteResult> analyzeGalleryImage(File imageFile) async {
    return _runAnalysis(imageFile);
  }

  Future<WasteResult> _runAnalysis(File imageFile) async {
    // 2. AI servisine gönder
    final result = await aiService.analyzeImage(imageFile);

    // 3. Bağlantı yoksa veya AI cevap vermezse → kullanıcıya açık hata
    if (result == null) {
      throw Exception(
        'Could not identify this item.\n'
        'Make sure the backend is running and try again.',
      );
    }

    // 4. Locale kaydet (her zaman çalışır)
    await localHistory.saveRecord(result);

    // 5. Backend'e arka planda gönder (başarısız olsa bile uygulamayı durdurmaz)
    ApiService.saveScanHistory(
      categoryName:    result.category,
      confidenceScore: result.confidence,
      aiDescription:   result.description,
    );

    return result;
  }
}
