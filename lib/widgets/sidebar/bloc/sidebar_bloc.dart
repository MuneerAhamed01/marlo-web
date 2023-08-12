import 'package:flutter_bloc/flutter_bloc.dart';

part 'sidebar_event.dart';
part 'sidebar_state.dart';

class SidebarBloc extends Bloc<SidebarEvent, SidebarState> {
  SidebarBloc() : super(SidebarInitial()) {
    on<SidebarEvent>((event, emit) {});
  }
}
