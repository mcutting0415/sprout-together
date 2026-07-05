import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'section_card_child_model.dart';
export 'section_card_child_model.dart';

class SectionCardChildWidget extends StatefulWidget {
  const SectionCardChildWidget({super.key});

  @override
  State<SectionCardChildWidget> createState() => _SectionCardChildWidgetState();
}

class _SectionCardChildWidgetState extends State<SectionCardChildWidget> {
  late SectionCardChildModel _model;
  int _refreshKey = 0;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SectionCardChildModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  void _showEditAccountSheet(BuildContext context, ProfilesRow? profile) {
    final nameController =
        TextEditingController(text: profile?.fullName ?? '');
    final emailController =
        TextEditingController(text: currentUserEmail ?? '');
    final newPasswordController = TextEditingController();
    bool isLoading = false;
    bool obscurePassword = true;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
      builder: (sheetCtx) {
        return StatefulBuilder(
          builder: (sheetCtx, setSheetState) {
            InputDecoration fieldDecoration(String label) => InputDecoration(
                  labelText: label,
                  labelStyle: GoogleFonts.poppins(
                    color: FlutterFlowTheme.of(sheetCtx).secondaryText,
                    fontSize: 13.0,
                  ),
                  filled: true,
                  fillColor: FlutterFlowTheme.of(sheetCtx).primaryBackground,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(sheetCtx).alternate,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(sheetCtx).primary,
                      width: 2.0,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 14.0),
                );

            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(sheetCtx).viewInsets.bottom,
                left: 24.0,
                right: 24.0,
                top: 24.0,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Edit Account',
                            style: FlutterFlowTheme.of(sheetCtx)
                                .titleLarge
                                .override(
                                  font: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold),
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.close,
                            color:
                                FlutterFlowTheme.of(sheetCtx).secondaryText,
                          ),
                          onPressed: () => Navigator.of(sheetCtx).pop(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: nameController,
                      decoration: fieldDecoration('Display Name'),
                      style: GoogleFonts.poppins(fontSize: 15.0),
                    ),
                    const SizedBox(height: 14.0),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: fieldDecoration('Email'),
                      style: GoogleFonts.poppins(fontSize: 15.0),
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      'New Password',
                      style:
                          FlutterFlowTheme.of(sheetCtx).titleSmall.override(
                                font: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600),
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.0,
                              ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'Leave blank to keep your current password',
                      style: GoogleFonts.poppins(
                        fontSize: 12.0,
                        color: FlutterFlowTheme.of(sheetCtx).secondaryText,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      controller: newPasswordController,
                      obscureText: obscurePassword,
                      decoration: fieldDecoration('New Password').copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color:
                                FlutterFlowTheme.of(sheetCtx).secondaryText,
                            size: 20.0,
                          ),
                          onPressed: () => setSheetState(
                              () => obscurePassword = !obscurePassword),
                        ),
                      ),
                      style: GoogleFonts.poppins(fontSize: 15.0),
                    ),
                    const SizedBox(height: 24.0),
                    ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () async {
                              setSheetState(() => isLoading = true);
                              try {
                                final newName = nameController.text.trim();
                                if (newName.isNotEmpty) {
                                  await ProfilesTable().update(
                                    data: {'full_name': newName},
                                    matchingRows: (rows) =>
                                        rows.eqOrNull('id', currentUserUid),
                                  );
                                }
                                final newEmail = emailController.text.trim();
                                if (newEmail.isNotEmpty &&
                                    newEmail != (currentUserEmail ?? '')) {
                                  await authManager.updateEmail(
                                    email: newEmail,
                                    context: context,
                                  );
                                }
                                final newPwd = newPasswordController.text;
                                if (newPwd.isNotEmpty) {
                                  await authManager.updatePassword(
                                    newPassword: newPwd,
                                    context: context,
                                  );
                                }
                                if (sheetCtx.mounted) {
                                  Navigator.of(sheetCtx).pop();
                                }
                                if (mounted) {
                                  safeSetState(() => _refreshKey++);
                                  final emailChanged = newEmail.isNotEmpty &&
                                      newEmail != (currentUserEmail ?? '');
                                  final pwdChanged = newPwd.isNotEmpty;
                                  if (!emailChanged && !pwdChanged) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Account updated!'),
                                        backgroundColor: Color(0xFF4CAF50),
                                      ),
                                    );
                                  }
                                }
                              } catch (e) {
                                if (sheetCtx.mounted) {
                                  ScaffoldMessenger.of(sheetCtx).showSnackBar(
                                    SnackBar(
                                      content: Text('Error: $e'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              } finally {
                                if (sheetCtx.mounted) {
                                  setSheetState(() => isLoading = false);
                                }
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            FlutterFlowTheme.of(sheetCtx).primary,
                        padding:
                            const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        elevation: 0,
                      ),
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              'Save Changes',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                              ),
                            ),
                    ),
                    const SizedBox(height: 32.0),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProfilesRow>>(
      key: ValueKey(_refreshKey),
      future: ProfilesTable().querySingleRow(
        queryFn: (q) => q.eqOrNull('id', currentUserUid),
      ),
      builder: (context, snapshot) {
        final profile =
            snapshot.hasData && snapshot.data!.isNotEmpty
                ? snapshot.data!.first
                : null;
        final displayName = profile?.fullName ?? currentUserEmail ?? '';
        final email = currentUserEmail ?? '';
        final initials = displayName.isNotEmpty
            ? displayName
                .trim()
                .split(' ')
                .where((w) => w.isNotEmpty)
                .take(2)
                .map((w) => w[0].toUpperCase())
                .join()
            : '?';

        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 64.0,
                  height: 64.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primary,
                    borderRadius: BorderRadius.circular(20.0),
                    shape: BoxShape.rectangle,
                  ),
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Text(
                    initials,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    style: FlutterFlowTheme.of(context).labelMedium.override(
                          font: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .fontStyle,
                          ),
                          color: Colors.white,
                          fontSize: 24.32,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          fontStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .fontStyle,
                          lineHeight: 1.4,
                        ),
                    overflow: TextOverflow.clip,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        displayName.isNotEmpty ? displayName : 'My Account',
                        style:
                            FlutterFlowTheme.of(context).titleMedium.override(
                                  font: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontStyle,
                                  lineHeight: 1.4,
                                ),
                      ),
                      Text(
                        email,
                        style:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  font: GoogleFonts.poppins(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                  lineHeight: 1.4,
                                ),
                      ),
                    ].divide(SizedBox(height: 4.0)),
                  ),
                ),
              ].divide(SizedBox(width: 16.0)),
            ),
            GestureDetector(
              onTap: () => _showEditAccountSheet(context, profile),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 10.0),
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context)
                      .primary
                      .withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: FlutterFlowTheme.of(context)
                        .primary
                        .withOpacity(0.25),
                    width: 1.0,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.edit_outlined,
                      size: 16.0,
                      color: FlutterFlowTheme.of(context).primary,
                    ),
                    const SizedBox(width: 6.0),
                    Text(
                      'Edit Account',
                      style: GoogleFonts.poppins(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w600,
                        color: FlutterFlowTheme.of(context).primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ].divide(SizedBox(height: 16.0)),
        );
      },
    );
  }
}
