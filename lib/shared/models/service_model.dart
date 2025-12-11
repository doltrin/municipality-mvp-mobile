import 'package:flutter/material.dart';

/// Service model for municipal services
class ServiceModel {
  const ServiceModel({
    required this.id,
    required this.name,
    required this.nameGreek,
    required this.icon,
    required this.color,
    required this.category,
    this.description,
  });

  final String id;
  final String name;
  final String nameGreek;
  final IconData icon;
  final Color color;
  final String category;
  final String? description;
}

/// News article model
class NewsModel {
  const NewsModel({
    required this.id,
    required this.title,
    required this.summary,
    required this.category,
    required this.date,
    required this.imageUrl,
    this.isUrgent = false,
  });

  final String id;
  final String title;
  final String summary;
  final String category;
  final DateTime date;
  final String imageUrl;
  final bool isUrgent;
}

/// Request/Task model
class RequestModel {
  const RequestModel({
    required this.id,
    required this.title,
    required this.status,
    required this.date,
    required this.icon,
    this.description,
  });

  final String id;
  final String title;
  final String status;
  final DateTime date;
  final IconData icon;
  final String? description;
}
