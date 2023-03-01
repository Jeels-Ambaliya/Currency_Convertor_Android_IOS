import 'package:awesome_dropdown/awesome_dropdown.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/globals.dart';
import 'models/helpers/api_helper.dart';

void main() {
  runApp(
    DevicePreview(
      builder: (context) => const Currenct_Convertor(),
    ),
  );
}

class Currenct_Convertor extends StatefulWidget {
  const Currenct_Convertor({Key? key}) : super(key: key);

  @override
  State<Currenct_Convertor> createState() => _Currenct_ConvertorState();
}

class _Currenct_ConvertorState extends State<Currenct_Convertor> {
  @override
  Widget build(BuildContext context) {
    return (Globals.isAndroid)
        ? MaterialApp(
            theme: ThemeData(
              useMaterial3: true,
            ),
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
            debugShowCheckedModeBanner: false,
            home: Builder(
              builder: (context) {
                return Scaffold(
                  appBar: AppBar(
                    title: const Text(
                      "Convertor",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.lightGreen,
                      ),
                    ),
                    actions: [
                      Switch.adaptive(
                        value: Globals.isAndroid,
                        activeColor: Colors.blue.shade800,
                        onChanged: (val) {
                          setState(() {
                            Globals.isAndroid = false;
                          });
                        },
                      ),
                    ],
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Currency\nConverter",
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.blue.shade800,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          //From
                          const Padding(
                            padding: EdgeInsets.only(
                              top: 20,
                            ),
                            child: Text(
                              "From",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          AwesomeDropDown(
                            isPanDown: Globals.isPanDown,
                            dropDownList: Globals.CountryCode,
                            selectedItem: Globals.FromCountry,
                            onDropDownItemClick: (From) {
                              setState(() {
                                Globals.FromCountry = From;
                              });
                            },
                            dropStateChanged: (isOpen) {
                              Globals.isDropdownOpened = isOpen;
                              if (!isOpen) {
                                Globals.isBackPress = false;
                              }
                            },
                          ),

                          //To
                          const Padding(
                            padding: EdgeInsets.only(
                              top: 20,
                            ),
                            child: Text(
                              "To",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          AwesomeDropDown(
                            isPanDown: Globals.isPanDown,
                            dropDownList: Globals.CountryCode,
                            selectedItem: Globals.ToCountry,
                            onDropDownItemClick: (To) {
                              setState(() {
                                Globals.ToCountry = To;
                              });
                            },
                            dropStateChanged: (isOpen) {
                              Globals.isDropdownOpened = isOpen;
                              if (!isOpen) {
                                Globals.isBackPress = false;
                              }
                            },
                          ),

                          Padding(
                            padding: const EdgeInsets.only(
                                top: 30, bottom: 5, left: 280),
                            child: Text(
                              Globals.FromCountry,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          TextFormField(
                            onChanged: (val) {
                              setState(() {
                                Globals.Amount = int.parse(val);
                              });
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              label: const Text(
                                "Amount",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              border: OutlineInputBorder(
                                // borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 40,
                            ),
                            child: Container(
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 15,
                                      ),
                                      child: FutureBuilder(
                                        future: ApiHelper.apiHelper.CurrencyApi(
                                          From: Globals.FromCountry,
                                          To: Globals.ToCountry,
                                          amount: Globals.Amount,
                                        ),
                                        builder: (context, snapShot) {
                                          if (snapShot.hasError) {
                                            return Text("${snapShot.error}");
                                          } else if (snapShot.hasData) {
                                            Map? P = snapShot.data;
                                            return Text(
                                              "${P!['new_amount']}",
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            );
                                          }
                                          return const Text(
                                            "Result",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      Globals.ToCountry,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        : CupertinoApp(
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
            debugShowCheckedModeBanner: false,
            home: Builder(
              builder: (context) {
                return CupertinoPageScaffold(
                  navigationBar: CupertinoNavigationBar(
                    trailing: Switch.adaptive(
                        value: Globals.isAndroid,
                        onChanged: (val) {
                          setState(() {
                            Globals.isAndroid = true;
                          });
                        }),
                    middle: const Text(
                      "Currency",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Colors.lightGreen,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 90,
                      left: 20,
                      right: 20,
                    ),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Currency\nConverter",
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.blue.shade800,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          //From
                          const Padding(
                            padding: EdgeInsets.only(
                              top: 20,
                            ),
                            child: Text(
                              "From",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 130,
                            child: CupertinoPicker(
                              magnification: 1.22,
                              squeeze: 1.2,
                              useMagnifier: true,
                              itemExtent: 32.0,
                              onSelectedItemChanged: (int Select) {
                                setState(() {
                                  Globals.FromCon = Select;
                                });
                              },
                              children: List.generate(
                                Globals.CountryCode.length,
                                (int index) => Text(
                                  Globals.CountryCode[index],
                                ),
                              ),
                            ),
                          ),
                          //To
                          const Padding(
                            padding: EdgeInsets.only(
                              top: 5,
                            ),
                            child: Text(
                              "To ",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 130,
                            child: CupertinoPicker(
                              magnification: 1.22,
                              squeeze: 1.2,
                              useMagnifier: true,
                              itemExtent: 32.0,
                              onSelectedItemChanged: (val) {
                                setState(() {
                                  Globals.ToCon = val;
                                  // Globals.ToCountry = val.toString();
                                });
                              },
                              children: List.generate(
                                Globals.CountryCode.length,
                                (int index) => Text(
                                  Globals.CountryCode[index],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                              bottom: 5,
                              left: 280,
                            ),
                            child: Text(
                              Globals.CountryCode[Globals.FromCon],
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          CupertinoTextField(
                            onChanged: (val) {
                              setState(() {
                                Globals.Amount = int.parse(val);
                              });
                            },
                            keyboardType: TextInputType.number,
                            placeholder: "Amount",
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.shade200,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 30,
                            ),
                            child: Container(
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 15,
                                      ),
                                      child: FutureBuilder(
                                        future: ApiHelper.apiHelper.CurrencyApi(
                                          From: Globals.FromCountry,
                                          To: Globals.ToCountry,
                                          amount: Globals.Amount,
                                        ),
                                        builder: (context, snapShot) {
                                          if (snapShot.hasError) {
                                            return Text("${snapShot.error}");
                                          } else if (snapShot.hasData) {
                                            Map? P = snapShot.data;
                                            return Text(
                                              "${P!['new_amount']}",
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            );
                                          }
                                          return const Text(
                                            "Result",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      Globals.CountryCode[Globals.ToCon],
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
  }
}
