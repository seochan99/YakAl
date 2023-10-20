import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:yakal/models/Medication/dose_name_code_model.dart';

class MedicineCodeRepository {
  Future<Database> _getDB() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, '~www/medicine_code.db');
    var exists = await databaseExists(path);

    if (!exists) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      var data = await rootBundle.load(join('assets/data', 'medicine_code.db'));
      List<int> bytes = data.buffer.asUint8List(
        data.offsetInBytes,
        data.lengthInBytes,
      );

      await File(path).writeAsBytes(bytes, flush: true);
    }

    return await openDatabase(path, readOnly: true);
  }

  Future<List<String>> getMedicinesName() async {
    var db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.rawQuery(
      'select name from medicine_code',
    );

    await db.close();

    return List.generate(maps.length, (index) => maps[index]["name"]);
  }

  Future<DoseNameCodeModel?> getKDCodeAndATCCode(String dosename) async {
    final exceptSpace = RegExp(r"\s");
    final processedName = dosename.replaceAll(exceptSpace, "");

    var db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.rawQuery(
      'select kd_code, name, atc_code from medicine_code m where m.name = \'$processedName\'',
    );

    if (maps.isEmpty) {
      final koreanRegex = RegExp(r"[가-힣]");
      final lastKorIndex = processedName.lastIndexOf(koreanRegex);
      final processedInFail = processedName.substring(0, lastKorIndex + 1);

      final List<Map<String, dynamic>> mapsInFail = await db.rawQuery(
        'select kd_code, name, atc_code from medicine_code m where m.name = \'$processedInFail\'',
      );

      if (mapsInFail.isEmpty) {
        return null;
      } else {
        return DoseNameCodeModel(
          name: dosename,
          atcCode: mapsInFail[0]["atc_code"],
          kdCode: mapsInFail[0]["kd_code"],
        );
      }
    }

    return DoseNameCodeModel(
      name: dosename,
      atcCode: maps[0]["atc_code"],
      kdCode: maps[0]["kd_code"],
    );
  }
}
