import '/backend/supabase/supabase.dart';
import '/final_app_pages/final_header/final_header_widget.dart';
import '/final_app_pages/plant_library_card/plant_library_card_widget.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import 'plant_library_page_widget.dart' show PlantLibraryPageWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PlantLibraryPageModel extends FlutterFlowModel<PlantLibraryPageWidget> {
  ///  Local state fields for this page.
  /// Stores the currently selected plant category.
  String selectedCategory = 'Vegetables';

  ///  State fields for stateful widgets in this page.

  // Model for FinalHeader component.
  late FinalHeaderModel finalHeaderModel;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  String? get choiceChipsValue =>
      choiceChipsValueController?.value?.firstOrNull;
  set choiceChipsValue(String? val) =>
      choiceChipsValueController?.value = val != null ? [val] : [];
  // Model for PlantLibraryCard component.
  late PlantLibraryCardModel plantLibraryCardModel;

  @override
  void initState(BuildContext context) {
    finalHeaderModel = createModel(context, () => FinalHeaderModel());
    plantLibraryCardModel = createModel(context, () => PlantLibraryCardModel());
  }

  @override
  void dispose() {
    finalHeaderModel.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();

    plantLibraryCardModel.dispose();
  }
}
