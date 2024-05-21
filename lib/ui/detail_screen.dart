import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/model/surah.dart';
import 'package:quran/model/ayah.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen ({super.key,required this.nomorSurah});

  final int nomorSurah;

  Future<Surah> _detailSurah() async{
    var response = await Dio().get('https://equran.id/api/surat/$nomorSurah');
    return Surah.fromJson(json.decode(response.toString()));
  }

  @override
  Widget build(BuildContext context){
    return FutureBuilder(
      future: _detailSurah(), 
      initialData: null,
      builder: (BuildContext context,AsyncSnapshot<dynamic> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator(),);
        }
        Surah surah = snapshot.data!;
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: _appBar(context: context, surah: surah),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverToBoxAdapter(
              child: _detailBanner(surah: surah),
            ),
          ],
        body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ListView.separated(
                    itemBuilder: (context, index) => _ayatItem(
                        ayat: surah.ayat!.elementAt(index + (nomorSurah == 1 ? 1 : 0))),
                    separatorBuilder: (context, index) => Container(),
                    itemCount: surah.jumlahAyah + (nomorSurah == 1 ? -1 : 0)
                ),
              ),
        ),
      
      );
    },
    );
  }

  Widget _ayatItem({required Ayat ayat}) => Padding(
    padding: const EdgeInsets.only(top: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xF121931),
                Color(0xFFFFFFF)
              ]
            )
          ),
          child: Row(children: [
            Container(
              width: 27,
              height: 27,
              decoration: BoxDecoration(
                color: Color(0xFF863ED5),
                borderRadius: BorderRadius.circular(13.5),
              ),
              child: Center(child: Text(
                '${ayat.nomor}',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500
                )
              ))
            ),
            const Spacer(),
            IconButton(
                iconSize: 24,
                onPressed: () => {},
                icon: const Icon(
                  Icons.share_sharp,
                  color: Color(0xFF863ED5),
                )
            ),
            IconButton(
                iconSize: 24,
                onPressed: () => {},
                icon: const Icon(
                  Icons.play_arrow_sharp,
                  color: Color(0xFF863ED5),
                )
            ),
            IconButton(
                iconSize: 24,
                onPressed: () => {},
                icon: const Icon(
                  Icons.bookmark_sharp,
                  color: Color(0xFF863ED5),
                )
            ),
          ],
          )
        ),
        const SizedBox(height: 24),
        Text(
          ayat.ar,
          style: GoogleFonts.amiri(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF240F4F)
          ),
          textAlign: TextAlign.right,
        ),
        const SizedBox(height: 24),
        Text(
          ayat.idn,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.normal,
              color: const Color(0xFF240F4F)
          ),
        )
      ]
    ),
  );

  Widget _detailBanner({required Surah surah}) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Stack(
      children: [
        Container(
        height: 265,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFDF98FA),
                  Color(0xFF9055FF)
                ]
            )
        ),
      ),
        Positioned(
        bottom: 0,
        right: 0,
        child: Opacity(
          opacity: 0.2,
          child: SvgPicture.asset(
            'svg/quran_banner.svg',
            width: 324 - 58,
          ),
        ),
      ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(28),
        child: Column(
          children: [
            Text(
              surah.namaLatin,
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 26
              ),
            ),
            const SizedBox(height: 4),
            Text(
              surah.arti,
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16
              ),
            ),
            const SizedBox(height: 8),
            Divider(
              color: Colors.white.withOpacity(0.35),
              thickness: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  surah.tempatTurun.toString(),
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14
                  ),
                ),
                SizedBox(width: 5),
                Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  '${surah.jumlahAyah} Ayat',
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w500
                  ),
                )
              ],
            ),
            const SizedBox(height: 38),
            SvgPicture.asset('svg/basmallah.svg')
          ],
        ),
      )
      ] 
      ),
    );

  AppBar _appBar({required BuildContext context, required Surah surah}) =>
   AppBar(
    backgroundColor: Colors.white,
    automaticallyImplyLeading: false,
    elevation: 0,
    title: Text(surah.namaLatin.toString()),
    leading: IconButton(
      onPressed: (()=> {Navigator.of(context).pop()}),
      icon: SvgPicture.asset('assets/svg/back_icon.svg')),
   );
  
}
