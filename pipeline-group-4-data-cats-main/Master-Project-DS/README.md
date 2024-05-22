# DataCats: Group 4
## Data Science in Bioinformatics WS2023/24 Project
<img align="right" src="https://github.com/Data-Science-in-Bioinformatics/pipeline-group-4-data-cats/blob/dev-pipe/Master-Project-DS/imgs/logo.png" alt="App Icon" width="150">


## Authors

- 👤 [Yusra Abdulrahman](https://github.com/Yusra-3033)
- 👤 [Divyangana Kothari](https://github.com/DivyanganaKothari)
- 👤 [Hadeel Khbaiz](https://github.com/Hadil-Khbaiz)
<br>

### Brief Introduction
Our pipeline is a comprehensive solution for the analysis of genomic data obtained from Next-Generation Sequencing (NGS) experiments. Leveraging the power of Snakemake, a workflow management system, the pipeline automates the entire analysis process, from data preprocessing to the generation of detailed reports.

<img align="right" src="https://github.com/Data-Science-in-Bioinformatics/pipeline-group-4-data-cats/blob/dev-pipe/Master-Project-DS/imgs/Workflow.png" alt="Workflow Introduction" width="600">


#### Pipeline Workflow:

* Data Preprocessing with Fastp:

   The pipeline starts by preprocessing raw FASTQ reads using Fastp. 
   This step ensures that the input data is of high quality and suitable for downstream analysis.

* Mapping and Variant Calling:

   Processed reads are then utilized as input for the first sub-pipeline, which involves mapping the reads to a reference genome and calling variants. 
   This sub-pipeline includes tools such as BWA for alignment and freebayes for variant calling.

* Assembly and Quality Assessment:

  In parallel, the pipeline initiates a second sub-pipeline focused on assembling the trimmed reads using MEGAHIT.
  Additionally, the assembled genomes undergo quality assessment using Quast, which evaluates factors like contiguity, completeness, and correctness of the assembly. Also it uses Pangolin for Lineage Assignment.

* Report Generation:

   The results from both sub-pipelines are collated to generate comprehensive reports using MultiQC. 
   These reports encompass information on read quality, alignment statistics, variant calling results, assembly metrics, and more.

<br>


### Step 1: Obtain a copy of this workflow

If you want to add your own changes to the workflow, create a GitHub repository of your own, then clone this one.

1. [Clone](https://github.com/Data-Science-in-Bioinformatics/pipeline-group-4-data-cats.git) the newly created repository to your local system, into the place where you want to perform the data analysis.

If you just want to use this workflow locally, then simply clone it or download it as zip-file.
<br>

### Step 2: Configure workflow

* Leave the config.yaml as it is or you can also Configure the workflow according to your needs via editing the files in the `config/` folder. Adjust `config.yaml` to configure the workflow execution.

   - Please make sure, that the names of your FASTQ files are correctly formatted. They should look like this:
   - For samples, enter your samples name under this field: `samples:`
   - For reads (forward and reverse), enter your samples name under this field:`reads:` 

* The reference genome is already present in the 'config.yaml' as-
   genome_file: "data/genome.fasta" which is `Wuhan`  

* To copy your own reads to the pipeline, move to the main folder and then run:
````
   cd /Master-Project-DS
   python workflow/scripts/read_samples.py /path/to/your_reads
````

* If you want to add your own reference genome, you can make also add it inside the data folder in the directory.
<br>

#### Data samples:

The "data" folder is provided by the repository. It is the folder the fastq files are copied to before being used in the workflow. When copying the repository, the sample files will also be copied inside the data folder.(You can change the sample file as needed). 
But please make sure, that the names of your FASTQ files are correctly formatted. They should look like this:

````
<samplename><read>.fastq
````
<br>

### Step 3: Install Snakemake

Create a snakemake environment using [mamba](https://mamba.readthedocs.io/en/latest/) via:

    mamba create -c conda-forge -c bioconda -n snakemake snakemake= 7.32.4

For installation details, see the [instructions in the Snakemake documentation](https://snakemake.readthedocs.io/en/stable/getting_started/installation.html).
<br>

### Step 4: Execute workflow

Activate the conda environment:

    conda activate snakemake


Test your configuration by performing a dry-run via

    snakemake --use-conda -n

### Configure and deploy Workflow

To run our pipeline, you have to follow the following steps:

````
snakemake -j (number of cores, e.g. 1) 
````
   
<br>

### Step 5: Investigate results

After successful execution, the workflow provides you with different folders, holding all interesting results ready to decompress or to download to your local machine.

      ````
      
      |- Master-Project-DS 
      
      |- ... 
      
      |- data 
      
      |- |- genome.fa 
      
      |- |- ... (ref_genome index files)
      
      |- results 
      
      |- logs 
      
      |- reports (generated reports by snakemake)
      
      |- |-{sample} 
      
      |- |-...
      ````
 *  We have added also a generating quast_result script to extract for example: Total length, CG%, 
 *  Also we have applied Snakemake generating report function by passing report input file and a cabtion. But it have problem with rules execution!
  
<br>

## Tools

A list of the tools used in this pipeline:

| Tool         | Link                                                 |
|--------------|------------------------------------------------------|
| Snakemake    | www.doi.org/10.12688/f1000research.29032.1           |
| FastQC       | www.bioinformatics.babraham.ac.uk/projects/fastqc    |
| MultiQC      | www.doi.org/10.1093/bioinformatics/btw354            |
| Fastp        | https://github.com/OpenGene/fastp                    |
| bcftools     | https://samtools.github.io/bcftools/bcftools.html    |
| bwa          | https://github.com/lh3/bwa                           |
| samtools     | https://www.htslib.org/                              |
| freebayes    | https://github.com/freebayes/freebayes               |
| tabix        | https://www.htslib.org/doc/tabix.html                |
| MEGAHIT      | https://www.metagenomics.wiki/tools/assembly/megahit |
| pangolin     | https://cov-lineages.org/resources/pangolin.html     |              
| matplotlib   | https://matplotlib.org/                              |
| pandas       | https://pandas.pydata.org/                           |
| Quast        | https://quast.sourceforge.net/                       |
| RagTag       | https://github.com/malonge/RagTag                    |



