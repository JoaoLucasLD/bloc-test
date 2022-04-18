import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(HomeLoadingState homeLoadingState) : super(HomeLoadingState()) {
    on<HomeEvent>((event, emit) {});
  }

  @override
  Stream<dynamic> mapEventToState(HomeEvent? event) async* {
    var state;
    switch (event.runtimeType) {
      case HomeFetchList:
        state = await _fetchList();
        break;
      case HomeFetchListWithError:
        state = await _fetchListWithError();
        break;
      case HomeFetchListWithEmptyList:
        state = await _fetchListWithEmptyList();
        break;
    }
    yield state;
  }

  Future<HomeState> _fetchList() async {
    var list = await Future.delayed(
        Duration(seconds: 2),
        () => <String>[
              'Item 1',
              'Item 1',
              'Item 1',
              'Item 1',
              'Item 1',
              'Item 1',
              'Item 1',
            ]);

    return HomeStateLoaded(list: list);
  }

  Future<HomeState> _fetchListWithEmptyList() async {
    return await Future.delayed(
        Duration(seconds: 2), () => HomeStateEmptyList());
  }

  Future<HomeState?> _fetchListWithError() async {
    await Future.delayed(Duration(seconds: 3),
        () => HomeErrorState(message: "Não foi possível carregar os dados."));
  }
}
