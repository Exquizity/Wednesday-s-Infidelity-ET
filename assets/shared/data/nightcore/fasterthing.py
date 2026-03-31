
import json
import os

SPEED_MULT = 1.19

def process_chart(data):
    if "song" not in data:
        return data  # not a psych chart

    song = data["song"]

    # BPM
    if "bpm" in song:
        song["bpm"] *= SPEED_MULT

    # Sections
    if "notes" in song:
        for section in song["notes"]:
            # KEEP mustHitSection untouched

            if "sectionNotes" in section:
                for note in section["sectionNotes"]:
                    note[0] /= SPEED_MULT  # strumTime

            if "startTime" in section:
                section["startTime"] /= SPEED_MULT

    # Events
    if "events" in data:
        for event in data["events"]:
            event[0] /= SPEED_MULT

    return data


def main():
    json_files = [f for f in os.listdir('.') if f.endswith('.json')]

    if not json_files:
        print("No JSON file found.")
        return

    for file in json_files:
        print(f"Processing {file}...")

        with open(file, 'r', encoding='utf-8') as f:
            data = json.load(f)

        new_data = process_chart(data)

        output_name = file.replace('.json', '_faster.json')
        with open(output_name, 'w', encoding='utf-8') as f:
            json.dump(new_data, f, indent=4)

        print(f"Saved as {output_name}")


if __name__ == "__main__":
    main()
