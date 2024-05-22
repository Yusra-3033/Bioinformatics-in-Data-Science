
READ1 = config["reads"][0]
READ2 = config["reads"][1]

# Define rule for genome assembly using Megahit
rule megahit_assembly:
    input:
        R1="results/{sample}/preprocessed/{sample}"+READ1+"_trimmed.fastq",
        R2="results/{sample}/preprocessed/{sample}"+READ2+"_trimmed.fastq"
    output:
        directory("results/{sample}/assembly")
    log:
        "logs/assembly/{sample}_megahit.log"
    conda:
        "../envs/megahit.yaml"
    resources:
        mem_mb=16000,  # Memory in MB
        cores=4        # Number of CPU cores
    shell:
        """
        megahit -1 {input.R1} -2 {input.R2} -o {output} &> {log}\
        --mem-flag 0 --num-cpu-threads {resources.cores}
        """