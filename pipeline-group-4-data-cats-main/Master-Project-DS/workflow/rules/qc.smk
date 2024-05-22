# Rule for FastQC quality control for paired-end reads
rule fastqc:
    input:
        expand("data/samples/{{sample}}{read}.fastq", sample=config["samples"], read=config["reads"])
    output:
        directory("results/{sample}/fastqc")
    log:
        "logs/fastqc/{sample}_fastqc.log"
    conda:
        "../envs/qc.yaml"
    shell:
        """
        mkdir {output} 
        fastqc {input} -o {output} &> {log}
        """