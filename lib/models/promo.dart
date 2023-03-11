part of 'models.dart';

class Promo extends Equatable {
  final String title, subtitle;
  final int discount;

  const Promo(
      {required this.title, required this.discount, required this.subtitle});

  @override
  List<Object?> get props => [title, subtitle, discount];
}

List<Promo> dummyPromos = const [
  Promo(
      title: 'Student Holiday',
      discount: 50,
      subtitle: 'Maximal only for two people'),
  Promo(
      title: 'Family Club',
      discount: 70,
      subtitle: 'Minimal for three members'),
  Promo(
      title: 'Student Holiday',
      discount: 50,
      subtitle: 'Maximal only for two people')
];
