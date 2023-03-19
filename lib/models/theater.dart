part of 'models.dart';

class Theater extends Equatable {
  late final int uid;
  final String name;

  Theater({required this.name}) {
    uid = int.parse(
        '${DateTime.now().second}${DateTime.now().millisecond}${DateTime.now().microsecond}');
  }

  @override
  List<Object?> get props => [uid, name];
}

List<Theater> dummyTheater = [
  Theater(name: 'CGV Rita Supermall'),
  Theater(name: 'Rajawali Cinema'),
  Theater(name: 'NSC Braling'),
];
