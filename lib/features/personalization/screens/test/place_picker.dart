import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:poruththam_app/common/widgets/appbar/appbar.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:poruththam_app/features/personalization/controllers/location_detail_controller.dart';
import 'package:poruththam_app/utils/constants/sizes.dart';

class PlacePicker extends StatelessWidget {
  const PlacePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LocationController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Place Picker'),
      ),
      body: Center(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 600,
            child: Column(
              children: [
                ///Adding CSC Picker Widget in app
                CSCPicker(
                  layout: Layout.vertical,

                  ///Enable disable state dropdown [OPTIONAL PARAMETER]
                  showStates: true,

                  /// Enable disable city drop down [OPTIONAL PARAMETER]
                  showCities: true,

                  ///Enable (get flag with country name) / Disable (Disable flag) / ShowInDropdownOnly (display flag in dropdown only) [OPTIONAL PARAMETER]
                  flagState: CountryFlag.DISABLE,

                  ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
                  dropdownDecoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                      border:
                          Border.all(color: Colors.grey.shade300, width: 1)),

                  ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
                  disabledDropdownDecoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Colors.grey.shade300,
                      border:
                          Border.all(color: Colors.grey.shade300, width: 1)),

                  ///placeholders for dropdown search field
                  countrySearchPlaceholder: "Country",
                  stateSearchPlaceholder: "State",
                  citySearchPlaceholder: "City",

                  ///labels for dropdown
                  countryDropdownLabel: "Country",
                  stateDropdownLabel: "State",
                  cityDropdownLabel: "City",

                  ///Default Country
                  ///defaultCountry: CscCountry.India,

                  ///Country Filter [OPTIONAL PARAMETER]
                  countryFilter: [
                    CscCountry.India,
                    CscCountry.United_States,
                    CscCountry.Canada
                  ],

                  ///Disable country dropdown (Note: use it with default country)
                  //disableCountry: true,

                  ///selected item style [OPTIONAL PARAMETER]
                  selectedItemStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),

                  ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                  dropdownHeadingStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),

                  ///DropdownDialog Item style [OPTIONAL PARAMETER]
                  dropdownItemStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),

                  ///Dialog box radius [OPTIONAL PARAMETER]
                  dropdownDialogRadius: 10.0,

                  ///Search bar radius [OPTIONAL PARAMETER]
                  searchBarRadius: 10.0,

                  ///triggers once country selected in dropdown
                  onCountryChanged: (country) {},

                  ///triggers once state selected in dropdown
                  onStateChanged: (state) {
                    // setState(() {
                    //   ///store value in state variable
                    //   stateValue = value!;
                    //});
                  },

                  ///triggers once city selected in dropdown
                  onCityChanged: (city) {
                    // setState(() {
                    //   ///store value in city variable
                    //   cityValue = value!;
                    //});
                  },

                  ///Show only specific countries using country filter
                  // countryFilter: ["United States", "Canada", "Mexico"],
                  //),

                  ///print newly selected country state and city in Text Widget
                  // TextButton(
                  //     onPressed: () {
                  //       setState(() {
                  //         address = "$cityValue, $stateValue, $countryValue";
                  //       });
                  //     },
                  //     child: Text("Print Data")),
                  //Text(address)
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                Obx(() => Text('Copy: ${controller.tCountry}'))
              ],
            )),
      ),
    );
  }
}
