import '/components/benefit_badge_widget.dart';
import '/components/requirement_row_widget.dart';
import '/components/timeline_item2_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'plant_details_page_widget.dart' show PlantDetailsPageWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PlantDetailsPageModel extends FlutterFlowModel<PlantDetailsPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for RequirementRow.
  late RequirementRowModel requirementRowModel1;
  // Model for RequirementRow.
  late RequirementRowModel requirementRowModel2;
  // Model for RequirementRow.
  late RequirementRowModel requirementRowModel3;
  // Model for RequirementRow.
  late RequirementRowModel requirementRowModel4;
  // Model for RequirementRow.
  late RequirementRowModel requirementRowModel5;
  // Model for TimelineItem.
  late TimelineItem2Model timelineItemModel1;
  // Model for TimelineItem.
  late TimelineItem2Model timelineItemModel2;
  // Model for TimelineItem.
  late TimelineItem2Model timelineItemModel3;
  // Model for TimelineItem.
  late TimelineItem2Model timelineItemModel4;
  // Model for BenefitBadge.
  late BenefitBadgeModel benefitBadgeModel1;
  // Model for BenefitBadge.
  late BenefitBadgeModel benefitBadgeModel2;
  // Model for BenefitBadge.
  late BenefitBadgeModel benefitBadgeModel3;
  // Model for BenefitBadge.
  late BenefitBadgeModel benefitBadgeModel4;

  @override
  void initState(BuildContext context) {
    requirementRowModel1 = createModel(context, () => RequirementRowModel());
    requirementRowModel2 = createModel(context, () => RequirementRowModel());
    requirementRowModel3 = createModel(context, () => RequirementRowModel());
    requirementRowModel4 = createModel(context, () => RequirementRowModel());
    requirementRowModel5 = createModel(context, () => RequirementRowModel());
    timelineItemModel1 = createModel(context, () => TimelineItem2Model());
    timelineItemModel2 = createModel(context, () => TimelineItem2Model());
    timelineItemModel3 = createModel(context, () => TimelineItem2Model());
    timelineItemModel4 = createModel(context, () => TimelineItem2Model());
    benefitBadgeModel1 = createModel(context, () => BenefitBadgeModel());
    benefitBadgeModel2 = createModel(context, () => BenefitBadgeModel());
    benefitBadgeModel3 = createModel(context, () => BenefitBadgeModel());
    benefitBadgeModel4 = createModel(context, () => BenefitBadgeModel());
  }

  @override
  void dispose() {
    requirementRowModel1.dispose();
    requirementRowModel2.dispose();
    requirementRowModel3.dispose();
    requirementRowModel4.dispose();
    requirementRowModel5.dispose();
    timelineItemModel1.dispose();
    timelineItemModel2.dispose();
    timelineItemModel3.dispose();
    timelineItemModel4.dispose();
    benefitBadgeModel1.dispose();
    benefitBadgeModel2.dispose();
    benefitBadgeModel3.dispose();
    benefitBadgeModel4.dispose();
  }
}
