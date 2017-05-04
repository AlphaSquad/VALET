# Biobox to run VALET read based assembly evaluation
Bioboxes, http://bioboxes.org/,  provide a consistent interface to common bioinformatic tools such as assemblers. This repository contains files needed to build a biobox for the VALET read-based assembly validation tool.

## Building VALET Biobox

build with

`sudo docker build --tag=valet .`

## Running the VALET Biobox  

Create input, output, and (optionally) cache directories, mount accordingly
choose task to be run (default).

To run VALET using the biobox a `biobox.yaml` file is required. You can use the `biobox.yaml` file in the next "Testing the VALET Biobox" as a template.  

```
sudo docker run --volume="$(pwd)/input:/bbx/mnt/input:ro" \
                --volume="$(pwd)/output:/bbx/mnt/output:rw" -v cache:/bbx/mnt/cache:rw valet default
```  

## Testing the VALET Biobox  

You can test the Biobox using test data from the VALET repository, https://github.com/marbl/VALET, and the following `biobox.yaml` file. After generating the `biobox.yaml` file and downloading the test data you can run VALET on the test data using the command in the __Running the VALET Biobox__ section, making sure that the `input` directory contains the `biobox.yaml` and test data files. 

### Test Biobox.yaml

```
---
version: "0.2.0"
arguments:
  assemblies:
    - id: "reference"
      type: contig
      path: "/bbx/mnt/input/c_rudii_reference.fna"
    - id: "relocation"
      type: contig
      path: "/bbx/mnt/input/c_rudii_relocation.fna"
    - id: "dup"
      type: contig
      path: "/bbx/mnt/input/c_rudii_dup.fna"
    - id: "reloc_dup"
      type: contig
      path: "/bbx/mnt/input/c_rudii_reloc_dup.fna"
  reads:
    - id: "test_reads"
      type: "paired"
      path: "/bbx/mnt/input/lib1.fq.gz"
```

### Downloading Test files

The following code can be used to download the test data from the VALET repository.

```
!/usr/bin/sh
#### Downloading test assemblies

# Reference sequence
wget https://raw.githubusercontent.com/marbl/VALET/master/test/c_rudii_reference.fna
# Simulated duplication error
wget https://raw.githubusercontent.com/marbl/VALET/master/test/c_rudii_dup.fna
# Simulated relocation error
wget https://raw.githubusercontent.com/marbl/VALET/master/test/c_rudii_relocation.fna
# Simulated relocation and duplication error
wget https://raw.githubusercontent.com/marbl/VALET/master/test/c_rudii_reloc_dup.fna

#### Downloading test sequences
wget --output-document lib1.fq.gz https://github.com/marbl/VALET/blob/master/test/lib1.fq.gz?raw=true
```
