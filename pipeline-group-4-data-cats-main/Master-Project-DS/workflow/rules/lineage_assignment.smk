# Define rule for Lineage Assignment using Pangolin
rule pangolin_lineage_assignment:
    input:
        scaffolds="results/{sample}/scaffold",
    output:
        directory("results/{sample}/lineage_assignment")
    log:
        "logs/lineage_assignment/{sample}_pangolin.log"
    conda:
        "../envs/pangolin.yaml"
    shell:
        """
        pangolin {input.scaffolds}/ragtag.scaffolds.fasta -o {output} 
        """