# Load configuration file
configfile: "config/config.yaml"

read1 = config["reads"][0]
read2 = config["reads"][1]

# Define the rule to trim and filter reads using Fastp
rule trim_and_filter:
    input:
        "data/samples/{sample}"+read1+".fastq",
        "data/samples/{sample}"+read2+".fastq"
    output:
        "results/{sample}/preprocessed/{sample}"+read1+"_trimmed.fastq",
        "results/{sample}/preprocessed/{sample}"+read2+"_trimmed.fastq",
    conda:
        "../envs/fastp.yaml"
    params:
        adapter="GCGAATTTCGACGATCGTTGCATTAACTCGCGAA",
        adapter_2="AGATCGGAAGAGCCTCGTGTAGGGAAAGAGTGT",
        qualified_quality_phred=15,
        unqualified_percent_limit=40,
        average_qual=0
    shell:
        """
        fastp --in1 {input[0]} --in2 {input[1]}  \
            --out1 {output[0]} --out2 {output[1]} \
            --adapter_sequence {params.adapter} --adapter_sequence_r2 {params.adapter_2} \
            --qualified_quality_phred {params.qualified_quality_phred} \
            --unqualified_percent_limit {params.unqualified_percent_limit} \
            --average_qual {params.average_qual} 
        """
