import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';

class AppointmentScreen extends StatefulWidget {
  final Doctor? doctor;
  const AppointmentScreen({super.key, this.doctor});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final _formKey = GlobalKey<FormState>();
  Doctor? _selectedDoctor;
  String _selectedDepartment = '';
  DateTime? _selectedDate;
  String? _selectedTime;
  int _currentStep = 0;

  final List<String> _timeSlots = [
    '9:00 AM',
    '9:30 AM',
    '10:00 AM',
    '10:30 AM',
    '11:00 AM',
    '11:30 AM',
    '2:00 PM',
    '2:30 PM',
    '3:00 PM',
    '3:30 PM',
    '4:00 PM',
    '4:30 PM',
  ];

  @override
  void initState() {
    super.initState();
    _selectedDoctor = widget.doctor;
    if (_selectedDoctor != null) {
      _selectedDepartment = _selectedDoctor!.specialty;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      appBar: AppBar(
        title: Text(
          'Book Appointment',
          style: GoogleFonts.playfairDisplay(
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        backgroundColor: AppTheme.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppTheme.dark),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Step indicator
          _StepIndicator(currentStep: _currentStep),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: [
                _Step1(
                  selectedDoctor: _selectedDoctor,
                  selectedDepartment: _selectedDepartment,
                  onDoctorSelected: (d) => setState(() => _selectedDoctor = d),
                  onDepartmentSelected: (d) =>
                      setState(() => _selectedDepartment = d),
                ),
                _Step2(
                  selectedDate: _selectedDate,
                  selectedTime: _selectedTime,
                  timeSlots: _timeSlots,
                  onDateSelected: (d) => setState(() => _selectedDate = d),
                  onTimeSelected: (t) => setState(() => _selectedTime = t),
                ),
                _Step3(
                  doctor: _selectedDoctor,
                  date: _selectedDate,
                  time: _selectedTime,
                ),
              ][_currentStep],
            ),
          ),
          // Navigation buttons
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.white,
              border: Border(top: BorderSide(color: AppTheme.border)),
            ),
            child: Row(
              children: [
                if (_currentStep > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => setState(() => _currentStep--),
                      child: const Text('Back'),
                    ),
                  ),
                if (_currentStep > 0) const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: _canProceed()
                        ? () {
                            if (_currentStep < 2) {
                              setState(() => _currentStep++);
                            } else {
                              _showConfirmation();
                            }
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      _currentStep < 2 ? 'Continue' : 'Confirm Booking',
                      style: GoogleFonts.dmSans(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _canProceed() {
    switch (_currentStep) {
      case 0:
        return _selectedDoctor != null;
      case 1:
        return _selectedDate != null && _selectedTime != null;
      case 2:
        return true;
      default:
        return false;
    }
  }

  void _showConfirmation() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: AppTheme.accentLight,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, size: 40, color: AppTheme.accent),
            ),
            const SizedBox(height: 20),
            Text(
              'Appointment Booked!',
              style: GoogleFonts.playfairDisplay(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Your appointment with ${_selectedDoctor?.name} has been confirmed.',
              style: GoogleFonts.dmSans(
                fontSize: 14,
                color: AppTheme.grey,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text('Done'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StepIndicator extends StatelessWidget {
  final int currentStep;
  const _StepIndicator({required this.currentStep});

  @override
  Widget build(BuildContext context) {
    final steps = ['Doctor', 'Date & Time', 'Review'];
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppTheme.border)),
      ),
      child: Row(
        children: List.generate(steps.length * 2 - 1, (i) {
          if (i.isOdd) {
            return Expanded(
              child: Container(
                height: 2,
                color: i ~/ 2 < currentStep
                    ? AppTheme.primary
                    : AppTheme.border,
              ),
            );
          }
          final step = i ~/ 2;
          final isActive = step == currentStep;
          final isDone = step < currentStep;
          return Column(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDone || isActive
                      ? AppTheme.primary
                      : AppTheme.lightGrey,
                  border: Border.all(
                    color: isActive ? AppTheme.primary : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: isDone
                      ? const Icon(Icons.check, size: 16, color: AppTheme.white)
                      : Text(
                          '${step + 1}',
                          style: GoogleFonts.dmSans(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: isActive ? AppTheme.white : AppTheme.grey,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                steps[step],
                style: GoogleFonts.dmSans(
                  fontSize: 11,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                  color: isActive ? AppTheme.primary : AppTheme.grey,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

// Step 1: Select Doctor
class _Step1 extends StatelessWidget {
  final Doctor? selectedDoctor;
  final String selectedDepartment;
  final ValueChanged<Doctor> onDoctorSelected;
  final ValueChanged<String> onDepartmentSelected;

  const _Step1({
    required this.selectedDoctor,
    required this.selectedDepartment,
    required this.onDoctorSelected,
    required this.onDepartmentSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Your Doctor',
          style: GoogleFonts.playfairDisplay(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppTheme.dark,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Choose from our experienced specialists',
          style: GoogleFonts.dmSans(fontSize: 14, color: AppTheme.grey),
        ),
        const SizedBox(height: 20),
        ...AppData.doctors.map((doctor) {
          final isSelected = selectedDoctor?.id == doctor.id;
          return GestureDetector(
            onTap: () => onDoctorSelected(doctor),
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.primaryLight : AppTheme.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? AppTheme.primary : AppTheme.border,
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      doctor.imageUrl,
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => Container(
                        width: 56,
                        height: 56,
                        color: AppTheme.primaryLight,
                        child: const Icon(
                          Icons.person,
                          color: AppTheme.primary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doctor.name,
                          style: GoogleFonts.dmSans(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.dark,
                          ),
                        ),
                        Text(
                          doctor.specialty,
                          style: GoogleFonts.dmSans(
                            fontSize: 12,
                            color: AppTheme.primary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              size: 13,
                              color: Color(0xFFF59E0B),
                            ),
                            Text(
                              ' ${doctor.rating} · ${doctor.yearsExperience}y exp',
                              style: GoogleFonts.dmSans(
                                fontSize: 11,
                                color: AppTheme.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (isSelected)
                    const Icon(
                      Icons.check_circle_rounded,
                      color: AppTheme.primary,
                    ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}

// Step 2: Pick date & time
class _Step2 extends StatefulWidget {
  final DateTime? selectedDate;
  final String? selectedTime;
  final List<String> timeSlots;
  final ValueChanged<DateTime> onDateSelected;
  final ValueChanged<String> onTimeSelected;

  const _Step2({
    required this.selectedDate,
    required this.selectedTime,
    required this.timeSlots,
    required this.onDateSelected,
    required this.onTimeSelected,
  });

  @override
  State<_Step2> createState() => _Step2State();
}

class _Step2State extends State<_Step2> {
  late DateTime _focusedMonth;
  late List<DateTime> _daysInMonth;

  @override
  void initState() {
    super.initState();
    _focusedMonth = DateTime.now();
    _generateDays();
  }

  void _generateDays() {
    final first = DateTime(_focusedMonth.year, _focusedMonth.month, 1);
    final last = DateTime(_focusedMonth.year, _focusedMonth.month + 1, 0);
    _daysInMonth = List.generate(
      last.day,
      (i) => DateTime(first.year, first.month, i + 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Date & Time',
          style: GoogleFonts.playfairDisplay(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppTheme.dark,
          ),
        ),
        const SizedBox(height: 20),
        // Month selector
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  _focusedMonth = DateTime(
                    _focusedMonth.year,
                    _focusedMonth.month - 1,
                  );
                  _generateDays();
                });
              },
              icon: const Icon(Icons.chevron_left, color: AppTheme.dark),
            ),
            Text(
              '${_monthName(_focusedMonth.month)} ${_focusedMonth.year}',
              style: GoogleFonts.dmSans(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppTheme.dark,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _focusedMonth = DateTime(
                    _focusedMonth.year,
                    _focusedMonth.month + 1,
                  );
                  _generateDays();
                });
              },
              icon: const Icon(Icons.chevron_right, color: AppTheme.dark),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 70,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _daysInMonth.length,
            itemBuilder: (_, i) {
              final day = _daysInMonth[i];
              final isPast = day.isBefore(
                DateTime(now.year, now.month, now.day),
              );
              final isSelected =
                  widget.selectedDate != null &&
                  widget.selectedDate!.day == day.day &&
                  widget.selectedDate!.month == day.month;

              return GestureDetector(
                onTap: isPast ? null : () => widget.onDateSelected(day),
                child: Container(
                  width: 50,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppTheme.primary
                        : (isPast ? AppTheme.lightGrey : AppTheme.white),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isSelected ? AppTheme.primary : AppTheme.border,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _dayName(day.weekday),
                        style: GoogleFonts.dmSans(
                          fontSize: 10,
                          color: isSelected
                              ? AppTheme.white.withOpacity(0.8)
                              : AppTheme.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${day.day}',
                        style: GoogleFonts.dmSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: isSelected
                              ? AppTheme.white
                              : (isPast
                                    ? AppTheme.grey.withOpacity(0.4)
                                    : AppTheme.dark),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Available Time Slots',
          style: GoogleFonts.dmSans(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppTheme.dark,
          ),
        ),
        const SizedBox(height: 14),
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 2.5,
          children: widget.timeSlots.map((time) {
            final isSelected = widget.selectedTime == time;
            return GestureDetector(
              onTap: () => widget.onTimeSelected(time),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.primary : AppTheme.lightGrey,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isSelected ? AppTheme.primary : AppTheme.border,
                  ),
                ),
                child: Text(
                  time,
                  style: GoogleFonts.dmSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? AppTheme.white : AppTheme.dark,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  String _monthName(int m) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[m - 1];
  }

  String _dayName(int w) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[w - 1];
  }
}

// Step 3: Review
class _Step3 extends StatelessWidget {
  final Doctor? doctor;
  final DateTime? date;
  final String? time;

  const _Step3({this.doctor, this.date, this.time});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Review & Confirm',
          style: GoogleFonts.playfairDisplay(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppTheme.dark,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Please review your appointment details',
          style: GoogleFonts.dmSans(fontSize: 14, color: AppTheme.grey),
        ),
        const SizedBox(height: 24),
        // Doctor summary
        if (doctor != null)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.primaryLight,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    doctor!.imageUrl,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => Container(
                      width: 60,
                      height: 60,
                      color: AppTheme.primaryLight,
                      child: const Icon(Icons.person),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor!.name,
                      style: GoogleFonts.dmSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.dark,
                      ),
                    ),
                    Text(
                      doctor!.specialty,
                      style: GoogleFonts.dmSans(
                        fontSize: 13,
                        color: AppTheme.primary,
                      ),
                    ),
                    Text(
                      '\$${doctor!.consultationFee.toInt()} consultation',
                      style: GoogleFonts.dmSans(
                        fontSize: 12,
                        color: AppTheme.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        const SizedBox(height: 16),
        // Date & time
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.lightGrey,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              _ReviewRow(
                icon: Icons.calendar_today,
                label: 'Date',
                value: date != null
                    ? '${date!.day}/${date!.month}/${date!.year}'
                    : 'Not selected',
              ),
              const Divider(height: 20),
              _ReviewRow(
                icon: Icons.access_time,
                label: 'Time',
                value: time ?? 'Not selected',
              ),
              const Divider(height: 20),
              _ReviewRow(
                icon: Icons.videocam_outlined,
                label: 'Type',
                value: 'In-Person Visit',
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Patient info fields
        Text(
          'Patient Information',
          style: GoogleFonts.dmSans(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppTheme.dark,
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          decoration: const InputDecoration(
            labelText: 'Full Name',
            prefixIcon: Icon(Icons.person_outline),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          decoration: const InputDecoration(
            labelText: 'Phone Number',
            prefixIcon: Icon(Icons.phone_outlined),
          ),
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 12),
        TextField(
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: 'Reason for visit (optional)',
            prefixIcon: Icon(Icons.notes),
            alignLabelWithHint: true,
          ),
        ),
      ],
    );
  }
}

class _ReviewRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ReviewRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppTheme.primary),
        const SizedBox(width: 12),
        Text(
          label,
          style: GoogleFonts.dmSans(fontSize: 13, color: AppTheme.grey),
        ),
        const Spacer(),
        Text(
          value,
          style: GoogleFonts.dmSans(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppTheme.dark,
          ),
        ),
      ],
    );
  }
}
