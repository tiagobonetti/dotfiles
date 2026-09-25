#!/usr/bin/env python3
"""Print today's events from the configured private iCalendar feed.

Setup and run from this directory::

    python3 -m venv .venv
    .venv/bin/python -m pip install -r requirements.txt
    .venv/bin/python extract_today_events.py

The feed URL is read from config.json and is never printed. Only today's
event times and titles are written to standard output.
"""

import json
from datetime import date, datetime, time, timedelta
from pathlib import Path
import sys
from urllib.request import urlopen

from dateutil.tz import tzlocal
from icalendar import Calendar
import recurring_ical_events


CONFIG = Path(__file__).with_name("config.json")


def main():
    try:
        config = json.loads(CONFIG.read_text())
        url = config["calendar_ics_url"]
        if not isinstance(url, str) or not url.startswith(("https://", "http://")):
            raise ValueError
    except (OSError, ValueError, KeyError, TypeError):
        print("Calendar config is missing or invalid.", file=sys.stderr)
        return 1

    try:
        with urlopen(url, timeout=20) as response:
            calendar = Calendar.from_ical(response.read())
    except Exception:
        print("Could not read or parse the calendar feed.", file=sys.stderr)
        return 1

    local_tz = tzlocal()
    today = datetime.now(local_tz).date()
    start = datetime.combine(today, time.min, local_tz)
    end = datetime.combine(today + timedelta(days=1), time.min, local_tz)
    events = recurring_ical_events.of(calendar).between(start, end)
    results = []

    for event in events:
        begins = event.get("DTSTART")
        if begins is None:
            continue

        begins = begins.dt
        title = " ".join(str(event.get("SUMMARY", "(Untitled event)")).split())
        title = "".join(character for character in title if character.isprintable())
        if isinstance(begins, datetime):
            if begins.tzinfo is None:
                begins = begins.replace(tzinfo=local_tz)
            begins = begins.astimezone(local_tz)
            if begins.date() != today:
                continue
            label = begins.strftime("%H:%M")
        elif isinstance(begins, date) and begins == today:
            label = "All day"
        else:
            continue

        results.append((label, title))

    results.sort(key=lambda item: (item[0] == "All day", item[0]))
    if results:
        for label, title in results:
            print(f"{label}  {title}")
    else:
        print("No events today.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
