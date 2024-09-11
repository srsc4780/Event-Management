import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sales_tracker/data/model/event_list_model.dart';
import 'package:sales_tracker/data/network/repository/repository.dart';
import 'package:sales_tracker/utils/utils.dart';

class EventsProvider extends ChangeNotifier {
  EventListModel? _eventListResponse;
  bool _isLoading = false;
  int _currentPage = 1;

  EventsProvider(BuildContext context) {
    fetchEvents(context);
  }

  EventListModel? get eventListResponse => _eventListResponse;
  bool get isLoading => _isLoading;

  Future<void> _fetchData({
    required BuildContext context,
    required Future<EventListModel?> Function(Map<String, dynamic> data) apiCall,
    required Map<String, dynamic> data,
    required void Function(EventListModel response) onSuccess,
    required String errorMessage,
  }) async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      final apiResponse = await apiCall(data);
      if (apiResponse != null) {
        onSuccess(apiResponse);
      } else {
        Fluttertoast.showToast(msg: errorMessage);
      }
    } catch (e) {
      printDebug("Error: $e");
      Fluttertoast.showToast(msg: errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchEvents(
    BuildContext context, {
    int page = 1,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    _currentPage = page;

    await _fetchData(
      context: context,
      apiCall: (data) => RepositoryImpl(context).getEventList(data),
      data: {
        "page": _currentPage,
        if (startDate != null) "start_date": startDate.toIso8601String(),
        if (endDate != null) "end_date": endDate.toIso8601String(),
      },
      onSuccess: (apiResponse) {
        printDebug(apiResponse);
        _eventListResponse = apiResponse;
      },
      errorMessage: tr('Failed to load events'),
    );
  }

  Future<void> loadMoreEvents(
    BuildContext context, {
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    _currentPage++;
    await _fetchData(
      context: context,
      apiCall: (data) => RepositoryImpl(context).getEventList(data),
      data: {
        "page": _currentPage,
        if (startDate != null) "start_date": startDate.toIso8601String(),
        if (endDate != null) "end_date": endDate.toIso8601String(),
      },
      onSuccess: (apiResponse) {
        if (_eventListResponse != null) {
          _eventListResponse!.data.addAll(apiResponse.data);
        } else {
          _eventListResponse = apiResponse;
        }
      },
      errorMessage: tr('Failed to load more events'),
    );
  }

  Future<void> searchEvents(
    BuildContext context,
    String query, {
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    _currentPage = 1; // Reset to the first page for search results
    await _fetchData(
      context: context,
      apiCall: (data) => RepositoryImpl(context).getEventList(data),
      data: {
        "page": _currentPage,
        "query": query,
        if (startDate != null) "start_date": startDate.toIso8601String(),
        if (endDate != null) "end_date": endDate.toIso8601String(),
      },
      onSuccess: (apiResponse) {
        _eventListResponse = apiResponse;
      },
      errorMessage: tr('Failed to search events'),
    );
  }
}
