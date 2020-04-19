import pprint
import os

files_by_longest_line = {}

for path, dirs, files in os.walk('.'):

  if filter(lambda ex: ex in path, ['.git', 'node_modules']):
    continue

  for f in [f for f in files if f.endswith('js')]:
    longest = 1000
    filename = '%s/%s' % (path, f)
    for l in open(filename).readlines():
      if longest < len(l):
        longest = len(l)
        files_by_longest_line.setdefault(longest, []).append(filename)


for longest, f in sorted(files_by_longest_line.items(), key=lambda i: i[0])[-100:]:
  print longest, f
