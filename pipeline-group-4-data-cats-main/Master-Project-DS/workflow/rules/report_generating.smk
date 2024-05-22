rule generate_workflow_report:
    input:
        expand("results/{sample}/reports/multiqc_report.html", sample=config["samples"]),
    output:
        report(
            "reports/{sample}/multiqc_report.html",
            caption="reports/workflow.rst",
            category="MultiQC Reports",
            labels={
                "date": "{sample}",
                "report": "MultiQC Summary",
                "sample_name": "{wildcards.sample}"  
            }
        )
    shell:
        "cat {input} > {output}"  

#rule generate_quast_report:
#    input:
#        expand("results/{sample}/quast_report", sample=config["samples"]),
#    output:
#        report(
#            "reports/{sample}/quast_report.html",
#            caption="reports/quast.rst",
#            category="Quast Reports",
#            labels={
#                "report": "Quast Summary",
#                "sample_name": "{wildcards.sample}"  
#            }
#        )
#    shell:
#        "cat {input}/report.tsv > {output}" 
