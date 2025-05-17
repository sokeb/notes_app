import 'package:equatable/equatable.dart';

final class NoteModel extends Equatable {
  final String id;
  final String title;
  final String description;

  const NoteModel({
    required this.id,
    required this.title,
    required this.description,
  });

  factory NoteModel.fromFirestore(dynamic doc) {
    return NoteModel(
      id: doc.id,
      title: doc['title'] ?? '',
      description: doc['description'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'title': title, 'description': description};
  }

  NoteModel copyWith({String? id, String? title, String? description}) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  @override
  List<Object> get props => [id, title, description];
}
