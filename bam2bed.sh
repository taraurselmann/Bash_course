Input=$1
Output_dir=$2
#Create output directory
mkdir -p "$Output_dir"
cd "$Output_dir"
#Access conda 
source $(dirname $(dirname $(which mamba)))/etc/profile.d/conda.sh
conda create -y --name bam2bed
conda activate bam2bed
#Bedtools
conda install -y bedtools
#Using bedtools
Output_file="$(basename "$Input" | sed 's/\.bam$/.bed/')"
bedtools bamtobed -i "$Input">$Output_file
#Only chromosome 1
Output_file_chr1="$(basename "$Input" | sed 's/\.bam$/_chr1.bed/')"
grep -E "^Chr1\s" $Output_file > $Output_file_chr1
#Other_name="$Output_dir/$(basename "$Input" | sed 's/\.bam$/_chr1.bed/')"
#mv $Output_file_chr1 $Other_name
wc -l "$Output_file_chr1" | awk -v file="$Output_dir/$Output_file_chr1" '{print $1, file}' > "bam2bed_number_of_rows.txt"
echo 'Completed by Tara Urselmann' | tee /dev/tty