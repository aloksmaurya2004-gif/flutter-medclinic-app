class Doctor {
  final String id;
  final String name;
  final String specialty;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final int yearsExperience;
  final bool isAvailable;
  final String nextAvailable;
  final String bio;
  final List<String> languages;
  final String education;
  final double consultationFee;

  const Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.yearsExperience,
    required this.isAvailable,
    required this.nextAvailable,
    required this.bio,
    required this.languages,
    required this.education,
    required this.consultationFee,
  });
}

class Department {
  final String id;
  final String name;
  final String description;
  final String icon;
  final String imageUrl;
  final int doctorCount;
  final List<String> services;
  final String color;

  const Department({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.imageUrl,
    required this.doctorCount,
    required this.services,
    required this.color,
  });
}

class Testimonial {
  final String id;
  final String name;
  final String review;
  final double rating;
  final String date;
  final String avatarUrl;
  final String department;

  const Testimonial({
    required this.id,
    required this.name,
    required this.review,
    required this.rating,
    required this.date,
    required this.avatarUrl,
    required this.department,
  });
}

class Service {
  final String id;
  final String name;
  final String description;
  final String icon;
  final String color;

  const Service({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
  });
}

// ─── Sample Data ──────────────────────────────────────────────────────────────

class AppData {
  static const List<Doctor> doctors = [
    Doctor(
      id: '1',
      name: 'Dr. Amanda Foster',
      specialty: 'Cardiology Specialist',
      imageUrl: 'assets/images/doctors/doctor_1.png',
      rating: 4.9,
      reviewCount: 127,
      yearsExperience: 14,
      isAvailable: true,
      nextAvailable: 'Today 2:30 PM',
      bio: 'Board-certified cardiologist with expertise in interventional cardiology and heart failure management.',
      languages: ['English', 'Spanish'],
      education: 'Harvard Medical School',
      consultationFee: 150,
    ),
    Doctor(
      id: '2',
      name: 'Dr. Marcus Johnson',
      specialty: 'Neurology Expert',
      imageUrl: 'assets/images/doctors/doctor_2.png',
      rating: 4.8,
      reviewCount: 89,
      yearsExperience: 16,
      isAvailable: false,
      nextAvailable: 'Tomorrow 10:00 AM',
      bio: 'Specialist in neurodegenerative diseases, epilepsy, and complex neurological disorders.',
      languages: ['English', 'French'],
      education: 'Johns Hopkins University',
      consultationFee: 180,
    ),
    Doctor(
      id: '3',
      name: 'Dr. Rachel Williams',
      specialty: 'Pediatrics Care',
      imageUrl: 'assets/images/doctors/doctor_3.png',
      rating: 5.0,
      reviewCount: 203,
      yearsExperience: 11,
      isAvailable: true,
      nextAvailable: 'Today 4:00 PM',
      bio: 'Dedicated pediatrician with special interest in child development and adolescent medicine.',
      languages: ['English'],
      education: 'Stanford University',
      consultationFee: 120,
    ),
    Doctor(
      id: '4',
      name: 'Dr. David Chen',
      specialty: 'Orthopedic Surgery',
      imageUrl: 'assets/images/doctors/doctor_4.png',
      rating: 4.7,
      reviewCount: 156,
      yearsExperience: 22,
      isAvailable: false,
      nextAvailable: 'Mon 9:00 AM',
      bio: 'Expert in minimally invasive joint replacement and sports injury rehabilitation.',
      languages: ['English', 'Mandarin'],
      education: 'Mayo Clinic School of Medicine',
      consultationFee: 200,
    ),
    Doctor(
      id: '5',
      name: 'Dr. Victoria Torres',
      specialty: 'Dermatology Care',
      imageUrl: 'assets/images/doctors/doctor_5.png',
      rating: 4.5,
      reviewCount: 74,
      yearsExperience: 9,
      isAvailable: true,
      nextAvailable: 'Today 3:15 PM',
      bio: 'Cosmetic and medical dermatologist specializing in skin cancer detection and anti-aging treatments.',
      languages: ['English', 'Portuguese'],
      education: 'UCLA School of Medicine',
      consultationFee: 130,
    ),
    Doctor(
      id: '6',
      name: 'Dr. Benjamin Lee',
      specialty: 'Oncology Treatment',
      imageUrl: 'assets/images/doctors/doctor_6.png',
      rating: 4.9,
      reviewCount: 194,
      yearsExperience: 19,
      isAvailable: true,
      nextAvailable: 'Today 5:00 PM',
      bio: 'Pioneering oncologist focused on precision medicine, immunotherapy, and personalized cancer care.',
      languages: ['English', 'Korean'],
      education: 'Memorial Sloan Kettering',
      consultationFee: 220,
    ),
  ];

  static const List<Department> departments = [
    Department(
      id: '1',
      name: 'Cardiovascular',
      description: 'Advanced diagnostic imaging and interventional procedures for comprehensive heart health management.',
      icon: '❤️',
      imageUrl: 'assets/images/departments/department_1.png',
      doctorCount: 8,
      services: ['24/7 Emergency Cardiac Care', 'Minimally Invasive Procedures', 'Echocardiography', 'Stress Testing'],
      color: '#FEE2E2',
    ),
    Department(
      id: '2',
      name: 'Neurology',
      description: 'Cutting-edge neuroimaging and neurosurgical expertise for complex brain and spinal cord conditions.',
      icon: '🧠',
      imageUrl: 'assets/images/departments/department_2.png',
      doctorCount: 6,
      services: ['Advanced Brain Imaging', 'Robotic Surgery', 'EEG Monitoring', 'Stroke Care'],
      color: '#EDE9FE',
    ),
    Department(
      id: '3',
      name: 'Orthopedics',
      description: 'Comprehensive musculoskeletal care utilizing advanced arthroscopic techniques and joint replacement.',
      icon: '🦴',
      imageUrl: 'assets/images/departments/department_3.png',
      doctorCount: 10,
      services: ['Sports Medicine', 'Joint Replacement', 'Spine Surgery', 'Physical Therapy'],
      color: '#FEF3C7',
    ),
    Department(
      id: '4',
      name: 'Pediatrics',
      description: 'Child-centered healthcare services from newborn to adolescence with family-focused treatment.',
      icon: '👶',
      imageUrl: 'assets/images/departments/department_4.png',
      doctorCount: 12,
      services: ['Neonatal Intensive Care', 'Developmental Pediatrics', 'Vaccination', 'Pediatric Surgery'],
      color: '#DCFCE7',
    ),
    Department(
      id: '5',
      name: 'Oncology',
      description: 'Multidisciplinary oncology program offering personalized cancer care with latest therapeutic innovations.',
      icon: '🔬',
      imageUrl: 'assets/images/departments/department_5.png',
      doctorCount: 7,
      services: ['Precision Medicine', 'Immunotherapy', 'Radiation Oncology', 'Palliative Care'],
      color: '#CFFAFE',
    ),
    Department(
      id: '6',
      name: 'Dermatology',
      description: 'Expert skin care for cosmetic and medical conditions using the latest dermatological treatments.',
      icon: '🫁',
      imageUrl: 'assets/images/departments/department_6.png',
      doctorCount: 5,
      services: ['Skin Cancer Screening', 'Cosmetic Procedures', 'Laser Therapy', 'Allergy Testing'],
      color: '#FFE4E6',
    ),
  ];

  static const List<Testimonial> testimonials = [
    Testimonial(
      id: '1',
      name: 'Sarah Mitchell',
      review: 'Dr. Foster is absolutely exceptional. She explained my condition thoroughly and made me feel at ease throughout the entire process. The clinic staff was warm and professional.',
      rating: 5.0,
      date: 'March 2024',
      avatarUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100&h=100&fit=crop',
      department: 'Cardiology',
    ),
    Testimonial(
      id: '2',
      name: 'James Rodriguez',
      review: 'World-class facilities and an incredibly compassionate team. Dr. Johnson took the time to listen to all my concerns. I highly recommend this clinic to anyone seeking quality neurological care.',
      rating: 5.0,
      date: 'February 2024',
      avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&h=100&fit=crop',
      department: 'Neurology',
    ),
    Testimonial(
      id: '3',
      name: 'Emily Chen',
      review: 'My daughter was treated by Dr. Williams and she was absolutely wonderful with children. Patient, caring, and extremely knowledgeable. We won\'t go anywhere else for pediatric care.',
      rating: 5.0,
      date: 'January 2024',
      avatarUrl: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=100&h=100&fit=crop',
      department: 'Pediatrics',
    ),
  ];

  static const List<Service> services = [
    Service(id: '1', name: 'Emergency Care', description: '24/7 critical emergency medical services', icon: '🚨', color: '#FEE2E2'),
    Service(id: '2', name: 'Diagnostics Lab', description: 'State-of-the-art diagnostic testing', icon: '🧪', color: '#EDE9FE'),
    Service(id: '3', name: 'Surgery Center', description: 'Advanced minimally invasive surgeries', icon: '⚕️', color: '#DCFCE7'),
    Service(id: '4', name: 'Maternal Care', description: 'Expert pregnancy & delivery support', icon: '🤱', color: '#FEF3C7'),
    Service(id: '5', name: 'Vaccination', description: 'Complete immunization programs', icon: '💉', color: '#CFFAFE'),
    Service(id: '6', name: 'Physiotherapy', description: 'Rehabilitation and physical therapy', icon: '🏃', color: '#FFE4E6'),
  ];
}
