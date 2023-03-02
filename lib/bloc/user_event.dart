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

  const UpdateData({this.name, this.profilePicture});

  @override
  List<Object?> get props => [name, profilePicture];
}

class SignOut extends UserEvent {
  @override
  List<Object> get props => [];
}
