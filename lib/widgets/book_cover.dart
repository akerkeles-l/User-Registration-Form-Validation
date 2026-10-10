import 'package:flutter/material.dart';
import '../models/book.dart';

class BookCover extends StatelessWidget {
  const BookCover({
    super.key,
    required this.book,
    this.width,
    this.height,
    this.borderRadius = 14,
  });

  final Book book;
  final double? width;
  final double? height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: SizedBox(
        width: width,
        height: height,
        child: Image.network(
          book.coverUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _fallbackCover(),
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return _fallbackCover(showLoading: true);
          },
        ),
      ),
    );
  }

  Widget _fallbackCover({bool showLoading = false}) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Color(book.coverColor),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.menu_book_rounded, color: Color(0xFFFFE9C8), size: 32),
          const SizedBox(height: 12),
          Text(
            book.title,
            textAlign: TextAlign.center,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFFFFF5E8),
              fontSize: 15,
              fontWeight: FontWeight.w800,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            book.author,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: const TextStyle(color: Color(0xFFFFE9C8), fontSize: 10),
          ),
          if (showLoading) ...[
            const SizedBox(height: 10),
            const SizedBox(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Color(0xFFFFE9C8),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
