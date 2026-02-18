import 'dart:io';
import 'dart:developer' as devtools;
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:myfarm/features/plant_analysis/data/model/classification_result.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:myfarm/core/utils/Asset_Paths.dart';

class ClassifierService {
  late Interpreter _interpreter;
  late List<String> _labels;

  late int _inputSize;
  late int _inputChannels;
  late bool _isFloatModel;

  bool isModelLoaded = false;

  // ===============================
  // LOAD MODEL (UNIVERSAL)
  // ===============================
  Future<void> loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset(AssetPaths.mangoModel);

      /// 🔥 اقرأ معلومات الموديل تلقائيًا
      final inputTensor = _interpreter.getInputTensor(0);
      final outputTensor = _interpreter.getOutputTensor(0);

      _inputSize = inputTensor.shape[1];
      _inputChannels = inputTensor.shape[3];
      _isFloatModel = inputTensor.type.toString().contains('float');

      devtools.log(
        'Model Loaded | Input: $_inputSize x $_inputSize x $_inputChannels | Float: $_isFloatModel',
      );
      devtools.log('Output Classes: ${outputTensor.shape.last}');

      /// LOAD LABELS
      final labelData = await rootBundle.loadString(AssetPaths.mangoLabel);
      _labels = labelData.split('\n').where((e) => e.isNotEmpty).toList();

      isModelLoaded = true;
    } catch (e) {
      devtools.log("Error loading model: $e");
      rethrow;
    }
  }

  // ===============================
  // IMAGE PREPROCESS (AUTO)
  // ===============================
  List<List<List<List<num>>>> _preProcessImage(img.Image image) {
    final resized = img.copyResize(
      image,
      width: _inputSize,
      height: _inputSize,
    );

    return List.generate(1, (_) {
      return List.generate(_inputSize, (y) {
        return List.generate(_inputSize, (x) {
          final pixel = resized.getPixel(x, y);

          if (_isFloatModel) {
            return [(pixel.r / 255.0), (pixel.g / 255.0), (pixel.b / 255.0)];
          } else {
            return [pixel.r, pixel.g, pixel.b];
          }
        });
      });
    });
  }

  // ===============================
  // CLASSIFY IMAGE
  // ===============================
  Future<ClassificationResult?> classifyImage(File file) async {
    if (!isModelLoaded) return null;

    final bytes = await file.readAsBytes();
    final image = img.decodeImage(bytes);
    if (image == null) return null;

    final input = _preProcessImage(image);

    final output = List.filled(
      _labels.length,
      0.0,
    ).reshape([1, _labels.length]);

    _interpreter.run(input, output);

    final scores = output[0] as List<double>;

    int bestIndex = 0;
    double bestScore = scores[0];

    for (int i = 1; i < scores.length; i++) {
      if (scores[i] > bestScore) {
        bestScore = scores[i];
        bestIndex = i;
      }
    }

    final sorted = List.generate(
      scores.length,
      (i) => MapEntry(_labels[i], scores[i] * 100),
    )..sort((a, b) => b.value.compareTo(a.value));

    return ClassificationResult(
      label: _labels[bestIndex],
      confidence: bestScore * 100,
      topResults: Map.fromEntries(sorted.take(3)),
    );
  }
}
