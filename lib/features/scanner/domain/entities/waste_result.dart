import 'package:equatable/equatable.dart';

class WasteResult extends Equatable {
  final String category;
  final double confidence;
  final String description;
  final String recyclingBin;
  final String colorHex;

  const WasteResult({
    required this.category,
    required this.confidence,
    required this.description,
    required this.recyclingBin,
    required this.colorHex,
  });

  @override
  List<Object> get props => [category, confidence, description, recyclingBin, colorHex];
}