#!/usr/bin/env python2.7

import sys

class FastaToFastq(object):
  def main(self):
    if len(sys.argv) < 2:
      print >> sys.stderr, "usage: {} <fasta>".format(sys.argv[0])
      sys.exit(1)

    fasta_path = sys.argv[1]
    assert fasta_path[-6:] == ".fasta" or fasta_path[-3:] == ".fa"

    seqs = []
    with open(fasta_path, "r") as fasta:
      current_seq_name = None
      current_seq = None
      for line in fasta:
        if line[0] == ">":
          if current_seq_name is not None:
            seqs.append((current_seq_name, "".join(current_seq)))
          current_seq_name = line[1:].strip()
          current_seq = []
        elif current_seq_name is not None:
          current_seq.append(line.strip())

    fastq_path = fasta_path[:-1] + "q"

    with open(fastq_path, "w") as fastq:
      for seq_name, seq in seqs:
        print >> fastq, "@{}".format(seq_name)
        print >> fastq, "{}".format(seq)
        print >> fastq, "+"
        print >> fastq, "{}".format("2" * len(seq))

if __name__ == "__main__":
  FastaToFastq().main()
