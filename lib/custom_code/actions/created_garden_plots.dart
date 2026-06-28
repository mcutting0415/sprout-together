// Automatic FlutterFlow imports
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future createdGardenPlots(
  String? gardenID,
  int? gardenWidth,
  int? gardenLength,
) async {
  if (gardenID == null || gardenWidth == null || gardenLength == null) {
    return;
  }

  final totalPlots = gardenWidth * gardenLength;

  for (int i = 1; i <= totalPlots; i++) {
    await SupaFlow.client.from('garden_plots').insert({
      'garden_id': gardenID,
      'plot_number': i,
    });
  }
}
