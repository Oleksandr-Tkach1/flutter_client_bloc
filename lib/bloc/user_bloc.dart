import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client_bloc/bloc/user_state.dart';
import 'package:flutter_client_bloc/models/user.dart';
import 'package:flutter_client_bloc/services/user_repository.dart';
import 'user_event.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UsersRepository usersRepository;
  UserBloc({this.usersRepository}) : assert(usersRepository != null), super(UserEmptyState());

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is UserLoadEvent) {
      yield UserLoadingState();
        final List<User> _loadedUserList = await usersRepository.getAllUsers();
        yield UserLoadedState(loadedUser: _loadedUserList);
        //yield UserErrorState();
    } else if (event is UserClearEvent) {
      yield UserEmptyState();
    }
  }
}