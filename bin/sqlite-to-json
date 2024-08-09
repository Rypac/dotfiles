#!/bin/sh
#
# Export the contents of a SQLite database as JSON

if [ ! -f "$1" ]; then
    echo "usage: $(basename "$0") FILE"
    exit 1
fi

database="$1"
json_file=$(mktemp)
trap 'rm -f $json_file' 0 2 3 15

echo '{}' >"$json_file"

for table in $(sqlite3 "$database" "SELECT name FROM sqlite_schema WHERE type='table' ORDER BY name"); do
    json_file_content="$(cat "$json_file")"

    echo "$json_file_content" | jq \
        --arg table_name "$table" \
        --argjson table_content "$(sqlite3 "$database" '.mode json' "SELECT * FROM $table")" \
        '.+={($table_name): $table_content}' \
        >"$json_file"
done

cat "$json_file"
