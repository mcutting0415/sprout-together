import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/setup_section/setup_section_widget.dart';
import '/components/setup_section_child/setup_section_child_widget.dart';
import '/components/setup_section_child2/setup_section_child2_widget.dart';
import '/components/setup_section_child3/setup_section_child3_widget.dart';
import '/components/setup_section_child4/setup_section_child4_widget.dart';
import '/components/setup_section_child5/setup_section_child5_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'account_setup_page2_widget.dart' show AccountSetupPage2Widget;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AccountSetupPage2Model extends FlutterFlowModel<AccountSetupPage2Widget> {
  ///  Local state fields for this page.

  String nameInput = 'Name';

  String townInput = 'Town';

  String profileImageURL = 'Image';

  String gardeningZone = 'Zone';

  String zipCode = 'Zip';

  List<String> gardenTypes = [];
  void addToGardenTypes(String item) => gardenTypes.add(item);
  void removeFromGardenTypes(String item) => gardenTypes.remove(item);
  void removeAtIndexFromGardenTypes(int index) => gardenTypes.removeAt(index);
  void insertAtIndexInGardenTypes(int index, String item) =>
      gardenTypes.insert(index, item);
  void updateGardenTypesAtIndex(int index, Function(String) updateFn) =>
      gardenTypes[index] = updateFn(gardenTypes[index]);

  String experienceLevel = 'experience';

  List<String> goals = [];
  void addToGoals(String item) => goals.add(item);
  void removeFromGoals(String item) => goals.remove(item);
  void removeAtIndexFromGoals(int index) => goals.removeAt(index);
  void insertAtIndexInGoals(int index, String item) =>
      goals.insert(index, item);
  void updateGoalsAtIndex(int index, Function(String) updateFn) =>
      goals[index] = updateFn(goals[index]);

  ///  State fields for stateful widgets in this page.

  // Model for SetupSection.
  late SetupSectionModel setupSectionModel1;
  // Model for SetupSection.
  late SetupSectionModel setupSectionModel2;
  // Model for SetupSection.
  late SetupSectionModel setupSectionModel3;
  // Model for SetupSection.
  late SetupSectionModel setupSectionModel4;
  // Model for SetupSection.
  late SetupSectionModel setupSectionModel5;

  @override
  void initState(BuildContext context) {
    setupSectionModel1 = createModel(context, () => SetupSectionModel());
    setupSectionModel2 = createModel(context, () => SetupSectionModel());
    setupSectionModel3 = createModel(context, () => SetupSectionModel());
    setupSectionModel4 = createModel(context, () => SetupSectionModel());
    setupSectionModel5 = createModel(context, () => SetupSectionModel());
  }

  @override
  void dispose() {
    setupSectionModel1.dispose();
    setupSectionModel2.dispose();
    setupSectionModel3.dispose();
    setupSectionModel4.dispose();
    setupSectionModel5.dispose();
  }
}
