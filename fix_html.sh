#!/bin/bash

# Znajdź wszystkie pliki .md
find . -name "*.md" -type f | while read file; do
    # Zamień <div align="center"><img src="X" alt="Y" width="Z"></div> na ![Y](X)
    # Używamy perl do multi-line regex
    perl -i -0pe 's|<div align="center">\s*<img src="([^"]+)" alt="([^"]+)"[^>]*>\s*</div>|![$2]($1)|gs' "$file"
    
    echo "Processed: $file"
done

echo "Done!"
