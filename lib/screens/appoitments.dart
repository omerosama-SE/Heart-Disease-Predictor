import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:heart_disease_prediction/Components/doctors_cards.dart';
import 'package:heart_disease_prediction/Services/AppoitnmentService.dart';
import 'package:heart_disease_prediction/models/doctors_list_model.dart';
import 'package:heart_disease_prediction/screens/doctors_profile.dart';
import 'package:intl/intl.dart';

class DoctorsListShow extends StatefulWidget {
  const DoctorsListShow({super.key});

  @override
  State<DoctorsListShow> createState() => _DoctorsListShowState();
}

class _DoctorsListShowState extends State<DoctorsListShow> {
  final borderStyle = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    borderSide: BorderSide(color: Colors.grey, width: 1.5),
  );

  bool isLoading = true;
  int selectedRadio = 0;
  RangeValues currentSliderVal = const RangeValues(0, 1000);
  String? _selectedZone;
  String? userSelectedZone;
  int? maleORfemale;
  int? dayOrNight;

  List<int> doctorIds = [];
  List<int> searchedDoctorsIds = [];
  List<AppoitnmentsModel> doctors = [];
  //for search & filter functions
  TextEditingController searchController = TextEditingController();
  List<AppoitnmentsModel> searchList = [];
  List<AppoitnmentsModel> ascendingSortedList = [];
  List<AppoitnmentsModel> descendingSortedList = [];
  //
  final AppoitnmentsService service = AppoitnmentsService(Dio());

  void initState() {
    super.initState();
    searchController.addListener(() {
      onSearchChanged();
    });
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _showLoadingIndicator();
      fetchDoctors();
    });
  }

  void dispose() {
    searchController.removeListener(onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  void fetchDoctors() async {
    final fetchedDoctors = await service.getDoctors();
    if (_overlayEntry != null) {
      _hideLoadingIndicator();
      isLoading == false;
    }
    setState(() {
      doctors = fetchedDoctors;
      searchList = doctors;
      doctorIds = doctors.map((doctor) => doctor.id).toList();
      searchedDoctorsIds = searchList.map((doctor) => doctor.id).toList();
      // for (int x = 0; x < doctorIds.length; x++) {
      //   print(searchedDoctorsIds[x]);
      // }
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

  //for search function
  onSearchChanged() {
    searchQuery(searchController.text);
  }

  searchQuery(String query) {
    if (query.isNotEmpty) {
      setState(() {
        searchList = doctors
            .where(
                (item) => item.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
        searchedDoctorsIds = searchList.map((doctor) => doctor.id).toList();
      });
    } else {
      searchList = doctors;
      searchedDoctorsIds = searchList.map((doctor) => doctor.id).toList();
    }
  }

  DateTime parseTime(String time) {
    final format = DateFormat("h:mm a", "en_US");
    return format.parseStrict(time);
  }

  filterQuery(String? location, double? minPrice, double? maxPrice, int? gender,
      int? dayNight) {
    setState(() {
      searchList = doctors.where(
        (item) {
          DateTime now = DateTime.now();
          DateTime dayTime = DateTime(now.year, now.month, now.day, 6, 0);
          DateTime nightTime = DateTime(now.year, now.month, now.day, 18, 0);
          DateTime start = parseTime(item.startTime);
          DateTime end = parseTime(item.finishTime);

          bool matchesLocation = location == null ||
              item.zone.toLowerCase().contains(location.toLowerCase());
          bool matchesPrice =
              (minPrice == null || int.parse(item.price) >= minPrice) &&
                  (maxPrice == null || int.parse(item.price) <= maxPrice);
          bool matchesGender = gender == null ||
              (item.gender == gender || item.gender == gender);
          bool matchesDayTime = (dayNight == null ||
              start.hour >= dayTime.hour && end.hour <= nightTime.hour);

          bool matchesNightTime = (dayNight == null ||
              start.hour >= nightTime.hour &&
                  end.hour >= dayTime.hour &&
                  !matchesDayTime);

          bool matchesAllDay = (dayNight == null ||
              (start.hour < nightTime.hour && end.hour > nightTime.hour));

          bool matchesTime = dayOrNight == null ||
              (dayOrNight == 0
                  ? matchesDayTime
                  : dayOrNight == 1
                      ? matchesNightTime
                      : matchesAllDay);
          // print(
          //     'Item: ${item.name}, Zone: ${item.zone}, Price: ${item.price}, Gender: ${item.gender}');
          // print(
          //     'matchesLocation: $matchesLocation, matchesPrice: $matchesPrice, matchesGender: $matchesGender');
          return matchesLocation &&
              matchesPrice &&
              matchesGender &&
              matchesTime;
        },
      ).toList();
      searchedDoctorsIds = searchList.map((doctor) => doctor.id).toList();
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
          'Search for doctor',
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
                                          searchedDoctorsIds = searchList
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
                                          searchedDoctorsIds = searchList
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
                                          searchedDoctorsIds = searchList
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
                                          Row(
                                            children: [
                                              SizedBox(width: 20),
                                              Text(
                                                'Gender',
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
                                                  text: 'Male',
                                                  onPressd: () {
                                                    setState(
                                                      () {
                                                        maleORfemale = 1;
                                                      },
                                                    );
                                                  },
                                                  maleOrFemale: maleORfemale),
                                              Spacer(flex: 1),
                                              OneButton(
                                                  text: 'Female',
                                                  onPressd: () {
                                                    setState(
                                                      () {
                                                        maleORfemale = 0;
                                                      },
                                                    );
                                                  },
                                                  maleOrFemale: maleORfemale),
                                              Spacer(flex: 7),
                                            ],
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
                                                    },
                                                  );
                                                },
                                                dayOrNight: dayOrNight,
                                              ),
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
                                                      maleORfemale,
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
            searchList.isEmpty && isLoading == false
                ? Column(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3),
                      Text('No Results Found',
                          style: TextStyle(fontSize: 25, fontFamily: 'Myriad')),
                    ],
                  )
                : Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: ListView.separated(
                        itemCount: searchList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return DoctorProfileById(
                                      id: searchedDoctorsIds[index]);
                                }));
                              },
                              child:
                                  DoctorsCards(doctorCard: searchList[index]));
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

class ZeroButton extends StatelessWidget {
  ZeroButton(
      {required this.text,
      required this.onPressd,
      this.maleOrFemale,
      this.dayOrNight});

  String text;
  VoidCallback onPressd;
  int? maleOrFemale;
  int? dayOrNight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      width: 120,
      child: ElevatedButton(
          onPressed: onPressd,
          child: Text(
            text,
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7)),
              backgroundColor: maleOrFemale == 0 || dayOrNight == 0
                  ? Color(0xffD7E8F0)
                  : Colors.white,
              fixedSize: Size(200, 50),
              side: BorderSide(
                  color: maleOrFemale == 0 || dayOrNight == 0
                      ? Colors.transparent
                      : Colors.black))),
    );
  }
}

class OneButton extends StatelessWidget {
  OneButton(
      {required this.text,
      required this.onPressd,
      this.maleOrFemale,
      this.dayOrNight});

  String text;
  VoidCallback onPressd;
  int? maleOrFemale;
  int? dayOrNight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      width: 120,
      child: ElevatedButton(
          onPressed: onPressd,
          child: Text(
            text,
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7)),
              backgroundColor: maleOrFemale == 1 || dayOrNight == 1
                  ? Color(0xffD7E8F0)
                  : Colors.white,
              fixedSize: Size(200, 50),
              side: BorderSide(
                  color: maleOrFemale == 1 || dayOrNight == 1
                      ? Colors.transparent
                      : Colors.black))),
    );
  }
}

class TwoButton extends StatelessWidget {
  TwoButton(
      {required this.text,
      required this.onPressd,
      this.maleOrFemale,
      this.dayOrNight});

  String text;
  VoidCallback onPressd;
  int? maleOrFemale;
  int? dayOrNight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      width: 120,
      child: ElevatedButton(
          onPressed: onPressd,
          child: Text(
            text,
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7)),
              backgroundColor: maleOrFemale == 2 || dayOrNight == 2
                  ? Color(0xffD7E8F0)
                  : Colors.white,
              fixedSize: Size(200, 50),
              side: BorderSide(
                  color: maleOrFemale == 2 || dayOrNight == 2
                      ? Colors.transparent
                      : Colors.black))),
    );
  }
}

class FilterButton extends StatelessWidget {
  FilterButton(
      {required this.onPressd,
      required this.text,
      required this.textColor,
      required this.backColor,
      required this.borderColor});

  VoidCallback onPressd;
  String text;
  Color textColor;
  Color backColor;
  Color borderColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 40,
      child: ElevatedButton(
          onPressed: onPressd,
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: 20),
          ),
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7)),
              backgroundColor: backColor,
              side: BorderSide(color: borderColor))),
    );
  }
}
