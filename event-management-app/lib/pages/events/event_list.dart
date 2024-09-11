import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sales_tracker/data/local/local_auth_provider.dart';
import 'package:sales_tracker/data/model/event_list_model.dart';
import 'package:sales_tracker/data/porvider/event_provider.dart'; // Make sure this is correct
import 'package:sales_tracker/pages/auth_pages/login/view/login_page.dart';
import 'package:sales_tracker/utils/theme/app_colors.dart';
import 'package:sales_tracker/utils/widgets/custom_app_bar.dart';
import 'package:sales_tracker/utils/widgets/custom_text.dart';

class EventListPage extends StatefulWidget {
  final bool? bottomNav;

  const EventListPage({super.key, this.bottomNav});

  @override
  _EventListPageState createState() => _EventListPageState();
}

class _EventListPageState extends State<EventListPage> {
  final ScrollController _scrollController = ScrollController();
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _startDate = DateTime(now.year, now.month, 1);
    _endDate = DateTime(now.year, now.month + 1, 0);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        Provider.of<EventsProvider>(context, listen: false)
            .loadMoreEvents(
          context,
          startDate: _startDate,
          endDate: _endDate,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? _startDate ?? DateTime.now() : _endDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localAuthProvider = Provider.of<LocalAutProvider>(context);
    final user = localAuthProvider.getUser();
    if (user == null) {
      return const LoginPage();
    }

    return ChangeNotifierProvider(
      create: (context) => EventsProvider(context),
      child: Consumer<EventsProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            backgroundColor: white,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(55.h),
              child: const CustomAppBar(appBarName: 'Event Reports'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDateSelectors(),
                  const SizedBox(height: 16),
                  _buildSearchButton(provider),
                  const SizedBox(height: 16),
                  provider.isLoading && provider.eventListResponse == null
                      ? const Center(child: CircularProgressIndicator())
                      : Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columns: _createColumns(),
                              rows: _createRows(provider.eventListResponse?.data ?? []),
                              columnSpacing: 15.0,
                              dataRowHeight: 25,
                            ),
                          ),
                        ),
                  if (provider.isLoading && provider.eventListResponse != null)
                    const Center(child: CircularProgressIndicator()),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDateSelectors() {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => _selectDate(context, true),
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: 'Start Date',
                suffixIcon: const Icon(Icons.calendar_today),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                _startDate == null
                    ? ''
                    : DateFormat('yyyy-MM-dd').format(_startDate!),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: InkWell(
            onTap: () => _selectDate(context, false),
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: 'End Date',
                suffixIcon: const Icon(Icons.calendar_today),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                _endDate == null
                    ? ''
                    : DateFormat('yyyy-MM-dd').format(_endDate!),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchButton(EventsProvider provider) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              provider.fetchEvents(
                context,
                startDate: _startDate,
                endDate: _endDate,
              );
            },
            child: const Text('Search'),
          ),
        ),
      ],
    );
  }

List<DataColumn> _createColumns() {
  return const [
    DataColumn(
      label: CustomText(
          text: 'Date', fontWeight: FontWeight.bold, fontSize: 12),
    ),
    DataColumn(
      label: CustomText(
          text: 'Event Name', fontWeight: FontWeight.bold, fontSize: 12),
    ),
    DataColumn(
      label: CustomText(
          text: 'Description', fontWeight: FontWeight.bold, fontSize: 12),
    ),
    DataColumn(
      label: CustomText(
          text: 'Location', fontWeight: FontWeight.bold, fontSize: 12),
    ),
    DataColumn(
      label: CustomText(
          text: 'Event Type', fontWeight: FontWeight.bold, fontSize: 12),
    ),
    DataColumn(
      label: CustomText(
          text: 'Created At', fontWeight: FontWeight.bold, fontSize: 12),
    ),
  ];
}


List<DataRow> _createRows(List<Event> data) {
  return data.map((event) {
    return DataRow(
      cells: [
        DataCell(CustomText(text: DateFormat('yyyy-MM-dd').format(event.date), fontSize: 10)),
        DataCell(CustomText(text: event.title ?? '', fontSize: 10)),
        DataCell(CustomText(text: event.description ?? '', fontSize: 10)),
        DataCell(CustomText(text: event.location ?? '', fontSize: 10)),
        DataCell(CustomText(text: event.eventType ?? '', fontSize: 10)),
        DataCell(CustomText(text: DateFormat('yyyy-MM-dd').format(event.createdAt.toDateTime()), fontSize: 10)),
      ],
    );
  }).toList();
}


}
