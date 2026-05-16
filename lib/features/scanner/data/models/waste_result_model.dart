import 'package:srws_app/features/scanner/domain/entities/waste_result.dart';

class WasteResultModel extends WasteResult {
  const WasteResultModel({
    required super.category,
    required super.confidence,
    required super.description,
    required super.recyclingBin,
    required super.colorHex,
  });

  factory WasteResultModel.fromJson(Map<String, dynamic> json) {
    return WasteResultModel(
      category: json['category'] as String,
      confidence: (json['confidence'] as num).toDouble(),
      description: json['description'] as String,
      recyclingBin: json['recycling_bin'] as String,
      colorHex: json['color_hex'] as String,
    );
  }
}