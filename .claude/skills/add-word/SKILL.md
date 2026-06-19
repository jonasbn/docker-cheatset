---
name: add-word
description: Add a word to the spellcheck wordlist (.wordlist.txt), keeping it alphabetically sorted
disable-model-invocation: true
---

## Steps

1. Append the word to `.wordlist.txt`
2. Sort the file case-insensitively and in-place:
   ```bash
   sort -f .wordlist.txt -o .wordlist.txt
   ```
3. Verify the spellcheck still passes:
   ```bash
   # Requires pyspelling and aspell installed
   pyspelling -c .spellcheck.yml
   ```
