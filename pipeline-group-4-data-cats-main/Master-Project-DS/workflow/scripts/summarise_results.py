import os

def generate_summary(quast_dir, output_file):
    with open(output_file, 'w') as summary_file:
        summary_file.write("Sample\t# Contigs\tTotal Length\tGC (%)\tReference Coverage (%)\n")
        for subdir, _, files in os.walk(quast_dir):
            for file in files:
                if file == "report.tsv":
                    sample_name = os.path.basename(subdir)
                    report_path = os.path.join(subdir, file)
                    total_length = gc_percentage = reference_coverage = ""  # Initialize variables
                    with open(report_path, 'r') as report:
                        for line in report:
                            if line.startswith("Total length (>= 0 bp)"):
                                total_length = line.split("\t")[1].strip()
                            elif line.startswith("GC (%)"):
                                gc_percentage = line.split("\t")[1].strip()
                            elif line.startswith("Genome fraction (%) (reference genome)"):
                                reference_coverage = line.split("\t")[1].strip()
                    summary_file.write(f"{sample_name}\t{total_length}\t{gc_percentage}\t{reference_coverage}\n")

# Snakemake input and output files
quast_directory = os.path.dirname(str(snakemake.input[0]))
output_summary_file = str(snakemake.output[0])

# Generate summary
generate_summary(quast_directory, output_summary_file)
