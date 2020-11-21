import 'package:flutter/material.dart';

class CustomRangeSelector extends StatefulWidget {
  final double start, end, width, height;
  final Function(double start) onStartChange;
  final Function(double end) onEndChange;
  final int divisions;

  const CustomRangeSelector(
      {Key key,
      this.start,
      this.end,
      this.width,
      this.height,
      this.onStartChange,
      this.onEndChange,
      this.divisions})
      : super(key: key);

  @override
  _CustomRangeSelectorState createState() => _CustomRangeSelectorState();
}

class _CustomRangeSelectorState extends State<CustomRangeSelector> {
  double barHeight = 0;
  List<Widget> topDivider = [], bottomDividers = [];

  double startPosition = 0;
  double endPosition = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startPosition = widget.start * widget.width;
    endPosition = widget.end * widget.width;
    barHeight = widget.height * 0.75;
    double markerDistance = widget.width / widget.divisions;
    List markers = List.generate(
        widget.divisions - 1, (index) => (markerDistance) * (index + 1));
    topDivider = markers
        .map((e) => Positioned(
            top: 0,
            left: e - 1,
            child: Container(
              color: Colors.black,
              height: 10,
              width: 2,
            )))
        .toList();

    bottomDividers = markers
        .map((e) => Positioned(
            bottom: 0,
            left: e - 1,
            child: Container(
              color: Colors.black,
              height: 10,
              width: 2,
            )))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: [
          Container(
            height: barHeight,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
            child: Stack(
              children: [
                ...topDivider,
                ...bottomDividers,
              ],
            ),
          ),
          Positioned(
              top: 0,
              left: startPosition - 1,
              child: Container(
                width: 2,
                height: barHeight,
                color: Colors.red,
              )),
          Positioned(
              top: 0,
              left: endPosition - 1,
              child: Container(
                width: 2,
                height: barHeight,
                color: Colors.red,
              )),
          Positioned(
              bottom: 0,
              left: startPosition - 10,
              child: GestureDetector(
                onPanUpdate: (panUpdate) {
                  double newPosition = (startPosition + panUpdate.delta.dx)
                      .clamp(0.0, widget.width);
                  if (newPosition <= endPosition - 10) {
                    widget.onStartChange(double.parse(
                        (newPosition / widget.width).toStringAsFixed(2)));
                    setState(() {
                      startPosition = newPosition;
                    });
                  }
                },
                child: Container(
                  width: 20,
                  height: widget.height - barHeight,
                  color: Colors.red,
                ),
              )),
          Positioned(
              bottom: 0,
              left: endPosition - 10,
              child: GestureDetector(
                onPanUpdate: (panUpdate) {
                  double newPosition = (endPosition + panUpdate.delta.dx)
                      .clamp(0.0, widget.width);
                  if (newPosition >= startPosition + 10) {
                    widget.onEndChange(double.parse(
                        (newPosition / widget.width ).toStringAsFixed(2)));
                    setState(() {
                      endPosition = newPosition;
                    });
                  }
                },
                child: Container(
                  width: 20,
                  height: widget.height - barHeight,
                  color: Colors.red,
                ),
              )),
          Positioned(
            top: 0,
            left: startPosition,
              child: Container(
            width: endPosition - startPosition,
            height: barHeight,
            color: Colors.deepOrange.withAlpha(100),
          ))
        ],
      ),
    );
  }
}
