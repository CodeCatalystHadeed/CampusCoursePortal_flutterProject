import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../theme/app_theme.dart';
import '../widgets/app_widgets.dart';

class DetailScreen extends StatelessWidget {
  final SubjectModel subject;

  const DetailScreen({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    final subjectColor = Color(subject.colorValue);

    return Scaffold(
      appBar: AppBar(title: const Text('Subject Detail')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 8, 22, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  gradient: LinearGradient(
                    colors: [subjectColor, AppColors.primaryDark],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Center(child: Text(subject.iconEmoji, style: const TextStyle(fontSize: 34))),
                    ),
                    const SizedBox(height: 26),
                    Text(
                      subject.name,
                      style: const TextStyle(fontSize: 29, fontWeight: FontWeight.w900, color: Colors.white, height: 1.05),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${subject.code} - ${subject.instructor}',
                      style: const TextStyle(color: AppColors.sand, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _InfoCard(
                icon: Icons.description_outlined,
                title: 'Course Overview',
                color: subjectColor,
                child: Text(
                  subject.description,
                  style: const TextStyle(fontSize: 15, height: 1.55, color: AppColors.ink),
                ),
              ),
              const SizedBox(height: 16),
              _InfoCard(
                icon: Icons.flag_outlined,
                title: 'Objectives',
                color: subjectColor,
                child: Text(
                  subject.objectives,
                  style: const TextStyle(fontSize: 15, height: 1.55, color: AppColors.ink),
                ),
              ),
              const SizedBox(height: 16),
              _InfoCard(
                icon: Icons.schedule_rounded,
                title: 'Schedule Details',
                color: subjectColor,
                child: Text(
                  subject.schedule,
                  style: const TextStyle(fontSize: 15.5, height: 1.6, fontWeight: FontWeight.w700, color: AppColors.ink),
                ),
              ),
              const SizedBox(height: 22),
              OutlinedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_rounded),
                label: const Text('Back to Dashboard'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.primary),
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final Widget child;

  const _InfoCard({required this.icon, required this.title, required this.color, required this.child});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 10),
              Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.ink)),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}
