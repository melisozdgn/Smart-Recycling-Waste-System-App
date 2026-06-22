import 'package:equatable/equatable.dart';
import 'package:camera/camera.dart';
import 'package:srws_app/features/scanner/domain/entities/waste_result.dart';

abstract class ScannerState extends Equatable {
  const ScannerState();
  
  @override
  List<Object?> get props => [];
}

class ScannerInitial extends ScannerState {}

class ScannerLoading extends ScannerState {}

class ScannerReady extends ScannerState {
  final CameraController controller;
  
  const ScannerReady(this.controller);

  @override
  List<Object?> get props => [controller];
}

class ScannerAnalysisLoading extends ScannerState {}

class ScannerAnalysisSuccess extends ScannerState {
  final WasteResult result;
  
  const ScannerAnalysisSuccess(this.result);
  
  @override
  List<Object?> get props => [result];
}

class ScannerError extends ScannerState {
  final String message;
  
  const ScannerError(this.message);
  
  @override
  List<Object?> get props => [message];
}