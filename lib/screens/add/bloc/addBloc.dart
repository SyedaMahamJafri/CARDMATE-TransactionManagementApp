import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/screens/add/bloc/addEvents.dart';
import 'package:project/screens/add/bloc/addStates.dart';
import 'package:project/screens/add/model/addModel.dart';
import 'package:project/screens/add/repo/addRepo.dart';

class AddBloc extends Bloc<AddEvents, AddState> {
  final AddRepository addRepository;

  AddBloc(this.addRepository) : super(InitalState()) {
    on<TransactionAddButtonPressed>((event, emit) async {
      emit(LoadingState());
      try {
        await addRepository.addTransaction(event.addModel);
        emit(SuccessState());
      } catch (e) {
        emit(AddErrorState('Failed to compelete transaction  : $e'));
      }
    });

    on<GetTransactions>((event, emit) async {
      emit(LoadingState());
      try {
        List<AddModel> add = await addRepository.getTransactions();
        emit(LoadedState(add));
      } catch (e) {
        emit(AddErrorState('Failed to compelete transaction  : $e'));
      }
    });
  }
}
