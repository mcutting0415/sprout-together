import 'package:flutter/material.dart';
import 'backend/supabase/supabase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  String _currentGardenID = '';
  String get currentGardenID => _currentGardenID;
  set currentGardenID(String value) {
    _currentGardenID = value;
  }

  bool _hasCompletedProfileSetup = false;
  bool get hasCompletedProfileSetup => _hasCompletedProfileSetup;
  set hasCompletedProfileSetup(bool value) {
    _hasCompletedProfileSetup = value;
  }

  String _selectedSeason = '';
  String get selectedSeason => _selectedSeason;
  set selectedSeason(String value) {
    _selectedSeason = value;
  }

  String _setupNameInput = '';
  String get setupNameInput => _setupNameInput;
  set setupNameInput(String value) {
    _setupNameInput = value;
  }

  String _setupTownInput = '';
  String get setupTownInput => _setupTownInput;
  set setupTownInput(String value) {
    _setupTownInput = value;
  }

  String _setupProfileImageURL = '';
  String get setupProfileImageURL => _setupProfileImageURL;
  set setupProfileImageURL(String value) {
    _setupProfileImageURL = value;
  }

  String _setupGardeningZone = '';
  String get setupGardeningZone => _setupGardeningZone;
  set setupGardeningZone(String value) {
    _setupGardeningZone = value;
  }

  String _setupZipCode = '';
  String get setupZipCode => _setupZipCode;
  set setupZipCode(String value) {
    _setupZipCode = value;
  }

  List<String> _setupGardenTypes = [];
  List<String> get setupGardenTypes => _setupGardenTypes;
  set setupGardenTypes(List<String> value) {
    _setupGardenTypes = value;
  }

  void addToSetupGardenTypes(String value) {
    setupGardenTypes.add(value);
  }

  void removeFromSetupGardenTypes(String value) {
    setupGardenTypes.remove(value);
  }

  void removeAtIndexFromSetupGardenTypes(int index) {
    setupGardenTypes.removeAt(index);
  }

  void updateSetupGardenTypesAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    setupGardenTypes[index] = updateFn(_setupGardenTypes[index]);
  }

  void insertAtIndexInSetupGardenTypes(int index, String value) {
    setupGardenTypes.insert(index, value);
  }

  String _setupExperienceLevel = '';
  String get setupExperienceLevel => _setupExperienceLevel;
  set setupExperienceLevel(String value) {
    _setupExperienceLevel = value;
  }

  List<String> _setupGoals = [];
  List<String> get setupGoals => _setupGoals;
  set setupGoals(List<String> value) {
    _setupGoals = value;
  }

  void addToSetupGoals(String value) {
    setupGoals.add(value);
  }

  void removeFromSetupGoals(String value) {
    setupGoals.remove(value);
  }

  void removeAtIndexFromSetupGoals(int index) {
    setupGoals.removeAt(index);
  }

  void updateSetupGoalsAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    setupGoals[index] = updateFn(_setupGoals[index]);
  }

  void insertAtIndexInSetupGoals(int index, String value) {
    setupGoals.insert(index, value);
  }

  List<String> _selectedPlotIDs = [];
  List<String> get selectedPlotIDs => _selectedPlotIDs;
  set selectedPlotIDs(List<String> value) {
    _selectedPlotIDs = value;
  }

  void addToSelectedPlotIDs(String value) {
    selectedPlotIDs.add(value);
  }

  void removeFromSelectedPlotIDs(String value) {
    selectedPlotIDs.remove(value);
  }

  void removeAtIndexFromSelectedPlotIDs(int index) {
    selectedPlotIDs.removeAt(index);
  }

  void updateSelectedPlotIDsAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    selectedPlotIDs[index] = updateFn(_selectedPlotIDs[index]);
  }

  void insertAtIndexInSelectedPlotIDs(int index, String value) {
    selectedPlotIDs.insert(index, value);
  }

  bool _isSideMenuOpen = false;
  bool get isSideMenuOpen => _isSideMenuOpen;
  set isSideMenuOpen(bool value) {
    _isSideMenuOpen = value;
  }

  bool _isGardenDetailOpen = false;
  bool get isGardenDetailOpen => _isGardenDetailOpen;
  set isGardenDetailOpen(bool value) {
    _isGardenDetailOpen = value;
  }

  String _selectedGardenIDForDetail = '';
  String get selectedGardenIDForDetail => _selectedGardenIDForDetail;
  set selectedGardenIDForDetail(String value) {
    _selectedGardenIDForDetail = value;
  }

  List<String> _selectedGardenPlotsList = [];
  List<String> get selectedGardenPlotsList => _selectedGardenPlotsList;
  set selectedGardenPlotsList(List<String> value) {
    _selectedGardenPlotsList = value;
  }

  void addToSelectedGardenPlotsList(String value) {
    selectedGardenPlotsList.add(value);
  }

  void removeFromSelectedGardenPlotsList(String value) {
    selectedGardenPlotsList.remove(value);
  }

  void removeAtIndexFromSelectedGardenPlotsList(int index) {
    selectedGardenPlotsList.removeAt(index);
  }

  void updateSelectedGardenPlotsListAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    selectedGardenPlotsList[index] = updateFn(_selectedGardenPlotsList[index]);
  }

  void insertAtIndexInSelectedGardenPlotsList(int index, String value) {
    selectedGardenPlotsList.insert(index, value);
  }
}
