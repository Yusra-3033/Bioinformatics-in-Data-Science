# Load configuration file
configfile: "config/config.yaml"

READ1 = config["reads"][0]
READ2 = config["reads"][1]

# Indexing reference genome with BWA
rule bwa_index_ref_genome:
    input:
        "data/genome.fasta",
    output:
        "data/genome.fasta.fai",
        "data/genome.fasta.bwt",
        "data/genome.fasta.sa",
        "data/genome.fasta.amb",
        "data/genome.fasta.ann",
        "data/genome.fasta.pac"
    conda: 
        "../envs/bwa.yaml"
    shell:
        """
        bwa index {input}; samtools faidx {input}
        """

# Mapping with BWA
rule bwa_map:
    input:
        bwt="data/genome.fasta.bwt",
        sa="data/genome.fasta.sa",
        amb="data/genome.fasta.amb",
        ann="data/genome.fasta.ann",
        pac="data/genome.fasta.pac",  
        R1="results/{sample}/preprocessed/{sample}"+READ1+"_trimmed.fastq",
        R2="results/{sample}/preprocessed/{sample}"+READ2+"_trimmed.fastq"
    output:
        "results/{sample}/aligned/{sample}_aligned.bam",
    log:
        "logs/alignment/{sample}_align.log"
    conda: 
        "../envs/bwa.yaml"
    params:
        genome_path = "data"
    shell:
        """
        bwa mem -t {threads} {params.genome_path}/genome.fasta {input.R1} {input.R2} | \
        samtools view -bS - | \
        samtools sort -o {output} - 
        """

# Indexing BAM files with Samtools
rule samtools_index:
    input:
        "results/{sample}/aligned/{sample}_aligned.bam"
    output:
        "results/{sample}/aligned/{sample}_aligned.bam.bai"
    log:
        "logs/alignment/{sample}_index.log"
    conda: 
        "../envs/bwa.yaml"
    shell:
        """
        samtools index {input} {output} &> {log}
        """