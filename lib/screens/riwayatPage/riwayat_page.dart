import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_present/bloc/riwayat/riwayat_bloc.dart';
import 'package:go_present/bloc/riwayat/riwayat_state.dart';

class RiwayatScreen extends StatelessWidget {
  const RiwayatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String pulang = '';
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 40,
        // backgroundColor: Colors.transparent,
        title: Text(
          'Riwayat',
          style: TextStyle(
            // color: Theme.of(context).textTheme.bodyMedium?.color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.secondary,
              ),
              width: MediaQuery.of(context).size.width * 0.85,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Bulan ini',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                  ),
                  SizedBox(height: 8),
                  BlocBuilder<RiwayatBloc, RiwayatState>(
                    builder: (context, state) {
                      if (state is RiwayatLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is RiwayatLoaded) {
                        int hadir = 0, sakit = 0, izin = 0, telat = 0;

                        for (var riwayat in state.listRiwayat) {
                          if (riwayat.sakit == '1') {
                            sakit++;
                          } else if (riwayat.izin == '1') {
                            izin++;
                          } else if (riwayat.telat == '1') {
                            telat++;
                          } else {
                            hadir++;
                          }
                        }

                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildStatCard('Hadir', hadir, Colors.green),
                                _buildStatCard('Telat', telat, Colors.red),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildStatCard('Izin', izin, Colors.amber),
                                _buildStatCard(
                                    'Sakit', sakit, Colors.lightBlue),
                              ],
                            ),
                            SizedBox(height: 10),
                            state.listRiwayat.isEmpty
                                ? Center(child: Text("Belum ada data"))
                                : ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: state.listRiwayat.length,
                                    itemBuilder: (context, index) {
                                      if (state.listRiwayat[index].sakit ==
                                          '1') {
                                        return Container(
                                          padding: EdgeInsets.all(8),
                                          margin: EdgeInsets.only(bottom: 5),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: Colors
                                                          .grey.shade300))),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                state
                                                    .listRiwayat[index].tanggal,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.color,
                                                ),
                                              ),
                                              Text(
                                                'Sakit',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        Colors.blueAccent[100],
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else if (state
                                              .listRiwayat[index].izin ==
                                          '1') {
                                        return Container(
                                          padding: EdgeInsets.all(8),
                                          margin: EdgeInsets.only(bottom: 5),
                                          decoration: BoxDecoration(
                                              // color: Colors.amber[200],
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: Colors
                                                          .grey.shade300))),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                state
                                                    .listRiwayat[index].tanggal,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.color,
                                                ),
                                              ),
                                              Text(
                                                'Izin',
                                                style: TextStyle(
                                                    color: Colors.amber[200],
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else if (state
                                              .listRiwayat[index].cuti ==
                                          '1') {
                                        return Container(
                                          padding: EdgeInsets.all(8),
                                          margin: EdgeInsets.only(bottom: 5),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: Colors
                                                          .grey.shade300))),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                state
                                                    .listRiwayat[index].tanggal,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.color,
                                                ),
                                              ),
                                              Text(
                                                'Cuti',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.amber,
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else {
                                        return Container(
                                          padding: EdgeInsets.all(8),
                                          margin: EdgeInsets.only(bottom: 5),
                                          decoration: BoxDecoration(
                                              // color: Colors.white,
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: Colors
                                                          .grey.shade300))),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                state
                                                    .listRiwayat[index].tanggal,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.color,
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Masuk: ${state.listRiwayat[index].jamMasuk}",
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge
                                                            ?.color,
                                                        fontSize: 12),
                                                  ),
                                                  if (state.listRiwayat[index]
                                                          .jamKeluar ==
                                                      '')
                                                    Text(
                                                      "Pulang: 00:00 ",
                                                      style: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyLarge
                                                                  ?.color,
                                                          fontSize: 12),
                                                    )
                                                  else
                                                    Text(
                                                      "Pulang: ${state.listRiwayat[index].jamKeluar} ",
                                                      style: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodySmall
                                                                  ?.color,
                                                          fontSize: 12),
                                                    ),
                                                ],
                                              )
                                            ],
                                          ),
                                        );
                                      }
                                    },
                                  ),
                          ],
                        );
                      } else if (state is RiwayatError) {
                        return Center(child: Text("Error : ${state.message}"));
                      }
                      return Container(child: Text("Error"));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, int count, Color color) {
    return Container(
      height: 60,
      width: 120,
      decoration: BoxDecoration(
        color: Colors.blue[50],
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            '$count Hari',
            style: TextStyle(color: Colors.black),
          )
        ],
      ),
    );
  }
}
