import 'dart:io';
import 'package:srws_app/features/scanner/domain/entities/waste_result.dart';
import 'package:srws_app/features/scanner/data/models/waste_result_model.dart';
import 'package:srws_app/core/services/api_service.dart';

abstract class IAiService {
  Future<WasteResult?> analyzeImage(File imageFile);
}

class AiService implements IAiService {
  @override
  Future<WasteResult?> analyzeImage(File imageFile) async {
    print('API isteği gönderiliyor: ${imageFile.path}');
    final response = await ApiService.classifyWaste(imageFile);
    print('API yanıtı: $response');
    if (response['success'] != true) return null;
    return WasteResultModel.fromJson(response['data'] as Map<String, dynamic>);
  }
}
