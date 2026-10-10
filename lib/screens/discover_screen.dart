import 'package:flutter/material.dart';
import '../models/book.dart';
import '../widgets/book_card.dart';
import '../widgets/book_cover.dart';
import '../widgets/genre_chip.dart';
import 'book_details_screen.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final TextEditingController _searchController = TextEditingController();
  final Set<String> _favoriteTitles = {};
  String _selectedGenre = 'All';
  String _activeTab = 'Discover';

  final List<String> _genres = const [
    'All',
    'Romance',
    'Adventure',
    'Drama',
    'Mystery',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Book> get _visibleBooks {
    final query = _searchController.text.trim().toLowerCase();
    return classicBooks.where((book) {
      final matchesQuery = book.title.toLowerCase().contains(query) ||
          book.author.toLowerCase().contains(query);
      final matchesGenre = _selectedGenre == 'All' ||
          book.genres.any((genre) => genre.toLowerCase() == _selectedGenre.toLowerCase());
      final matchesTab = _activeTab != 'Favorites' || _favoriteTitles.contains(book.title);
      return matchesQuery && matchesGenre && matchesTab;
    }).toList();
  }

  void _toggleFavorite(Book book) {
    setState(() {
      if (_favoriteTitles.contains(book.title)) {
        _favoriteTitles.remove(book.title);
      } else {
        _favoriteTitles.add(book.title);
      }
    });
  }

  Future<void> _openBook(Book book) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BookDetailsScreen(
          book: book,
          initiallyFavorite: _favoriteTitles.contains(book.title),
          onFavoriteChanged: (isFavorite) {
            setState(() {
              if (isFavorite) {
                _favoriteTitles.add(book.title);
              } else {
                _favoriteTitles.remove(book.title);
              }
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final books = _visibleBooks;
    final featuredBook = classicBooks.first;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 42,
                          width: 42,
                          decoration: BoxDecoration(
                            color: const Color(0xFF7B302F),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(Icons.auto_stories_rounded, color: Color(0xFFFFE9C8)),
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'CHAPTER',
                                style: TextStyle(
                                  color: Color(0xFF7B302F),
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 2.1,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                'A little world of classics',
                                style: TextStyle(color: Color(0xFF8B796A), fontSize: 11),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFAF4),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(Icons.wb_twilight_rounded, color: Color(0xFFB86F50)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    const Text('Slow down.', style: TextStyle(color: Color(0xFFB86F50), fontSize: 14, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 4),
                    const Text(
                      'Find your next\\nchapter.',
                      style: TextStyle(
                        color: Color(0xFF7B302F),
                        fontSize: 32,
                        height: 1.08,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 18),
                    TextField(
                      controller: _searchController,
                      onChanged: (_) => setState(() {}),
                      decoration: InputDecoration(
                        hintText: 'Search classic books...',
                        hintStyle: const TextStyle(color: Color(0xFF9B8A7A), fontSize: 13),
                        prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFF7B8060)),
                        filled: true,
                        fillColor: const Color(0xFFFFFAF4),
                        contentPadding: const EdgeInsets.symmetric(vertical: 15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(17),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    const Text('Browse by mood', style: TextStyle(color: Color(0xFF7B302F), fontSize: 17, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 38,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _genres.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 8),
                        itemBuilder: (context, index) {
                          final genre = _genres[index];
                          return GestureDetector(
                            onTap: () => setState(() => _selectedGenre = genre),
                            child: GenreChip(label: genre, selected: _selectedGenre == genre),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Book of the Day', style: TextStyle(color: Color(0xFF7B302F), fontSize: 18, fontWeight: FontWeight.w800)),
                        Text('HANDPICKED', style: TextStyle(color: Color(0xFFB86F50), fontSize: 9, fontWeight: FontWeight.w900, letterSpacing: 1.2)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    InkWell(
                      onTap: () => _openBook(featuredBook),
                      borderRadius: BorderRadius.circular(22),
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE9D5C1),
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: Row(
                          children: [
                            BookCover(book: featuredBook, width: 100, height: 135, borderRadius: 12),
                            const SizedBox(width: 14),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('THE AUTUMN EDITION', style: TextStyle(color: Color(0xFFB86F50), fontSize: 9, fontWeight: FontWeight.w900, letterSpacing: 1.1)),
                                  SizedBox(height: 8),
                                  Text('Pride and\\nPrejudice', style: TextStyle(color: Color(0xFF7B302F), fontSize: 20, fontWeight: FontWeight.w900, height: 1.1)),
                                  SizedBox(height: 5),
                                  Text('Jane Austen', style: TextStyle(color: Color(0xFF6F5A4B), fontSize: 12)),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Icon(Icons.star_rounded, color: Color(0xFFD7A84B), size: 17),
                                      SizedBox(width: 4),
                                      Text('4.8  ·  A timeless classic', style: TextStyle(color: Color(0xFF6F5A4B), fontSize: 10, fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.arrow_outward_rounded, color: Color(0xFF7B302F)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _activeTab == 'Favorites' ? 'Your Favorites' : 'Classics for Autumn',
                          style: const TextStyle(color: Color(0xFF7B302F), fontSize: 18, fontWeight: FontWeight.w800),
                        ),
                        Text('${books.length} books', style: const TextStyle(color: Color(0xFF8B796A), fontSize: 11)),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
            if (books.isEmpty)
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 35),
                  child: Center(
                    child: Text(
                      'No books found. Try another search or save a favorite.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xFF8B796A)),
                    ),
                  ),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 210,
                    mainAxisExtent: 300,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final book = books[index];
                      return BookCard(
                        book: book,
                        isFavorite: _favoriteTitles.contains(book.title),
                        onTap: () => _openBook(book),
                        onFavoriteTap: () => _toggleFavorite(book),
                      );
                    },
                    childCount: books.length,
                  ),
                ),
              ),
            const SliverToBoxAdapter(child: SizedBox(height: 18)),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: const BoxDecoration(
            color: Color(0xFFFFFAF4),
            border: Border(top: BorderSide(color: Color(0xFFE8D8C8))),
          ),
          child: Row(
            children: [
              _NavItem(
                icon: Icons.explore_rounded,
                label: 'Discover',
                selected: _activeTab == 'Discover',
                onTap: () => setState(() => _activeTab = 'Discover'),
              ),
              _NavItem(
                icon: Icons.menu_book_rounded,
                label: 'My Books',
                selected: _activeTab == 'My Books',
                onTap: () {
                  setState(() => _activeTab = 'My Books');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Your reading shelf is coming soon.')),
                  );
                },
              ),
              _NavItem(
                icon: Icons.bookmark_rounded,
                label: 'Favorites',
                selected: _activeTab == 'Favorites',
                onTap: () => setState(() => _activeTab = 'Favorites'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 7),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: selected ? const Color(0xFF7B302F) : const Color(0xFFAA9A8A), size: 21),
              const SizedBox(height: 3),
              Text(
                label,
                style: TextStyle(
                  color: selected ? const Color(0xFF7B302F) : const Color(0xFFAA9A8A),
                  fontSize: 10,
                  fontWeight: selected ? FontWeight.w800 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
