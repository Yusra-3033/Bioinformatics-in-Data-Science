# Variant calling with bcftools for R1 and R2 reads separately
rule bcftools_call_variants:
    input:
        bam="results/{sample}/aligned/{sample}_aligned.bam",
        ref="data"
    output:
        vcf="results/{sample}/call_variants"
    conda: 
        "../envs/bcftools.yaml"
    shell:
        """
        mkdir -p results/{wildcards.sample}/call_variants
        bcftools mpileup -f {input.ref}/genome.fasta {input.bam} | bcftools call -mv -Oz --ploidy 1 -o {output}
        """