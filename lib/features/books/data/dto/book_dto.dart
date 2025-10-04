import '../../domain/model/book.dart';

/// API raw -> DTO -> Domain
class BookDto {
  final String? id;
  final String? title;
  final String? originalTitle;
  final String? releaseDate;
  final String? description;
  final int? pages;
  final String? cover;
  final int? index;

  BookDto({
    this.id,
    this.originalTitle,
    this.releaseDate,
    this.pages,
    this.title,
    this.description,
    this.cover,
    this.index
  });

  factory BookDto.fromJson(Map<String, dynamic> json) {
    return BookDto(
      id: json['id'] as String?,
      title: json['title'] as String?,
      originalTitle: json['originalTitle'] as String?,
      releaseDate: json['releaseDate'] as String?,
      description: json['description'] as String?,
      pages: json['pages'] as int?,
      cover: json['cover'] as String?,
      index: json['index'] as int?,
    );
  }

  Book toDomain() {
    return Book(
      id: id ?? "",
      title: title ?? "",
      originalTitle: originalTitle ?? "",
      releaseDate: releaseDate ?? "",
      description: description ?? "",
      pages: pages ?? 0,
      cover: cover ?? "",
      index: index ?? 0,
    );
  }
}
