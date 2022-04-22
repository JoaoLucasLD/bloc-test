import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_bl/pages/bloc/home_bloc.dart';
import 'package:video_bl/pages/bloc/home_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Aprendendo Bloc'),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
          bloc: BlocProvider.of<HomeBloc>(context),
          builder: (context, state) {
            if (state is HomeStateLoaded) {
              return ListView.builder(
                itemCount: state.list.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state.list[index]),
                  );
                },
              );
            }

            if (state is HomeErrorState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                      child: Container(
                        child: Text(state.message,
                            style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber)),
                      ),
                    ),
                    Container(
                      child: Image.network(
                          'https://blog.tiny.com.br/wp-content/uploads/2018/01/erro-nota-fiscal-1024x700.jpg'),
                      width: 300,
                    ),
                  ],
                ),
              );
            }

            if (state is HomeStateEmptyList) {
              return const Center(
                child: Text("Não há dados disponíveis"),
              );
            }
            if (state is HomeLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            return Container();
          }),
    );
  }
}
