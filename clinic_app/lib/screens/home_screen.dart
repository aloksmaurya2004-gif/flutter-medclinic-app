import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';
import 'appointment_screen.dart';
import 'doctors_screen.dart';
import 'departments_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _HeroSliver(),
          SliverToBoxAdapter(
            child: Column(
              children: [
                _StatsSection(),
                _ServicesSection(context),
                _DepartmentsSection(context),
                _DoctorsSection(context),
                _TestimonialsSection(),
                _EmergencyBanner(context),
                _CTASection(context),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Hero ──────────────────────────────────────────────────────────────────────
class _HeroSliver extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 520,
      pinned: true,
      backgroundColor: AppTheme.primary,
      leading: Padding(
        padding: const EdgeInsets.all(8),
        child: Image.network(
          'https://via.placeholder.com/40x40',
          errorBuilder: (_, _, _) =>
              const Icon(Icons.local_hospital, color: AppTheme.white),
        ),
      ),
      title: Text(
        'MedClinic',
        style: GoogleFonts.playfairDisplay(
          color: AppTheme.white,
          fontWeight: FontWeight.w700,
          fontSize: 22,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: AppTheme.white),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.notifications_outlined, color: AppTheme.white),
          onPressed: () {},
        ),
        const SizedBox(width: 8),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Gradient bg
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF0284C7),
                    Color(0xFF0EA5E9),
                    Color(0xFF38BDF8),
                  ],
                ),
              ),
            ),
            // Decorative circles
            Positioned(
              top: -60,
              right: -60,
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.white.withOpacity(0.06),
                ),
              ),
            ),
            Positioned(
              bottom: 80,
              left: -40,
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.white.withOpacity(0.06),
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 100, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Badges
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _HeroBadge('✓ Accredited'),
                        const SizedBox(width: 8),
                        _HeroBadge('24/7 Emergency'),
                        const SizedBox(width: 8),
                        _HeroBadge('⭐ 4.9/5'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Excellence in\nHealthcare\nWith Compassion',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 34,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.white,
                      height: 1.15,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'World-class medical care from top specialists, tailored to your unique needs.',
                    style: GoogleFonts.dmSans(
                      fontSize: 14,
                      color: AppTheme.white.withOpacity(0.85),
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AppointmentScreen(),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.white,
                          foregroundColor: AppTheme.primary,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Book Appointment',
                          style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppTheme.white,
                          side: const BorderSide(
                            color: AppTheme.white,
                            width: 1.5,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Emergency',
                          style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Next available doctor card
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppTheme.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: AppTheme.white.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundImage: NetworkImage(
                            AppData.doctors[0].imageUrl,
                          ),
                          onBackgroundImageError: (_, _) {},
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Next Available',
                              style: GoogleFonts.dmSans(
                                fontSize: 10,
                                color: AppTheme.white.withOpacity(0.7),
                              ),
                            ),
                            Text(
                              AppData.doctors[0].nextAvailable,
                              style: GoogleFonts.dmSans(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.white,
                              ),
                            ),
                            Text(
                              AppData.doctors[0].name,
                              style: GoogleFonts.dmSans(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: AppTheme.white,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppTheme.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            size: 12,
                            color: AppTheme.white,
                          ),
                        ),
                      ],
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

  Widget _HeroBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppTheme.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.white.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: GoogleFonts.dmSans(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: AppTheme.white,
        ),
      ),
    );
  }
}

// ─── Stats Section ─────────────────────────────────────────────────────────────
class _StatsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0284C7), Color(0xFF0EA5E9)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withOpacity(0.3),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: StatCard(
                  value: '25',
                  label: 'Years Experience',
                  suffix: '+',
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: StatCard(
                  value: '50K',
                  label: 'Patients Treated',
                  suffix: '+',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Expanded(
                child: StatCard(
                  value: '120',
                  label: 'Medical Experts',
                  suffix: '+',
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: StatCard(
                  value: '4.9',
                  label: 'Average Rating',
                  suffix: '★',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Services Section ─────────────────────────────────────────────────────────
Widget _ServicesSection(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          label: 'OUR SERVICES',
          title: 'Featured Services',
          subtitle:
              'Comprehensive healthcare solutions tailored to your needs.',
        ),
        const SizedBox(height: 20),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.85,
          children: AppData.services
              .map((s) => ServiceTile(service: s))
              .toList(),
        ),
        const SizedBox(height: 32),
      ],
    ),
  );
}

// ─── Departments Section ──────────────────────────────────────────────────────
Widget _DepartmentsSection(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SectionHeader(
              label: 'SPECIALTIES',
              title: 'Featured\nDepartments',
            ),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DepartmentsScreen()),
              ),
              child: Text(
                'View All',
                style: GoogleFonts.dmSans(
                  color: AppTheme.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 16),
      SizedBox(
        height: 300,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: AppData.departments.length,
          itemBuilder: (_, i) => Padding(
            padding: const EdgeInsets.only(right: 14),
            child: SizedBox(
              width: 220,
              child: DepartmentCard(department: AppData.departments[i]),
            ),
          ),
        ),
      ),
      const SizedBox(height: 32),
    ],
  );
}

// ─── Doctors Section ──────────────────────────────────────────────────────────
Widget _DoctorsSection(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SectionHeader(label: 'OUR TEAM', title: 'Find A Doctor'),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DoctorsScreen()),
              ),
              child: Text(
                'View All',
                style: GoogleFonts.dmSans(
                  color: AppTheme.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 16),
      SizedBox(
        height: 300,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: AppData.doctors.length,
          itemBuilder: (_, i) => Padding(
            padding: const EdgeInsets.only(right: 14),
            child: SizedBox(
              width: 190,
              child: DoctorCard(
                doctor: AppData.doctors[i],
                compact: true,
                onTap: () {},
              ),
            ),
          ),
        ),
      ),
      const SizedBox(height: 32),
    ],
  );
}

// ─── Testimonials ─────────────────────────────────────────────────────────────
class _TestimonialsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.lightGrey,
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SectionHeader(
              label: 'TESTIMONIALS',
              title: 'What Patients Say',
              alignment: CrossAxisAlignment.center,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: AppData.testimonials.length,
              itemBuilder: (_, i) =>
                  TestimonialCard(testimonial: AppData.testimonials[i]),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Emergency Banner ─────────────────────────────────────────────────────────
Widget _EmergencyBanner(BuildContext context) {
  return Container(
    margin: const EdgeInsets.all(20),
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: AppTheme.danger,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppTheme.white.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.emergency, color: AppTheme.white, size: 28),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Need Immediate Assistance?',
                style: GoogleFonts.dmSans(
                  color: AppTheme.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
              Text(
                'Our emergency team is available 24/7.',
                style: GoogleFonts.dmSans(
                  color: AppTheme.white.withOpacity(0.85),
                  fontSize: 12,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.white,
            foregroundColor: AppTheme.danger,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Call Now',
            style: GoogleFonts.dmSans(
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
        ),
      ],
    ),
  );
}

// ─── CTA Section ─────────────────────────────────────────────────────────────
Widget _CTASection(BuildContext context) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20),
    padding: const EdgeInsets.all(28),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF0F172A), Color(0xFF1E3A5F)],
      ),
      borderRadius: BorderRadius.circular(24),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppTheme.primary.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'GET STARTED',
            style: GoogleFonts.dmSans(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppTheme.primary,
              letterSpacing: 1,
            ),
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'Excellence in\nMedical Care,\nEvery Day',
          style: GoogleFonts.playfairDisplay(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: AppTheme.white,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'Start your journey to better health with our world-class specialists.',
          style: GoogleFonts.dmSans(
            fontSize: 13,
            color: AppTheme.white.withOpacity(0.7),
            height: 1.6,
          ),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AppointmentScreen()),
              ),
              child: const Text('Schedule Now'),
            ),
            const SizedBox(width: 12),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.white,
                side: const BorderSide(color: AppTheme.white, width: 1.5),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Our Services',
                style: GoogleFonts.dmSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
