rule quast_summary:
    input:
        expand("results/{sample}/quast_report/report.tsv", sample=config["samples"]),
    output:
        "results/{sample}/summary/quast_summary.txt",  
    conda:
        "../envs/python.yaml",
    script: 
        "../scripts/summarise_results.py"