#Access conda 
source $(dirname $(dirname $(which mamba)))/etc/profile.d/conda.sh

#Make the output directory 
mkdir $output_dir
cd $output_dir

#Convert input from BAM to BED
#load bedtools
conda install -y bedtools

#Using bedtools
bamtobed -i $1 > $1.bed


echo "Conversion complete"