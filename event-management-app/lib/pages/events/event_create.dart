import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:sales_tracker/data/porvider/event_create_provider.dart';
import 'package:sales_tracker/utils/theme/app_colors.dart';
import 'package:sales_tracker/utils/widgets/custom_text.dart';
import 'package:sales_tracker/utils/widgets/custom_title_form_field.dart';

class EventCreatePage extends StatelessWidget {
  final bool? bottomNav;
  const EventCreatePage({super.key, this.bottomNav});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EventCreateProvider(),
      child: Scaffold(
        body: Consumer<EventCreateProvider>(
          builder: (context, p, _) {
            return Form(
              key: p.formKey,
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        // Title field
                        CustomTitleFromField(
                          title: 'Title',
                          hintText: 'Enter event title',
                          controller: p.titleController,
                          errorText: p.titleError, // Show the title error
                        ),
                        SizedBox(height: 5.h),

                        // Description field
                        CustomTitleFromField(
                          title: 'Description',
                          hintText: 'Enter event description',
                          controller: p.descriptionController,
                          errorText: p.descriptionError, // Show the description error
                        ),
                        SizedBox(height: 5.h),

                        // Date field
                        TextFormField(
                          controller: p.dateController,
                          decoration: InputDecoration(
                            labelText: 'Date',
                            hintText: 'Select event date',
                            errorText: p.dateError, // Show the date error
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                          onTap: () async {
                            FocusScope.of(context).requestFocus(FocusNode()); // Hide keyboard
                            DateTime? selectedDate = await showDatePicker(
                              context: context,
                              initialDate: p.selectedDate ?? DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100),
                            );
                            if (selectedDate != null && selectedDate != p.selectedDate) {
                              p.selectedDate = selectedDate;
                              p.dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
                            }
                          },
                          validator: (value) => p.selectedDate == null ? 'Please select a date' : null,
                        ),
                        SizedBox(height: 5.h),

                        // Location field
                        CustomTitleFromField(
                          title: 'Location',
                          hintText: 'Enter event location',
                          controller: p.locationController,
                          errorText: p.locationError, // Show the location error
                        ),
                        SizedBox(height: 5.h),

                        // Organizer field
                        CustomTitleFromField(
                          title: 'Organizer',
                          hintText: 'Enter organizer name',
                          controller: p.organizerController,
                          errorText: p.organizerError, // Show the organizer error
                        ),
                        SizedBox(height: 5.h),

                        // Event Type field
                        CustomTitleFromField(
                          title: 'Event Type',
                          hintText: 'Enter event type',
                          controller: p.eventTypeController,
                          errorText: p.eventTypeError, // Show the event type error
                        ),
                        SizedBox(height: 20.h),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(0.0),
                                elevation: 5,
                              ),
                              onPressed: p.isLoading
                                  ? null
                                  : () {
                                      if (p.formKey.currentState!.validate()) {
                                        p.submit(context);
                                      }
                                    },
                              child: p.isLoading
                                  ? const CircularProgressIndicator()
                                  : Ink(
                                      decoration: BoxDecoration(
                                          gradient: const LinearGradient(colors: [
                                            Color(0xffFF5A70),
                                            Color(0xffB50820),
                                            Color(0xffFF5A70)
                                          ], tileMode: TileMode.decal),
                                          borderRadius: BorderRadius.circular(4)),
                                      child: const SizedBox(
                                          height: 45,
                                          width: 120,
                                          child: Center(
                                            child: Text('Submit',
                                                style: TextStyle(color: Colors.white),
                                                textAlign: TextAlign.center),
                                          )),
                                    ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 10.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
