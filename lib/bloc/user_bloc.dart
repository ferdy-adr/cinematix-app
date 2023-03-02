import 'dart:convert';

import 'package:cinematix/services/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:cinematix/models/models.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserEvent>((event, emit) async {
      if (event is LoadUser) {
        String jsonAPI = await UserAccountServices.getUser(event.id);

        if (jsonAPI != 'null') {
          Map<String, dynamic> userObject = json.decode(jsonAPI);

          UserAccount user = UserAccount(
            event.id,
            userObject['email'],
            name: userObject['name'],
            balance: userObject['balance'],
            profilePicture: userObject['profilePicture'],
            selectedGenre: (userObject['selectedGenre'] as List)
                .map((e) => e.toString())
                .toList(),
            selectedLanguage: userObject['selectedLanguage'],
          );

          emit(UserLoaded(user));
        } else {
          emit(UserInitial());
        }
      } else if (event is UpdateData) {
        UserAccount updateUser = (state as UserLoaded)
            .user
            .copyWith(name: event.name, profilePicture: event.profilePicture);
        await UserAccountServices.updateUser(updateUser);

        emit(UserLoaded(updateUser));
      } else if (event is SignOut) {
        emit(UserInitial());
      }
    });
  }
}
