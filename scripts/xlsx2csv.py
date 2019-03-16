#!/usr/bin/env python3
# coding: utf-8

version='1.0.0'

import pyexcel
import argparse
import os
from contextlib import contextmanager

@contextmanager
def cd(newdir):
  prevdir = os.getcwd()
  if newdir != "":
    os.chdir(os.path.expanduser(newdir))
  try:
    yield
  finally:
    os.chdir(prevdir)

parser = argparse.ArgumentParser(description='Convert XSLX sheets to CSV files')
parser.add_argument('xlsx_file', help='XLSX file')
args=parser.parse_args()

#init vars
xlsx_file = args.xlsx_file
xdir = os.path.dirname(xlsx_file)
xfile = os.path.basename(xlsx_file)
ddir = os.path.splitext(xfile)[0]

with cd(xdir):
  if not os.path.isdir(ddir):
    os.makedirs(ddir)

  book = pyexcel.get_book(file_name=xfile)
  for sheet in book:
    csv_path=os.path.join(ddir, "{}.csv".format(sheet.name))
    pyexcel.save_as(array=sheet, dest_file_name=csv_path)
