import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jr_case_boilerplate/core/routes/app_routes.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String id;
  final String photoUrl;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.id,
    required this.photoUrl,
  });

  static const Color primaryDark = Color(0xFF6F060B);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: primaryDark,
          backgroundImage: photoUrl.isNotEmpty ? NetworkImage(photoUrl) : null,
          child: photoUrl.isEmpty
              ? const Icon(Icons.person, color: Colors.white, size: 30)
              : null,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'ID: $id',
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
        ),
        Builder(
          builder: (context) {
            return TextButton(
              onPressed: () {
                context.go(AppRoutes.uploadPhoto);
              },
              child: const Text(
                'Fotoğraf Ekle',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            );
          },
        ),
      ],
    );
  }
}
