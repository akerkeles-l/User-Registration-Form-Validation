import 'package:flutter/material.dart';
import '../models/book.dart';
import '../widgets/book_cover.dart';
import '../widgets/bottom_action_bar.dart';
import '../widgets/genre_chip.dart';

class BookDetailsScreen extends StatefulWidget {
  const BookDetailsScreen({
    super.key,
    required this.book,
    required this.initiallyFavorite,
    required this.onFavoriteChanged,
  });

  final Book book;
  final bool initiallyFavorite;
  final ValueChanged<bool> onFavoriteChanged;

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  late bool _isFavorite;
  bool _addedToCart = false;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.initiallyFavorite;
  }

  void _toggleFavorite() {
    setState(() => _isFavorite = !_isFavorite);
    widget.onFavoriteChanged(_isFavorite);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isFavorite ? 'Saved to Favorites' : 'Removed from Favorites'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _addToCart() {
    setState(() => _addedToCart = true);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pride of your shelf! Book added to cart.'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final book = widget.book;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Book Details',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            tooltip: _isFavorite ? 'Remove from favorites' : 'Add to favorites',
            onPressed: _toggleFavorite,
            icon: Icon(
              _isFavorite ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
              color: const Color(0xFF7B302F),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      bottomNavigationBar: BottomActionBar(
        price: book.price,
        added: _addedToCart,
        onAddToCart: _addToCart,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final coverHeight = constraints.maxWidth < 380 ? 230.0 : 270.0;
          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(22, 8, 22, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE9D5C1),
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: BookCover(
                          book: book,
                          width: 176,
                          height: coverHeight,
                          borderRadius: 15,
                        ),
                      ),
                      Positioned(
                        right: -10,
                        top: 12,
                        child: Material(
                          color: const Color(0xFFFFFAF4),
                          elevation: 2,
                          shape: const CircleBorder(),
                          child: IconButton(
                            tooltip: _isFavorite ? 'Saved' : 'Save book',
                            onPressed: _toggleFavorite,
                            icon: Icon(
                              _isFavorite ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                              color: const Color(0xFF7B302F),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: -9,
                        bottom: 14,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                          decoration: BoxDecoration(
                            color: const Color(0xFF7B8060),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Text(
                            'EDITOR’S PICK',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Text(
                  book.title,
                  style: const TextStyle(
                    color: Color(0xFF7B302F),
                    fontSize: 29,
                    height: 1.12,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  'by ${book.author}',
                  style: const TextStyle(
                    color: Color(0xFF8B796A),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    const Icon(Icons.star_rounded, color: Color(0xFFD7A84B), size: 21),
                    const SizedBox(width: 5),
                    Text(
                      '${book.rating} / 5.0',
                      style: const TextStyle(color: Color(0xFF7B302F), fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(width: 10),
                    Container(width: 1, height: 16, color: const Color(0xFFD8C5B2)),
                    const SizedBox(width: 10),
                    Text('${book.pages} pages', style: const TextStyle(color: Color(0xFF8B796A), fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 19),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: book.genres.map((genre) => GenreChip(label: genre)).toList(),
                ),
                const SizedBox(height: 23),
                const Text(
                  'About this book',
                  style: TextStyle(color: Color(0xFF7B302F), fontSize: 18, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 8),
                Text(
                  book.description,
                  style: const TextStyle(color: Color(0xFF6F5A4B), fontSize: 14, height: 1.65),
                ),
                const SizedBox(height: 22),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE9D5C1),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_month_rounded, color: Color(0xFF7B302F)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'First published in ${book.year}',
                          style: const TextStyle(color: Color(0xFF7B302F), fontWeight: FontWeight.w700),
                        ),
                      ),
                      const Icon(Icons.auto_awesome_rounded, color: Color(0xFFB86F50)),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          );
        },
      ),
    );
  }
}
