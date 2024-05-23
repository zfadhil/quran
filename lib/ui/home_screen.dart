// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/ui/tabs/hijb_tab.dart';
import 'package:quran/ui/tabs/para_page.dart';
import 'package:quran/ui/tabs/surah_tab.dart';
import 'package:quran/ui/tabs/page_tab.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      bottomNavigationBar: _bottomNavigationBar(),
      body: DefaultTabController(length: 4, 
          child: Padding(padding: EdgeInsets.symmetric(horizontal: 24),
              child: NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxisScrolled) => [
                SliverToBoxAdapter(
                  child: _salam(),
                ),
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: true,
                  elevation: 0,
                  shape: Border(bottom: BorderSide(
                    color: const Color(0xffaaaaaa).withOpacity(0.1))),
                    bottom: PreferredSize(preferredSize: const Size.fromHeight(0), child: _tab()),
                )
              ], 
              body: const TabBarView(
                children: [SurahTab(),HijbTab(),PageTab(),ParaTab()]
                )
                ),
                )  
                ),
    );
  }

  TabBar _tab() => TabBar(
    labelColor: Colors.purple,
    indicatorColor: Colors.purple,
    indicatorWeight: 3,
    tabs: [
      _tabItem('Surah'),
      _tabItem('Hijb'),
      _tabItem('Page'),
      _tabItem('Para')
      ],
  );

  Tab _tabItem(String label) => Tab(
    child:Text(
        label,
        style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600),
    ),
  );

  Column _salam() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Assalamu\'alaikum',
        style: GoogleFonts.plusJakartaSans(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 24
        ),),
        SizedBox(height: 5,),
        Text('User',
        style: GoogleFonts.plusJakartaSans(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 30
        ),),
        SizedBox(height: 15),
        _lastRead()
      ],
  ) ;

  Stack _lastRead() => Stack(
    children: [
      Container(
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            colors: [Color(0xFFDF98FA), Color(0xFF9055FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight
          )
        ),
      ),
      Positioned(
        bottom: 0, 
        right: 0, 
        child: SvgPicture.asset('assets/svg/quran_banner.svg'),
      ),
      Padding(padding: EdgeInsets.all(20),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Text('Last Read',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 16,
          ),
          ),
          SizedBox(height: 16),
          Text('Al Fatihah',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
          ),
          SizedBox(height: 4),
          Text('Ayat Ke-1',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 16
          ))
        ],
      ),)
    ],
  );

  AppBar _appBar() => AppBar(
          title: Row(
            children: [
              SvgPicture.asset('assets/svg/quran_icon.svg'),
              SizedBox(
                width: 16,
              ),
              Text(
                'Quran App',
                style: GoogleFonts.poppins(
                    color: Colors.purple,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {},
                icon: SvgPicture.asset('assets/svg/search_icon.svg'))
          ]);
                                                                                                                                                     
  BottomNavigationBar _bottomNavigationBar() => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        items: [
          _bottomNavigationBarItem(
              icon: 'assets/svg/quran_icon.svg', label: 'Quran'),
          _bottomNavigationBarItem(
              icon: 'assets/svg/doa_icon.svg', label: 'Doa'),
          _bottomNavigationBarItem(
              icon: 'assets/svg/bookmark_icon.svg', label: 'Bookmark'),
        ],
      );

  BottomNavigationBarItem _bottomNavigationBarItem(
          {required String icon, required String label}) =>
      BottomNavigationBarItem(
          icon: SvgPicture.asset(icon),
          activeIcon: SvgPicture.asset(icon),
          label: label);
}