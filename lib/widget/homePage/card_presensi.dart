import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_present/bloc/homePage/list_bloc.dart';
import 'package:go_present/bloc/homePage/list_state.dart';

class CardPresensi extends StatelessWidget {
  const CardPresensi({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 5, 16.0, 8),
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
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Absensi hari ini',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Lihat semua',
                        style:
                            TextStyle(fontSize: 10, color: Colors.blueAccent),
                      ),
                    ),
                  ],
                ),
              ),
              BlocBuilder<ListBloc, ListState>(
                builder: (context, state) {
                  if (state is ListLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is ListLoaded) {
                    if (state.listAbsens.length == 0) {
                      return Container(
                        child: Center(
                          child: Text("Belum ada yang absen"),
                        ),
                      );
                    } else {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: ListView.builder(
                            itemCount: state.listAbsens.length > 3
                                ? 3
                                : state.listAbsens.length,
                            itemBuilder: (BuildContext context, int index) {
                              String jamKeluar =
                                  state.listAbsens[index].jamKeluar.isEmpty
                                      ? '00:00'
                                      : state.listAbsens[index].jamKeluar;
                              String jamMasuk =
                                  state.listAbsens[index].jamMasuk.isEmpty
                                      ? '00:00'
                                      : state.listAbsens[index].jamMasuk;

                              if (state.listAbsens[index].izin == '1') {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            state.listAbsens[index].name,
                                            style: TextStyle(
                                                color: Colors.blueAccent,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.greenAccent[100]),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                'Izin',
                                                style: TextStyle(fontSize: 10),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Container(
                                            color: Colors.black54,
                                            height: 1,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width),
                                      )
                                    ],
                                  ),
                                );
                              } else if (state.listAbsens[index].sakit == '1') {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            state.listAbsens[index].name,
                                            style: TextStyle(
                                                color: Colors.blueAccent,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.red),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                'Sakit',
                                                style: TextStyle(fontSize: 10),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Container(
                                            color: Colors.black54,
                                            height: 1,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width),
                                      )
                                    ],
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.listAbsens[index].name,
                                        style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Absen Masuk',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(5.0),
                                            child: Text(
                                              jamMasuk,
                                              style: TextStyle(fontSize: 10),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Absen Pulang',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(5.0),
                                            child: Text(
                                              jamKeluar,
                                              style: TextStyle(fontSize: 10),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Container(
                                            color: Colors.black54,
                                            height: 1,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width),
                                      )
                                    ],
                                  ),
                                );
                              }
                            }),
                      );
                    }
                  } else if (state is ListError) {
                    return Center(
                      child: Text("Error: ${state.message}"),
                    );
                  }
                  return Container(
                    child: Text('error'),
                  );
                },
              ),
              // const Padding(
              //   padding: EdgeInsets.fromLTRB(16, 8, 8, 8),
              //   child: Text(
              //     "Prakosa Marbun",
              //     style: TextStyle(
              //         color: Colors.blueAccent, fontWeight: FontWeight.bold),
              //   ),
              // ),
              // const Padding(
              //   padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              //   child: Column(
              //     children: [
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Text(
              //             'Absen Masuk',
              //             style: TextStyle(fontSize: 12),
              //           ),
              //           Text(
              //             '07:08',
              //             style: TextStyle(fontSize: 12),
              //           )
              //         ],
              //       ),
              //       SizedBox(
              //         height: 2,
              //       ),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Text(
              //             'Absen Pulang',
              //             style: TextStyle(fontSize: 12),
              //           ),
              //           Text(
              //             '00:00',
              //             style: TextStyle(fontSize: 12),
              //           )
              //         ],
              //       ),
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
