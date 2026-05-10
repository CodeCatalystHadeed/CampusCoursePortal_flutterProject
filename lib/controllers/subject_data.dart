import '../enums/app_enums.dart';
import '../models/user_model.dart';

class SubjectData {
  static final List<SubjectModel> subjects = [
    const SubjectModel(
      name: 'Mobile App Development',
      code: 'MAD-401',
      description:
          'This course introduces modern mobile application development using Flutter and Dart. Students learn to design responsive interfaces, manage state, validate forms, navigate between screens, and build maintainable cross-platform apps.',
      objectives:
          'Build structured Flutter applications, apply validation, use reusable widgets, manage navigation, and separate UI from business logic.',
      schedule: 'Monday & Wednesday\n10:00 AM - 11:30 AM\nRoom: CS-204',
      instructor: 'Dr. Sana Mirza',
      iconEmoji: '📱',
      colorValue: 0xFF4F6F52,
      category: SubjectCategory.technical,
    ),
    const SubjectModel(
      name: 'Software Re-engineering',
      code: 'SRE-301',
      description:
          'This course focuses on analyzing, improving, and restructuring existing software systems. Students study legacy systems, refactoring, reverse engineering, documentation recovery, and modernization strategies.',
      objectives:
          'Understand legacy systems, improve code quality, apply refactoring techniques, and plan safe software migration or modernization work.',
      schedule: 'Tuesday & Thursday\n2:00 PM - 3:30 PM\nRoom: CS-102',
      instructor: 'Prof. Ahmed Khan',
      iconEmoji: '🔧',
      colorValue: 0xFF9A6B4F,
      category: SubjectCategory.technical,
    ),
    const SubjectModel(
      name: 'Management Information Systems (MIS)',
      code: 'MIS-201',
      description:
          'This course explores how organizations use information systems to support decision-making, operations, reporting, and strategic planning. Topics include databases, ERP, business intelligence, cybersecurity, and digital transformation.',
      objectives:
          'Explain the role of information systems in organizations, evaluate MIS tools, and understand how data supports management decisions.',
      schedule: 'Friday\n9:00 AM - 12:00 PM\nRoom: BBA-301',
      instructor: 'Ms. Rabia Noor',
      iconEmoji: '📊',
      colorValue: 0xFF6C7A89,
      category: SubjectCategory.business,
    ),
  ];
}
