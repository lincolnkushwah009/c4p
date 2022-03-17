import 'package:care4parents/data/models/vital_type_result.dart';
import 'package:care4parents/presentation/screens/dashboard/bloc/vitaltype_bloc.dart';
import 'package:care4parents/presentation/widgets/spaces.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class VitalTable extends StatelessWidget {
  const VitalTable({
    Key key,
    @required this.vitalTypes,
    @required this.headers,
  }) : super(key: key);

  final List<VitalTypeResult> vitalTypes;
  final List<String> headers;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(Sizes.PADDING_8),
      child: Table(
        columnWidths: {
          0: FractionColumnWidth(.25),
        },
        // defaultColumnWidth: FixedColumnWidth(120.0),
        border: TableBorder(
          horizontalInside: BorderSide(
              width: 1, color: Colors.grey, style: BorderStyle.solid),
        ),
        children: buildRows(theme),
      ),
    );
  }

  List<TableRow> buildRows(ThemeData theme) {
    DateFormat newFormat = DateFormat("yyyy-MM-dd");
    DateFormat newFormatTime = DateFormat("h:mma");

    List<TableRow> rows = [];

    int id = 0;

    List<Widget> rowChildren = [];

    for (var y = 0; y < headers.length; y++, id++) {
      // fill row with buttons
      rowChildren.add(
        new HeaderRow(header: headers[y]),
      );
    }
    rows.add(new TableRow(children: rowChildren));

    for (var index = 0; index < vitalTypes.length; index++) {
      List<Widget> rowChildren1 = [];
      var item = vitalTypes[index];
      rowChildren1.add(
        buildRowContainer(
            text: newFormat.format(
              item.measureOn,
            ),
            theme: theme),
      );
      rowChildren1.add(
        buildRowContainer(
            text: newFormatTime.format(
              item.measureOn,
            ),
            theme: theme),
      );
      if (item.value != null) {
        var val = item.value.contains(',')
            ? item.value.split(',')[0].split(':')[1]
            : item.value;
        rowChildren1.add(
          buildRowContainer(text: val, theme: theme),
        );
      } else {
        rowChildren1.add(
          buildRowContainer(
              text: 'View', theme: theme, isButton: true, item: item),
        );
      }

      if (item.value != null && item.value.contains(',')) {
        var val = item.value.split(',')[1].split(':')[1];
        rowChildren1.add(
          buildRowContainer(text: val, theme: theme),
        );
      }

      rows.add(new TableRow(children: rowChildren1));
    }

    return rows;
  }

  Container buildRowContainer(
      {text, ThemeData theme, bool isButton = false, VitalTypeResult item}) {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0, top: 5.0),
      child: Center(
        child: isButton
            ? Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: BlocBuilder<VitaltypeBloc, VitaltypeState>(
                  builder: (context, state) {
                    return RaisedButton(
                        color: AppColors.primaryColor,
                        hoverColor: AppColors.lightButton,
                        onPressed: () {
                            context.read<VitaltypeBloc>().add(PdfChange(item));
                        },
                        child: Row(
                          children: [
                            Text(
                              text,
                              style: theme.textTheme.caption.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            SpaceW4(),
                            Icon(
                              Icons.file_present,
                              color: AppColors.white,
                              size: 12,
                            )
                          ],
                        ));
                  },
                ),
              )
            : Text(
                text,
                style: theme.textTheme.caption
                    .copyWith(color: AppColors.tableText),
              ),
      ),
    );
  }
}

class HeaderRow extends StatelessWidget {
  const HeaderRow({
    Key key,
    @required this.header,
  }) : super(key: key);

  final String header;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(children: [
      Container(
        padding: EdgeInsets.only(bottom: Sizes.PADDING_10),
        child: Text(header,
            style: theme.textTheme.caption.copyWith(
              color: AppColors.tableText,
              fontWeight: FontWeight.w900,
            )),
      )
    ]);
  }
}
