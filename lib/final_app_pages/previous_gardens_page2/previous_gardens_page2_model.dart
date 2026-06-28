import '/components/garden_card_widget.dart';
import '/components/summary_stat_widget.dart';
import '/components/timeline_item3_widget.dart';
import '/final_app_pages/final_header/final_header_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'previous_gardens_page2_widget.dart' show PreviousGardensPage2Widget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PreviousGardensPage2Model
    extends FlutterFlowModel<PreviousGardensPage2Widget> {
  ///  State fields for stateful widgets in this page.

  // Model for FinalHeader component.
  late FinalHeaderModel finalHeaderModel;
  // Model for SummaryStat.
  late SummaryStatModel summaryStatModel1;
  // Model for SummaryStat.
  late SummaryStatModel summaryStatModel2;
  // Model for SummaryStat.
  late SummaryStatModel summaryStatModel3;
  // Model for GardenCard.
  late GardenCardModel gardenCardModel1;
  // Model for GardenCard.
  late GardenCardModel gardenCardModel2;
  // Model for TimelineItem.
  late TimelineItem3Model timelineItemModel1;
  // Model for TimelineItem.
  late TimelineItem3Model timelineItemModel2;
  // Model for TimelineItem.
  late TimelineItem3Model timelineItemModel3;
  // Model for TimelineItem.
  late TimelineItem3Model timelineItemModel4;
  // Model for TimelineItem.
  late TimelineItem3Model timelineItemModel5;

  @override
  void initState(BuildContext context) {
    finalHeaderModel = createModel(context, () => FinalHeaderModel());
    summaryStatModel1 = createModel(context, () => SummaryStatModel());
    summaryStatModel2 = createModel(context, () => SummaryStatModel());
    summaryStatModel3 = createModel(context, () => SummaryStatModel());
    gardenCardModel1 = createModel(context, () => GardenCardModel());
    gardenCardModel2 = createModel(context, () => GardenCardModel());
    timelineItemModel1 = createModel(context, () => TimelineItem3Model());
    timelineItemModel2 = createModel(context, () => TimelineItem3Model());
    timelineItemModel3 = createModel(context, () => TimelineItem3Model());
    timelineItemModel4 = createModel(context, () => TimelineItem3Model());
    timelineItemModel5 = createModel(context, () => TimelineItem3Model());
  }

  @override
  void dispose() {
    finalHeaderModel.dispose();
    summaryStatModel1.dispose();
    summaryStatModel2.dispose();
    summaryStatModel3.dispose();
    gardenCardModel1.dispose();
    gardenCardModel2.dispose();
    timelineItemModel1.dispose();
    timelineItemModel2.dispose();
    timelineItemModel3.dispose();
    timelineItemModel4.dispose();
    timelineItemModel5.dispose();
  }
}
