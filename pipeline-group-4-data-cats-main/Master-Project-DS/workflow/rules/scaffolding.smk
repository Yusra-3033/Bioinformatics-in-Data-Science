# Define rule for scaffolding using RagTag
rule ragtag_scaffolding:
    input:
        contigs="results/{sample}/assembly",
        reference="data"
    output:
        directory("results/{sample}/scaffold")
    log:
        "logs/scaffold/{sample}_ragtag.log"
    conda:
        "../envs/ragtag.yaml"
    shell:
        """
        ragtag.py scaffold -r {input.reference}/genome.fasta {input.contigs}/final.contigs.fa -o {output} &> {log}
        """
