import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:registration_ui/features/app/resources/app_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final _repository = AppRepository();
  AppBloc() : super(AppInitial()) {
    on<LocaleInitAppEvent>(_repository.onLocaleInitAppEvent);
    on<AppStartedEvent>(_repository.onAppStartedEvent);
    on<UserAuthedAppEvent>(_repository.onUserAuthedAppEvent);
    on<LogoutAppEvent>(_repository.onLogoutAppEvent);
  }
}
