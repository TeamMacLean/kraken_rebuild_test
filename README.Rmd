---
title: "Krakendb_Rebuild_Test"
author: "Ram Krishna Shrestha"
date: "9 August 2019"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```


## Kraken DB Rebuilding

### Data

A list of taxonomy identifiers or NC accession identifiers.

### Method

Building Bacterial Krakendb

Run the command below to get taxonomic information and RefSeq Fasta files.

```
kraken-build --download-library bacteria --db Bacterial_kraken
kraken-build --download-taxonomy --db Bacterial_kraken
```

You should have folder structure like this (showing only the necessary files):

```
   Bacterial_kraken
   |
   |-----library
   |    |
   |    |-----bacteria
   |            |
   |            |----library.fna
   |            |----assembly_summary.txt
   |            |----manifest.txt
   |            |----prelim_map.txt
   |
   |----taxonomy
        |---nucl_gb.accession2taxid.gz

```

Now, download a following file from NCBI to folder - Bacterial_kraken/taxonomy and then uncompress there.

```
ftp://ftp.ncbi.nih.gov/pub/taxonomy/taxdump.tar.gz
```

This will uncompress many files, but the files names.dmp and nodes.dmp are the important ones. The kraken-build script only looks for the sequences to build databases in the fasta files with extension - .fna inside the database folder name - Bacterial_kraken. If you would like to add more sequences downloaded from NCBI, you can use the option --add-to-library and those sequence taxid get added to the file - Bacterial_kraken/library/prelim_map.txt. All the downloaded sequences taxid are already added to this file with the commands above.

Our folder should look like this.

```
   Bacterial_kraken
   |
   |-----library
   |    |
   |    |-----bacteria
   |            |
   |            |----library.fna
   |            |----assembly_summary.txt
   |            |----manifest.txt
   |            |----prelim_map.txt
   |
   |----taxonomy
        |---nucl_gb.accession2taxid.gz
        |---names.dmp
        |---nodes.dmp
        |---citations.dmp
        |---delnodes.dmp
        |---division.dmp
        |---gc.prt
        |---gencode.dmp
        |---merged.dmp
```

If you want to build kraken database with the selected taxid/NC accession sequences only (if you have a list of taxid in a file), the sequences that match your taxid/NC accession can be filtered from the file - Bacterial_kraken/library/library.fna (if you have multiple .fna files, select from there as well), removing the sequences you don't want. In the file, Bacterial_kraken/library/prelim_map.txt, there may be information on taxid you don't need, but it's fine.

Now, build the kraken database using the following command:

```
kraken-build --build --db Bacterial_kraken
```

You can do the same for other library types : viral, archae, plant, human as well.

More information on Kraken database can be found in the manual (https://ccb.jhu.edu/software/kraken/MANUAL.html)
