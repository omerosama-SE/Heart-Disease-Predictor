import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:heart_disease_prediction/Components/labs_cards.dart';
import 'package:heart_disease_prediction/Services/AppoitnmentService.dart';
import 'package:heart_disease_prediction/models/labs_model.dart';
import 'package:heart_disease_prediction/screens/appoitments.dart';
import 'package:heart_disease_prediction/screens/lab_profile.dart';
import 'package:intl/intl.dart';

class LabsList extends StatefulWidget {
  const LabsList({super.key});

  @override
  State<LabsList> createState() => _LabsListState();
}

class _LabsListState extends State<LabsList> {
  final borderStyle = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(7)),
    borderSide: BorderSide(color: Colors.grey, width: 1.5),
  );

  bool isLoading = true;
  int selectedRadio = 0;
  RangeValues currentSliderVal = const RangeValues(0, 1000);
  String? _selectedZone;
  String? userSelectedZone;
  int? dayOrNight;
  DateTime? dayTime;
  DateTime? nightTime;

  TextEditingController searchController = TextEditingController();
  List<getLabsModel> searchList = [];
  List<int> searchedLabsIds = [];
  List<getLabsModel> ascendingSortedList = [];
  List<getLabsModel> descendingSortedList = [];

  List<int> labsIds = [];
  List<getLabsModel> labs = [];
  final AppoitnmentsService service = AppoitnmentsService(Dio());

  void initState() {
    super.initState();
    searchController.addListener(() {
      onSearchChanged();
    });
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _showLoadingIndicator();
      fetchLabs();
    });
  }

  void fetchLabs() async {
    final fetchedLabs = await service.getLabs();
    if (_overlayEntry != null) {
      _hideLoadingIndicator();
    }
    setState(() {
      labs = fetchedLabs;
      searchList = labs;
      searchedLabsIds = searchList.map((lab) => lab.id).toList();
    });
  }

  // Loading indicator
  OverlayEntry? _overlayEntry;

  void _showLoadingIndicator() {
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 0,
        left: 0,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.black.withOpacity(0.3),
          child: Column(children: [
            Spacer(flex: 1),
            CircularProgressIndicator(color: Color(0xff00466D)),
            Spacer(flex: 1),
          ]),
        ),
      ),
    );

    Overlay.of(context)?.insert(_overlayEntry!);
  }

  void _hideLoadingIndicator() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  onSearchChanged() {
    searchQuery(searchController.text);
  }

  searchQuery(String query) {
    if (query.isNotEmpty) {
      setState(() {
        searchList = labs
            .where(
                (item) => item.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
        searchedLabsIds = searchList.map((doctor) => doctor.id).toList();
      });
    } else {
      searchList = labs;
      searchedLabsIds = searchList.map((doctor) => doctor.id).toList();
    }
  }

  DateTime parseTime(String time) {
    final format = DateFormat("h:mm a", "en_US");
    return format.parseStrict(time);
  }

  filterQuery(
      String? location, double? minPrice, double? maxPrice, int? dayNight) {
    setState(() {
      searchList = labs.where(
        (item) {
          DateTime now = DateTime.now();
          DateTime dayTime = DateTime(now.year, now.month, now.day, 6, 0);
          DateTime nightTime = DateTime(now.year, now.month, now.day, 18, 0);
          // final format = DateFormat.jm('en_US');
          DateTime start = parseTime(item.startTime);
          DateTime end = parseTime(item.finishTime);
          // DateTime startTime =
          //     DateTime(now.year, now.month, now.day, start.hour, start.minute);
          // DateTime endTime =
          //     DateTime(now.year, now.month, now.day, end.hour, end.minute);

          bool matchesLocation = location == null ||
              item.zone.toLowerCase().contains(location.toLowerCase());
          bool matchesPrice =
              (minPrice == null || int.parse(item.price) >= minPrice) &&
                  (maxPrice == null || int.parse(item.price) <= maxPrice);
          bool matchesDayTime =
              (dayNight == null || // dayTime = 6 nightTime = 18
                  start.hour >= dayTime.hour && end.hour <= nightTime.hour);

          bool matchesNightTime = (dayNight ==
                  null || //night : dayTime = 6 && nightTime = 18 // 9 & 4 \\ 9 & 5
              start.hour >= nightTime.hour && end.hour <= dayTime.hour);

          bool matchesAllDay =
              (dayNight == null || //night : dayTime = 6 && nightTime = 18 //
                  start.hour >= dayTime.hour && end.hour >= nightTime.hour);

          bool matchesTime = dayOrNight == null ||
              (dayOrNight == 0
                  ? matchesDayTime
                  : dayOrNight == 1
                      ? matchesNightTime
                      : matchesAllDay);

          return (matchesLocation && matchesPrice && matchesTime);
        },
      ).toList();
      searchedLabsIds = searchList.map((doctor) => doctor.id).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> zones = [
      'Cairo',
      'Giza',
      'Alexandria',
      'North Coast',
      'Qalyubia',
      'Gharbia',
      'Menoufia',
      'Fayoum',
      'El-Dakahlia',
      'El-Sharqia',
      'El-Beheira',
      'Damietta',
      'Matrouh',
      'Assiut',
      'El-Ismailia',
      'Hurghada',
      'Sharm El Sheikh',
      'Portsaid',
      'Suez',
      'sohag',
      'El-Minia',
      'Kafr El sheikh',
      'Luxor',
      'Qena',
      'Aswan',
      'Beni Suef'
    ];
    RangeLabels labels = RangeLabels(currentSliderVal.start.round().toString(),
        currentSliderVal.end.round().toString());

    return Scaffold(
      backgroundColor: Color(0xffF0F4F7),
      appBar: AppBar(
        backgroundColor: Color(0xffD7E8F0),
        title: Text(
          'Lab Centers',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        leadingWidth: 30,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 5),
            Container(
              width: MediaQuery.of(context).size.width * 0.97,
              height: MediaQuery.of(context).size.height * 0.12,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(children: [
                SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.93,
                  height: MediaQuery.of(context).size.width * 0.1,
                  child: TextField(
                      controller: searchController,
                      cursorColor: Color(0xff004670),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 20),
                          hintText: 'Search',
                          prefixIcon: Icon(Icons.search),
                          border: borderStyle,
                          focusedBorder: borderStyle,
                          enabledBorder: borderStyle)),
                ),
                Spacer(flex: 2),
                Row(children: [
                  SizedBox(width: 9),
                  ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                            isDismissible: true,
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                child: Wrap(
                                  children: [
                                    Column(
                                      children: [
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Spacer(flex: 1),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Icon(
                                                Icons.close,
                                                size: 25,
                                              ),
                                            ),
                                            Spacer(flex: 7),
                                            Text(
                                              'Sort',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontFamily: 'Myriad'),
                                            ),
                                            Spacer(flex: 10),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      indent: 20,
                                      endIndent: 20,
                                    ),
                                    RadioListTile(
                                      activeColor: Color(0xff00466D),
                                      value: 0,
                                      groupValue: selectedRadio,
                                      title: Row(children: [
                                        Text(
                                          'Default',
                                          style:
                                              TextStyle(fontFamily: 'Myriad'),
                                        ),
                                      ]),
                                      onChanged: (value) {
                                        Navigator.pop(context);
                                        setState(() {
                                          selectedRadio = 0;
                                          searchList.sort(
                                              ((a, b) => a.id.compareTo(b.id)));
                                          searchedLabsIds = searchList
                                              .map((doctor) => doctor.id)
                                              .toList();
                                        });
                                      },
                                    ),
                                    RadioListTile(
                                      activeColor: Color(0xff00466D),
                                      value: 1,
                                      groupValue: selectedRadio,
                                      title: Row(children: [
                                        Text(
                                          'Price Low to High',
                                          style:
                                              TextStyle(fontFamily: 'Myriad'),
                                        ),
                                      ]),
                                      onChanged: (value) {
                                        Navigator.pop(context);
                                        setState(() {
                                          selectedRadio = 1;
                                          searchList.sort(((a, b) =>
                                              a.price.compareTo(b.price)));
                                          searchedLabsIds = searchList
                                              .map((doctor) => doctor.id)
                                              .toList();
                                        });
                                      },
                                    ),
                                    RadioListTile(
                                      activeColor: Color(0xff00466D),
                                      value: 2,
                                      groupValue: selectedRadio,
                                      title: Row(children: [
                                        Text(
                                          'Price High to Low',
                                          style:
                                              TextStyle(fontFamily: 'Myriad'),
                                        ),
                                      ]),
                                      onChanged: (value) {
                                        Navigator.pop(context);
                                        setState(() {
                                          selectedRadio = 2;
                                          searchList.sort(((b, a) =>
                                              a.price.compareTo(b.price)));
                                          searchedLabsIds = searchList
                                              .map((doctor) => doctor.id)
                                              .toList();
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                width: 25,
                                height: 25,
                                child:
                                    Image.asset('assets/images/transfer.png')),
                            SizedBox(width: 10),
                            Text(
                              'Sort',
                              style: TextStyle(
                                  color: Colors.grey[700], fontSize: 18),
                            ),
                          ]),
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          backgroundColor: Colors.white,
                          fixedSize: Size(
                              MediaQuery.of(context).size.width * 0.45, 30),
                          side: BorderSide(
                              color: Color(0xff969696), width: 1.5))),
                  SizedBox(width: 10),
                  ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                            isDismissible: true,
                            context: context,
                            builder: (BuildContext context) {
                              return StatefulBuilder(builder:
                                  (BuildContext context, StateSetter setState) {
                                return Container(
                                  child: Wrap(
                                    children: [
                                      Column(
                                        children: [
                                          SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Spacer(flex: 1),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Icon(
                                                  Icons.close,
                                                  size: 25,
                                                ),
                                              ),
                                              Spacer(flex: 7),
                                              Text(
                                                'Filter',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontFamily: 'Myriad'),
                                              ),
                                              Spacer(flex: 10),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Divider(
                                        indent: 20,
                                        endIndent: 20,
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(width: 20),
                                              Text(
                                                'Location',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: [
                                                SizedBox(width: 12),
                                                Wrap(
                                                  direction: Axis.horizontal,
                                                  spacing: 5,
                                                  // runSpacing: 2,
                                                  children: zones.map((e) {
                                                    return Container(
                                                      height: 50,
                                                      width: 140,
                                                      child: ChoiceChip(
                                                        showCheckmark: false,
                                                        label: SizedBox(
                                                          width: 100,
                                                          height: 20,
                                                          child: Text(
                                                            e,
                                                            style: TextStyle(
                                                                fontSize: 15),
                                                          ),
                                                        ),
                                                        selected:
                                                            _selectedZone == e,
                                                        onSelected:
                                                            (bool selected) {
                                                          setState(() {
                                                            _selectedZone =
                                                                selected
                                                                    ? e
                                                                    : null;
                                                            userSelectedZone =
                                                                _selectedZone;
                                                          });
                                                        },
                                                        selectedColor:
                                                            Color(0xffD7E8F0),
                                                        disabledColor:
                                                            Colors.grey,
                                                      ),
                                                    );
                                                  }).toList(), // Convert Iterable to List
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            children: [
                                              SizedBox(width: 20),
                                              Text(
                                                'Price',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            children: [
                                              SizedBox(width: 20),
                                              Text(
                                                  '${currentSliderVal.start.round()} EGP'),
                                              Spacer(flex: 12),
                                              Text(
                                                  '${currentSliderVal.end.round()} EGP'),
                                              Spacer(flex: 1),
                                            ],
                                          ),
                                          RangeSlider(
                                            inactiveColor: Colors.grey,
                                            activeColor: Color(0xff00466D),
                                            values: currentSliderVal,
                                            min: 0,
                                            max: 1000,
                                            labels: labels,
                                            onChanged: (values) {
                                              setState(() {
                                                currentSliderVal = values;
                                                labels = RangeLabels(
                                                  values.start
                                                      .round()
                                                      .toString(),
                                                  values.end.round().toString(),
                                                );
                                              });
                                            },
                                          ),
                                          SizedBox(height: 15),
                                          Row(
                                            children: [
                                              SizedBox(width: 20),
                                              Text(
                                                'Time of Day',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              SizedBox(width: 20),
                                              ZeroButton(
                                                  text: 'Day',
                                                  onPressd: () {
                                                    setState(
                                                      () {
                                                        dayOrNight = 0;
                                                        // DateTime now =
                                                        //     DateTime.now();
                                                        // dayTime = DateTime(
                                                        //     now.year,
                                                        //     now.month,
                                                        //     now.day,
                                                        //     6,
                                                        //     0);
                                                        // nightTime = DateTime(
                                                        //     now.year,
                                                        //     now.month,
                                                        //     now.day,
                                                        //     18,
                                                        //     0);
                                                      },
                                                    );
                                                  },
                                                  dayOrNight: dayOrNight),
                                              Spacer(flex: 1),
                                              OneButton(
                                                  text: 'Night',
                                                  onPressd: () {
                                                    setState(
                                                      () {
                                                        dayOrNight = 1;
                                                        // DateTime now =
                                                        //     DateTime.now();
                                                        // dayTime = DateTime(
                                                        //     now.year,
                                                        //     now.month,
                                                        //     now.day,
                                                        //     18,
                                                        //     0);
                                                        // nightTime = DateTime(
                                                        //     now.year,
                                                        //     now.month,
                                                        //     now.day,
                                                        //     6,
                                                        //     0);
                                                      },
                                                    );
                                                  },
                                                  dayOrNight: dayOrNight),
                                              Spacer(flex: 1),
                                              TwoButton(
                                                  text: 'All Day',
                                                  onPressd: () {
                                                    setState(
                                                      () {
                                                        dayOrNight = 2;
                                                        // DateTime now =
                                                        //     DateTime.now();
                                                        // dayTime = DateTime(
                                                        //     now.year,
                                                        //     now.month,
                                                        //     now.day,
                                                        //     6,
                                                        //     0);
                                                        // nightTime = DateTime(
                                                        //     now.year,
                                                        //     now.month,
                                                        //     now.day,
                                                        //     6,
                                                        //     0);
                                                      },
                                                    );
                                                  },
                                                  dayOrNight: dayOrNight),
                                              Spacer(flex: 2),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Divider(
                                            indent: 20,
                                            endIndent: 20,
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              // SizedBox(width: 20),
                                              FilterButton(
                                                onPressd: () {},
                                                text: 'Reset',
                                                backColor: Color(0xffD7E8F0),
                                                textColor: Color(0xff00466B),
                                                borderColor: Color(0xff00466B),
                                              ),
                                              SizedBox(width: 20),
                                              FilterButton(
                                                onPressd: () {
                                                  Navigator.pop(context);
                                                  filterQuery(
                                                      userSelectedZone,
                                                      currentSliderVal.start,
                                                      currentSliderVal.end,
                                                      dayOrNight);
                                                },
                                                text: 'Apply',
                                                backColor: Color(0xff00466B),
                                                textColor: Colors.white,
                                                borderColor: Colors.transparent,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              });
                            });
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                width: 25,
                                height: 25,
                                child: Image.asset('assets/images/funnel.png')),
                            SizedBox(width: 10),
                            Text(
                              'Filter',
                              style: TextStyle(
                                  color: Colors.grey[700], fontSize: 18),
                            ),
                          ]),
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          backgroundColor: Colors.white,
                          fixedSize: Size(
                              MediaQuery.of(context).size.width * 0.45, 30),
                          side: BorderSide(
                              color: Color(0xff969696), width: 1.5))),
                ]),
                Spacer(flex: 1),
              ]),
            ),
            SizedBox(height: 5),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: ListView.separated(
                  itemCount: searchList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return GetLabProfileById(
                                id: searchedLabsIds[index]);
                          }));
                        },
                        child: LabsCards(lab: searchList[index]));
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 5);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
