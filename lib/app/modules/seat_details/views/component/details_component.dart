import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';
import 'package:ticketsheba_superviser/app/modules/seat_details/controllers/seat_details_controller.dart';

import '../../../../../core/extra/app_dimens.dart';
import '../../../../../global/widget/global_decoration.dart';

class DetailsComponent {
  static searchView(
          {required SeatDetailsController controller,
          required ColorScheme theme,
          required List<SearchFieldListItem<String>> suggestions,
          required String hint,
          required TextEditingController inputController,
          required onSelected}) =>
      Container(
        height: 50,
        width: double.maxFinite,
        padding: EdgeInsets.only(
          left: 24,
          right: 8,
        ),
        margin: EdgeInsets.only(top: AppDimens.breatingSpace),
        decoration: GlobalDecoration.inputDecoration(theme),
        child: SearchField(
          suggestions: //       items: controller.storepoint
              suggestions,
          suggestionState: Suggestion.expand,
          hint: hint,
          controller: inputController,
          // hasOverlay: true,
          searchStyle: TextStyle(
            fontSize: 18,
            color: Colors.black.withOpacity(0.8),
          ),
          validator: (x) {
            // if (controller.storepoint.contains(x) || x!.isEmpty) {
            //   return 'Please Enter a valid State';
            // }
            return null;
          },
          suggestionItemDecoration: BoxDecoration(
              border: Border.symmetric(
                  horizontal:
                      BorderSide(color: Colors.grey.shade400, width: 0.3))),
          suggestionsDecoration: BoxDecoration(
              color: Colors.grey.shade100,
              border: Border.all(color: Colors.grey.shade400, width: 0.6)),
          searchInputDecoration: InputDecoration(
              hintStyle: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade500,
              ),
              // suffix: Text(
              //   '*',
              //   style: TextStyle(color: Colors.red.shade400),
              // ),
              border: InputBorder.none),
          maxSuggestionsInViewPort: 6,
          // itemHeight: 50,
          onSuggestionTap: onSelected,
        ),
      );
}
