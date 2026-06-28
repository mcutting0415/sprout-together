import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/account_management_rounded_widget.dart';
import '/final_app_pages/final_header/final_header_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'profile_page2_widget.dart' show ProfilePage2Widget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfilePage2Model extends FlutterFlowModel<ProfilePage2Widget> {
  ///  State fields for stateful widgets in this page.

  // Model for FinalHeader component.
  late FinalHeaderModel finalHeaderModel;
  // Model for AccountManagementRounded component.
  late AccountManagementRoundedModel accountManagementRoundedModel;

  @override
  void initState(BuildContext context) {
    finalHeaderModel = createModel(context, () => FinalHeaderModel());
    accountManagementRoundedModel =
        createModel(context, () => AccountManagementRoundedModel());
  }

  @override
  void dispose() {
    finalHeaderModel.dispose();
    accountManagementRoundedModel.dispose();
  }
}
