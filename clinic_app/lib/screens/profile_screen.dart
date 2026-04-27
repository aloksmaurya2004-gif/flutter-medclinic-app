import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.w700, fontSize: 20),
        ),
        backgroundColor: AppTheme.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: AppTheme.dark),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile header
            Container(
              padding: const EdgeInsets.all(28),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0284C7), Color(0xFF38BDF8)],
                ),
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 48,
                        backgroundColor: AppTheme.white.withOpacity(0.3),
                        child: const Icon(Icons.person, size: 56, color: AppTheme.white),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: AppTheme.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.camera_alt, size: 14, color: AppTheme.primary),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'John Doe',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.white,
                    ),
                  ),
                  Text(
                    'john.doe@email.com',
                    style: GoogleFonts.dmSans(
                      fontSize: 13,
                      color: AppTheme.white.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _ProfileStat('5', 'Appointments'),
                      _ProfileStat('2', 'Doctors'),
                      _ProfileStat('3', 'Prescriptions'),
                    ],
                  ),
                ],
              ),
            ),
            // Menu items
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Health Records',
                    style: GoogleFonts.dmSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.grey,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _MenuGroup([
                    _MenuItem(Icons.calendar_month_outlined, 'Appointments', 'View history'),
                    _MenuItem(Icons.receipt_long_outlined, 'Medical Records', 'Documents & reports'),
                    _MenuItem(Icons.medication_outlined, 'Prescriptions', 'Active medications'),
                  ]),
                  const SizedBox(height: 20),
                  Text(
                    'Account',
                    style: GoogleFonts.dmSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.grey,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _MenuGroup([
                    _MenuItem(Icons.person_outline, 'Personal Info', 'Edit profile details'),
                    _MenuItem(Icons.notifications_outlined, 'Notifications', 'Manage alerts'),
                    _MenuItem(Icons.shield_outlined, 'Privacy & Security', 'Account safety'),
                    _MenuItem(Icons.help_outline, 'Help & Support', 'FAQs & contact'),
                  ]),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.logout, color: AppTheme.danger, size: 18),
                      label: Text(
                        'Sign Out',
                        style: GoogleFonts.dmSans(
                          color: AppTheme.danger,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppTheme.danger),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _ProfileStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.playfairDisplay(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppTheme.white,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.dmSans(
            fontSize: 11,
            color: AppTheme.white.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _MenuGroup(List<Widget> items) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        children: items.asMap().entries.map((entry) {
          final isLast = entry.key == items.length - 1;
          return Column(
            children: [
              entry.value,
              if (!isLast) const Divider(height: 0, indent: 56),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _MenuItem(this.icon, this.title, this.subtitle);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppTheme.primaryLight,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, size: 18, color: AppTheme.primary),
      ),
      title: Text(
        title,
        style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.dark),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.dmSans(fontSize: 12, color: AppTheme.grey),
      ),
      trailing: const Icon(Icons.chevron_right, color: AppTheme.grey, size: 18),
      onTap: () {},
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }
}
