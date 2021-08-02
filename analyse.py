import datetime
import sys
import re
from prettytable import PrettyTable

STEPS = ['trimmomatic', 'bwa mem', 'samtools sort', 'samtools index']

def get_time(tms):
  bits = re.split('[ms]', tms)
  if len(bits) < 2:
    raise Exception (f'Badly formated time: {tms}')
  return datetime.timedelta(minutes=int(bits[0]), seconds=float(bits[1])).total_seconds()

def process_file(fn):
  times = []

  with open(fn) as f:
    lines = f.readlines()

  for line in lines:
    words = line.split()
    if len(words)>=2 and words[0] == 'real':
      tm = get_time(words[1])
      times.append(tm)
  
  if len(times) != len(STEPS):
    raise Exception(f'Output has to many or too few times in it: {fn}')

  return times


def main(files):
  total_times = [0]*len(STEPS)
  for fn in files:
    times = process_file(fn)
    for i in range(len(total_times)):
      total_times[i] += times[i]
  for i in range(len(total_times)):
    total_times[i] /= len(files)
  
  t = PrettyTable()
  t.field_names = STEPS
  t.add_row(total_times)
  print(t)
  

if __name__ == '__main__':
  main(sys.argv[1:])