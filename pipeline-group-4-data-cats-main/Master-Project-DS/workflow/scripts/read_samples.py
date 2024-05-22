import argparse
import os
import shutil
import gzip

def main():
    # Parse command line arguments
    parser = argparse.ArgumentParser(description="Copy and unzip files to the general data/samples directory")
    parser.add_argument("source_dir", help="Path to the source directory containing the files to copy and unzip")
    args = parser.parse_args()

    # Set the destination directory
    dest_dir = os.path.join(os.getcwd(), "data", "samples")

    # Create the destination directory if it doesn't exist
    os.makedirs(dest_dir, exist_ok=True)

    # Copy and unzip files from source directory to destination directory
    try:
        for file in os.listdir(args.source_dir):
            if file.endswith(".fastq.gz"):
                with gzip.open(os.path.join(args.source_dir, file), 'rb') as f_in:
                    with open(os.path.join(dest_dir, file[:-3]), 'wb') as f_out:
                        shutil.copyfileobj(f_in, f_out)
        print("Files copied and unzipped successfully to:", dest_dir)
    except Exception as e:
        print("Error:", str(e))

if __name__ == "__main__":
    main()

#run => python3 workflow/scripts/read_samples.py /local/work/DSiBI_fastq