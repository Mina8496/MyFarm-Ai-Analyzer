import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class PlantTfliteService {
  late Interpreter _interpreter;
  late List<String> labels;

  Future<void> load() async {
    _interpreter = await Interpreter.fromAsset(
      'models/plant_disease.tflite',
    );

    labels = (await rootBundle
            .loadString('assets/labels/labels.txt'))
        .split('\n');
  }

  List<double> predict(Float32List input) {
    var output =
        List.filled(labels.length, 0.0).reshape([1, labels.length]);

    _interpreter.run(
      input.reshape([1, 224, 224, 3]),
      output,
    );

    return List<double>.from(output[0]);
  }
}
