class Book {
  const Book({
    required this.title,
    required this.author,
    required this.description,
    required this.rating,
    required this.price,
    required this.year,
    required this.pages,
    required this.genres,
    required this.coverUrl,
    required this.coverColor,
  });

  final String title;
  final String author;
  final String description;
  final double rating;
  final double price;
  final int year;
  final int pages;
  final List<String> genres;
  final String coverUrl;
  final int coverColor;
}

const classicBooks = <Book>[
  Book(
    title: 'Pride and Prejudice',
    author: 'Jane Austen',
    description:
        'Elizabeth Bennet navigates first impressions, family expectations, and unexpected love in Jane Austen’s beloved classic about wit, pride, and understanding.',
    rating: 4.8,
    price: 12.99,
    year: 1813,
    pages: 432,
    genres: ['Classic', 'Romance', 'Fiction'],
    coverUrl: 'https://covers.openlibrary.org/b/id/10587366-L.jpg',
    coverColor: 0xFF7B302F,
  ),
  Book(
    title: 'Jane Eyre',
    author: 'Charlotte Brontë',
    description:
        'An independent young woman searches for belonging, purpose, and love while holding firmly to her conscience and sense of self.',
    rating: 4.7,
    price: 11.50,
    year: 1847,
    pages: 500,
    genres: ['Classic', 'Drama', 'Romance'],
    coverUrl: 'https://covers.openlibrary.org/b/id/8231856-L.jpg',
    coverColor: 0xFF59634A,
  ),
  Book(
    title: 'Little Women',
    author: 'Louisa May Alcott',
    description:
        'The four March sisters grow up, dream, make mistakes, and discover what matters most in this warm story of family and becoming yourself.',
    rating: 4.9,
    price: 10.99,
    year: 1868,
    pages: 449,
    genres: ['Classic', 'Family', 'Drama'],
    coverUrl: 'https://covers.openlibrary.org/b/id/12645115-L.jpg',
    coverColor: 0xFFB86F50,
  ),
  Book(
    title: 'Wuthering Heights',
    author: 'Emily Brontë',
    description:
        'On the windswept Yorkshire moors, an intense and haunting story unfolds around love, revenge, and the consequences of obsession.',
    rating: 4.5,
    price: 9.99,
    year: 1847,
    pages: 416,
    genres: ['Classic', 'Drama', 'Mystery'],
    coverUrl: 'https://covers.openlibrary.org/b/id/8231996-L.jpg',
    coverColor: 0xFF55554A,
  ),
];
