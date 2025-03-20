Input=$1
Output_dir=$2
#Create output directory
mkdir "$Output_dir"
cd "$Output_dir"
#Access conda 
conda create -y --name bam2bed
conda activate bam2bed
source $(dirname $(dirname $(which mamba)))/etc/profile.d/conda.sh
#Bedtools
conda install -y bedtools
#Using bedtools
Output_file="$(basename "$Input" | sed 's/\.bam$/.bed/')"
bedtools bamtobed -i "$Input">$Output_file
#Only chromosome 1
Output_file_chr1="$2/$(basename "$Input" | sed 's/\.bam$/_chr1.bed/')"
grep "^Chr1\s" $Output_file > $Output_file_chr1
wc -l $Output_file_chr1>"bam2bed_number_of_rows.txt"

echo -e "Completed by Tara Urselmann" 