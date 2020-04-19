# list methods of the given module sorted by number of static invocations

import os
import re

fnames = []
methods = {}
for path, dirs, files in os.walk('.'):
  if 'node_modules' in path:
    continue
  for fname in files:
    if not fname.endswith('.js') or 'FBLayerMetadata' in fname or 'lib.js' in fname or 'plugin.js' in fname:
      continue
    ftext = open('%s/%s' % (path, fname)).read()
    for match in re.findall('FBLayerMetadata\.[^(]*', ftext):
      method = match.replace('FBLayerMetadata.','')
      methods[method] = methods.get(method, 0) + 1
      fnames.append(fname)

print(sorted(list(methods.items()), key=lambda i: i[1], reverse=True))
