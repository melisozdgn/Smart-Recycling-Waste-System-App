import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:srws_app/core/l10n/app_localizations.dart'; 
import 'dart:io';
import '../cubit/scanner_cubit.dart';
import '../cubit/scanner_state.dart';
import 'scan_result_sheet.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ScannerCubit>().initCamera();
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF2E7D32);
    final double frameWidth  = MediaQuery.of(context).size.width * 0.75;
    final double frameHeight = MediaQuery.of(context).size.height * 0.45;
    final l10n = AppLocalizations.of(context)!; 

    return BlocConsumer<ScannerCubit, ScannerState>(
      listener: (context, state) {
        if (state is ScannerError) {
          String snackBarMessage = state.message;
          if (state.message == 'CameraAccessDenied') {
            snackBarMessage = l10n.cameraAccessDenied;
          } else if (state.message == 'CameraUnknownError') {
            snackBarMessage = l10n.cameraUnknownError;
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(snackBarMessage),
              backgroundColor: Colors.redAccent,
              duration: const Duration(seconds: 5),
              action: SnackBarAction(
                label: 'OK',
                textColor: Colors.white,
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  context.read<ScannerCubit>().initCamera();
                },
              ),
            ),
          );
        }
        if (state is ScannerAnalysisSuccess) {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => ScanResultSheet(result: state.result),
          ).then((_) {
            if (context.mounted) {
              context.read<ScannerCubit>().reset();
            }
          });
        }
      },
      builder: (context, state) {
        final cubit      = context.read<ScannerCubit>();
        final controller = cubit.cameraService.controller;

        if (state is ScannerLoading ||
            state is ScannerInitial ||
            controller == null ||
            !controller.value.isInitialized) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(color: primaryGreen),
                  const SizedBox(height: 16),
                  Text(
                    l10n.startingCamera, 
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
          );
        }

        final bool isAnalyzing = state is ScannerAnalysisLoading;

        return Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            fit: StackFit.expand,
            children: [
              CameraPreview(controller),
              Container(color: Colors.black.withAlpha(76)),
              _buildTopHeader(),
              _buildScanFrame(isAnalyzing, primaryGreen, frameWidth, frameHeight),
              _buildBottomAction(context, cubit, isAnalyzing, primaryGreen, l10n),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTopHeader() {
    return Positioned(
      top: 50,
      left: 16,
      right: 16,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          const Expanded(
            child: Column(
              children: [
                Text('AI SCANNER',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5)),
                Text('Smart Recycling System',
                    style: TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildScanFrame(bool isAnalyzing, Color primaryGreen,
      double width, double height) {
    final Color frameColor = isAnalyzing ? Colors.amber : primaryGreen;
    return Align(
      alignment: const Alignment(0, -0.1),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(color: frameColor.withAlpha(204), width: 2),
          borderRadius: BorderRadius.circular(32),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: Stack(
            children: [
              if (isAnalyzing) ScanningLine(width: width, height: height),
              _buildCorner(frameColor, isTop: true,  isLeft: true),
              _buildCorner(frameColor, isTop: true,  isLeft: false),
              _buildCorner(frameColor, isTop: false, isLeft: true),
              _buildCorner(frameColor, isTop: false, isLeft: false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCorner(Color color, {required bool isTop, required bool isLeft}) {
    return Positioned(
      top:     isTop   ? 0 : null,
      bottom: !isTop  ? 0 : null,
      left:   isLeft  ? 0 : null,
      right:  !isLeft ? 0 : null,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          border: Border(
            top:     isTop   ? BorderSide(color: color, width: 4) : BorderSide.none,
            bottom: !isTop  ? BorderSide(color: color, width: 4) : BorderSide.none,
            left:   isLeft  ? BorderSide(color: color, width: 4) : BorderSide.none,
            right:  !isLeft ? BorderSide(color: color, width: 4) : BorderSide.none,
          ),
          borderRadius: BorderRadius.only(
            topLeft:     Radius.circular(isTop  && isLeft  ? 32 : 0),
            topRight:    Radius.circular(isTop  && !isLeft ? 32 : 0),
            bottomLeft:  Radius.circular(!isTop && isLeft  ? 32 : 0),
            bottomRight: Radius.circular(!isTop && !isLeft ? 32 : 0),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomAction(BuildContext context, ScannerCubit cubit,
      bool isAnalyzing, Color primaryGreen, AppLocalizations l10n) {
    return Positioned(
      bottom: 50,
      left: 0,
      right: 0,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(128),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              isAnalyzing
                  ? l10n.scanningAndAnalyzing 
                  : l10n.positionItemInsideFrame, 
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          const SizedBox(height: 40),
          GestureDetector(
            onTap: isAnalyzing ? null : () => cubit.captureAndAnalyze(),
            child: Container(
              height: 84,
              width: 84,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isAnalyzing ? Colors.amber : Colors.white,
                  width: 4,
                ),
              ),
              child: Center(
                child: isAnalyzing
                    ? const CircularProgressIndicator(color: Colors.amber)
                    : Icon(Icons.camera_rounded, color: primaryGreen, size: 32),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ScanningLine extends StatefulWidget {
  final double width;
  final double height;
  const ScanningLine({super.key, required this.width, required this.height});

  @override
  State<ScanningLine> createState() => _ScanningLineState();
}

class _ScanningLineState extends State<ScanningLine>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        duration: const Duration(seconds: 2), vsync: this)
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) => Positioned(
        top: _ctrl.value * (widget.height - 4),
        left: 0,
        right: 0,
        child: Container(
          height: 4,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.amber.withAlpha(153),
                  blurRadius: 10,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(colors: [
              Colors.transparent,
              Colors.amber.withAlpha(51),
              Colors.amber,
              Colors.amber.withAlpha(51),
              Colors.transparent,
            ]),
          ),
        ),
      ),
    );
  }
}