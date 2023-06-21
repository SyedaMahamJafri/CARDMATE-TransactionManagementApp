import 'package:equatable/equatable.dart';
import 'package:project/screens/card/model/cardModel.dart';

class CardState extends Equatable {
  const CardState();

  @override
  List<Object> get props => [];
}

class CardLoadingState extends CardState {}

class CardInitialState extends CardState {}

class CardErrorState extends CardState {
  final String message;

  CardErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class CardSuccessState extends CardState {}

class CardLoadedState extends CardState {
  final List<CardModel> cards;

  const CardLoadedState(this.cards);

  @override
  List<Object> get props => [cards];
}
