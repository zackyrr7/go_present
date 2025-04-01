import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_present/bloc/homePage/user_bloc.dart';
import 'package:go_present/bloc/homePage/user_state.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CardAbsen extends StatelessWidget {
  const CardAbsen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String status1 = '';
    String status2 = '';
    String statusBelum = "Belum Absen";
    String statusSudah = "Sudah Absen";

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoading) {
          return Center(
            child: LoadingAnimationWidget.progressiveDots(
                color: Theme.of(context).colorScheme.primary, size: 12),
          );
        } else if (state is UserLoaded) {
          if (state.userProfile.jamMasuk == '00:00:00') {
            status1 = statusBelum;
          } else {
            status1 = statusSudah;
          }

          if (state.userProfile.jamKeluar == '00:00:00') {
            status2 = statusBelum;
          } else {
            status2 = statusSudah;
          }

          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16.0, 8),
            child: Card(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width,
                // color: Colors.white,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 8, 0),
                      child: Text(
                        state.userProfile.tanggal,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.blue[50],
                                borderRadius: BorderRadius.circular(5)),
                            width: MediaQuery.of(context).size.width * 0.40,
                            height: MediaQuery.of(context).size.height * 0.17,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Masuk',
                                  style: TextStyle(color: Colors.black),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  state.userProfile.jamMasuk,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                const SizedBox(height: 2),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.blue[200],
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      status1,
                                      style: const TextStyle(
                                          fontSize: 10, color: Colors.black),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.blue[50],
                                borderRadius: BorderRadius.circular(5)),
                            width: MediaQuery.of(context).size.width * 0.40,
                            height: MediaQuery.of(context).size.height * 0.17,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Pulang',
                                  style: TextStyle(color: Colors.black),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  state.userProfile.jamKeluar,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.black),
                                ),
                                const SizedBox(height: 2),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.blue[200],
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      status2,
                                      style: const TextStyle(
                                          fontSize: 10, color: Colors.black),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        } else if (state is UserError) {
          return Center(
            child: Text("Error: ${state.message}"),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
