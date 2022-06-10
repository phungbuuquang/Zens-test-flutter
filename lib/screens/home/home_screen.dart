import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zens_test_flutter/screens/home/bloc/home_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeCubit get _cubit => BlocProvider.of(context);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _cubit.initDb();
    });
  }

  _showIosOKDialog(
    BuildContext context,
  ) async {
    var actions = [
      CupertinoDialogAction(
        child: Text('Accept'),
        onPressed: () {
          _cubit.reset();
          Navigator.of(context).pop();
        },
      ),
      CupertinoDialogAction(
        child: Text('Cancel'),
        isDestructiveAction: true,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ];

    await showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text('Notification'),
        content: Text('You voted all joke! Do you want to clear your vote?'),
        actions: actions,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listenWhen: (previous, current) => current is HomeEmptyJokeState,
      listener: (_, state) {
        if (state is HomeEmptyJokeState) {
          _showIosOKDialog(context);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: _buildNavBar(),
              ),
              Positioned(
                top: 80,
                left: 0,
                right: 0,
                bottom: 50,
                child: _buildContentView(),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: _buildFooterView(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Column _buildFooterView() {
    return Column(
      children: [
        BlocBuilder<HomeCubit, HomeState>(
          buildWhen: (previous, current) => current is HomeGetJokeState,
          builder: (context, state) {
            if (state is HomeGetJokeState) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () => _cubit.setFun(state.joke.id ?? 0, true),
                    child: Container(
                      height: 50,
                      width: 150,
                      color: Colors.blue,
                      child: Center(
                        child: Text(
                          'This is funny!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => _cubit.setFun(state.joke.id ?? 0, false),
                    child: Container(
                      height: 50,
                      width: 150,
                      color: Colors.green,
                      child: Center(
                        child: Text(
                          'This is not funny.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            return SizedBox.shrink();
          },
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          height: 1,
          color: Colors.grey,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ),
        Text(
          'Copyright 2021 HLS',
          style: TextStyle(fontSize: 16),
        )
      ],
    );
  }

  SingleChildScrollView _buildContentView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: Colors.green,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  'A joke a day keeps the doctor away',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'If you joke wrong way, your teeth have to pay. (Serious)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: BlocBuilder<HomeCubit, HomeState>(
              buildWhen: (previous, current) => current is HomeGetJokeState,
              builder: (_, state) {
                if (state is HomeGetJokeState) {
                  return Text(
                    state.joke.content ?? '',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blueGrey,
                    ),
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  Container _buildNavBar() {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/images/logo.png',
            width: 80,
            height: 60,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Handicrafted by',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    'Jim HLS',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 10,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.network(
                  'https://hoayeuthuong.com/cms-images/flower-meaning/434019_y-nghia-hoa-huong-duong.jpg',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
