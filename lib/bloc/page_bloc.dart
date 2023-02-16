import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  PageBloc() : super(PageInitial()) {
    on<PageEvent>((event, emit) {
      if (event is GoToSplashPage) {
        emit(OnSplashPage());
      } else if (event is GoToSignInPage) {
        emit(OnSignInPage());
      } else if (event is GoToMainPage) {
        emit(OnMainPage());
      }
    });
  }
}
