# Define rule for Assembly Controll using QUAST
rule assembly_control:
    input:
        reference="data/genome.fasta",
        scaffolds="results/{sample}/scaffold",
    output:
        directory("results/{sample}/quast_report"),
    log:
        "logs/assembly_control/{sample}_quast.log"
    conda:
        "../envs/quast.yaml"  
    shell:
        """
        quast.py {input.scaffolds}/ragtag.scaffolds.fasta -r {input.reference} -o {output} &> {log}
        """