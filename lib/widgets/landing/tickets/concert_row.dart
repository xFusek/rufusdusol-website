part of 'tickets_section.dart';

class ConcertRow extends StatelessWidget {
  const ConcertRow({
    required this.concert,
    required this.compact,
    required this.isMobile,
    super.key,
  });

  final Concert concert;
  final bool compact;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return _MobileConcertRow(concert: concert);
    }

    return SizedBox(
      height: compact ? 50 : 58,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: compact ? 180 : 230,
            child: _ConcertDate(concert.date, compact: compact),
          ),
          SizedBox(width: compact ? 20 : 40),
          Expanded(
            child: _ConcertDetails(concert: concert, compact: compact),
          ),
          SizedBox(width: compact ? 20 : 40),
          SizedBox(
            width: compact ? 180 : 200,
            child: _BuyTicketsButton(compact: compact),
          ),
        ],
      ),
    );
  }
}

class _MobileConcertRow extends StatelessWidget {
  const _MobileConcertRow({required this.concert});

  final Concert concert;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xFF898989),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            height: 50,
            child: _ConcertDate(concert.date, compact: true),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: _ConcertDetails(
              concert: concert,
              compact: true,
              vertical: true,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 25),
            child: FractionallySizedBox(
              widthFactor: 0.6,
              child: SizedBox(height: 45, child: _BuyTicketsButton()),
            ),
          ),
        ],
      ),
    );
  }
}

class _ConcertDate extends StatelessWidget {
  const _ConcertDate(this.date, {this.compact = false});

  final String date;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xFF595959),
      child: Center(
        child: Text(
          date,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Mulish',
            fontSize: compact ? 14 : 20,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _ConcertDetails extends StatelessWidget {
  const _ConcertDetails({
    required this.concert,
    required this.compact,
    this.vertical = false,
  });

  final Concert concert;
  final bool compact;
  final bool vertical;

  @override
  Widget build(BuildContext context) {
    final venue = _ConcertText(concert.venue, compact: compact);
    final location = _ConcertText(
      concert.location,
      compact: compact,
      textAlign: vertical ? TextAlign.center : TextAlign.right,
    );

    return ColoredBox(
      color: const Color(0xFF898989),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: compact ? 20 : 26),
        child: vertical
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [venue, const SizedBox(height: 5), location],
              )
            : Row(
                children: [
                  Expanded(child: venue),
                  const SizedBox(width: 10),
                  Expanded(child: location),
                ],
              ),
      ),
    );
  }
}

class _ConcertText extends StatelessWidget {
  const _ConcertText(
    this.text, {
    required this.compact,
    this.textAlign = TextAlign.left,
  });

  final String text;
  final bool compact;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: compact ? 2 : 1,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: 'Mulish',
        fontSize: compact ? 14 : 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }
}

class _BuyTicketsButton extends StatelessWidget {
  const _BuyTicketsButton({this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {},
      style: FilledButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        shape: const RoundedRectangleBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 12),
      ),
      child: Text(
        'Buy Tickets',
        maxLines: 1,
        style: TextStyle(
          fontFamily: 'Mulish',
          fontSize: compact ? 10 : 16,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
