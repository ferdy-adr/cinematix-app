part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class LoadUser extends UserEvent {
  final String id;

  const LoadUser(this.id);

  @override
  List<Object> get props => [id];
}

class UpdateData extends UserEvent {
  final String? name, profilePicture;
  final bool deleteProfilePicture;

  const UpdateData(
      {this.name, this.profilePicture, this.deleteProfilePicture = false});

  @override
  List<Object?> get props => [name, profilePicture];
}

class TopUp extends UserEvent {
  final int amount;

  const TopUp(this.amount);

  @override
  List<Object?> get props => [amount];
}

class Purchase extends UserEvent {
  final int amount;

  const Purchase(this.amount);

  @override
  List<Object?> get props => [amount];
}

class SignOut extends UserEvent {
  @override
  List<Object> get props => [];
}
