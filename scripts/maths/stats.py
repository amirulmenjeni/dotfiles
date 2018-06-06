#!/usr/bin/python

import sys

def factorial(n):
    if n == 0:
        return 1
    return n * factorial(n - 1)

def n_choose_r(n, r):
    return factorial(n) / (factorial(r) * factorial(n - r))

# Calculate the binomial probability of n trials
# where the event X = r.
def binomial_probability(n, p, r):
    return n_choose_r(n, r) * (p**r) * ((1 - p)**(n - r))

# Calculate the sum of binomial probability from r = beg to r = end.
def binomial_probability_sum(n, p, ranges):
    sum = 0
    for i in range(0, len(ranges), 2):
        beg = ranges[i]
        end = ranges[i + 1]
        print('Computing for r = %s to r = %s ...' % (beg, end))
        for r in range(beg, end + 1):
            sum += binomial_probability(n, p, r)
    return sum

# Print the binomial probability distribution of trials and probability of 
# success p. The print format is a matrix (row by column) where the first
# column represents the i-th trial and n is the number of trials.
def binomial_distribution(n, p, show_detail=False):
    for r in range(n + 1):
        print(r, binomial_probability(n, p, r))

    if show_detail:
        print('mean', n * p)
        print('variance', n * p * (1 - p))
        print('std devi', (n * p * (1 - p)) ** 0.5)

def freq_table(s):
    li = s.split(',')


def main(args):
    if len(args) == 0:
        return

    if args[0] == '--binomial-probability':
        if len(args) != 4:
            print('Not enough input parameter.')
        else:
            n = int(args[1])
            p = float(args[2])
            r = int(args[3])
            print('ans:', binomial_probability(n, p, r))

    elif args[0] == '--binomial-probability-sum':
        if len(args) != 4:
            print('Not enough input parameter.')
        else:
            n = int(args[1])
            p = float(args[2])
            ranges = [int(x) for x in str(args[3]).split(',')]
            if len(ranges) % 2 != 0:
                print('Invalid range.')
                return
            print('ans:', binomial_probability_sum(n, p, ranges))
    elif args[0] == '--binomial-distribution':
        if len(args) < 3:
            print('Not enough input parameter.')
        else:
            n = int(args[1])
            p = float(args[2])
            s = ''
            try:
                s = args[3]
            except IndexError:
                pass
            show_detail = False
            if s == 's':
                show_detail = True 
            binomial_distribution(n, p, show_detail)

if __name__ == '__main__':
    main(sys.argv[1:])

