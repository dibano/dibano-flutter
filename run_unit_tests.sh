#!/bin/bash
flutter test --coverage
FILE=coverage/lcov.info
echo "Processing coverage data..."
# Find all dart files
find lib -name "*.dart" | while read -r file; do
  # Check if file exists in lcov.info
  if ! grep -q "SF:$file" $FILE; then
    # Add file with zero coverage
    echo "SF:$file" >> $FILE
    # Count lines in the file and mark all as not executed
    COUNT=$(wc -l < "$file")
    for i in $(seq 1 $COUNT); do
      echo "DA:$i,0" >> $FILE
    done
    echo "LF:$COUNT" >> $FILE
    echo "LH:0" >> $FILE
    echo "end_of_record" >> $FILE
  fi
done
genhtml coverage/lcov.info -o coverage/html
