part of 'home_cubit.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeGetJokeState extends HomeState {
  JokeModel joke;
  HomeGetJokeState(this.joke);
}

class HomeEmptyJokeState extends HomeState {
  HomeEmptyJokeState();
}
