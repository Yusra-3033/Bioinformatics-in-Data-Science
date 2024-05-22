# Load configuration file
configfile: "config/config.yaml"

rule vcf:
    input:
        "results/{sample}/aligned/{sample}_aligned.bam", 
        "results/{sample}/aligned/{sample}_aligned.bam.bai", 
        "data/genome.fasta.fai"
    output:
        "results/{sample}/vcf/{sample}.vcf"
    conda: 
        "../envs/freebayes.yaml"
    params:
        genome_path = "data"
    shell:
        "freebayes -f {params.genome_path}/genome.fasta -p 1 -C10 {input[0]} > {output} "

rule bgzip:
    input:
        "results/{sample}/vcf/{sample}.vcf"
    output:
        "results/{sample}/vcf/{sample}.vcf.gz"
    conda: 
        "../envs/freebayes.yaml"
    shell:
        "bgzip {input} ;  tabix -p vcf {output}"

rule merge_vcf:
    input: 
        [f'results/{sample}/vcf/{sample}.vcf.gz' for sample in config["samples"]]
    output:
        "results/final.vcf.gz"
    conda: 
        "../envs/bcftools.yaml"
    shell:
        "bcftools merge --force-samples {input} -Oz -o {output}"