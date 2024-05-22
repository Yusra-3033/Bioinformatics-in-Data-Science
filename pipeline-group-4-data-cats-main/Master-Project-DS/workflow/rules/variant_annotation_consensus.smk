# Load configuration file
configfile: "config/config.yaml"

# NCBI Reference Sequence: NC_045512.2
GENOME_NAME="NC_045512.2" 

rule merge_annotation:
    input:
        "results/final.vcf.gz"
    output:
        "results/final.ann.vcf"
    log:
        "Logs/annotation/final.snpeff.log"
    conda:
        "../envs/annotation.yaml"
    shell:
        "snpEff -Xmx10G -v {GENOME_NAME} {input} > {output} 2> {log}"


rule single_annotation:
    input:
        vcf="results/{sample}/vcf/{sample}.vcf.gz"
    output:
        ann_vcf="results/{sample}/vcf/{sample}.ann.vcf"
    log:
        "Logs/{sample}/annotation/{sample}.snpeff.log"
    conda:
        "../envs/annotation.yaml"
    shell:
        "snpEff -Xmx10G -v {GENOME_NAME} {input.vcf} > {output.ann_vcf} 2> {log}"

        
rule consensus:
    input:
        "results/{sample}/vcf/{sample}.vcf.gz"
    output:
        "results/{sample}/fa"
    params:
        genome_path = "data"  
    log:
        "Logs/{sample}/annotation/{sample}.consensus.log"
    conda:
        "../envs/bcftools.yaml"  
    shell:
        "bcftools consensus -f {params.genome_path}/genome.fasta {input} > {output} 2> {log}"

