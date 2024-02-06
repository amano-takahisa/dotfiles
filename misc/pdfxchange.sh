#!/bin/bash
# This script is used to open PDF-XChange Editor in Wine
# The portable version of PDF-XChange Editor is expected to be downloaded and
# extracted in ~/Documents/program/pdfxchange/.
# The portable version of PDF-XChange Editor can be downloaded from
# https://www.pdf-xchange.com/product/downloads/enduser/pdf-xchange-editor
wine ~/Documents/program/pdfxchange/PDFXEdit.exe $(winepath -w "$1")
