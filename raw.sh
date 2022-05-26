## download HiC-Reg
wget -c https://github.com/Roy-lab/HiC-Reg/archive/refs/heads/master.zip
unzip master.zip  # HiC-Reg-master


## aggregate region-level features (wkdir: Scripts/aggregateSignallnRegion)
chmod +x aggregateSignal
./aggregateSignal hg19_5kbp_chr17.txt hg19.fa.fai wgEncodeBroadHistoneGm12878CtcfStdRawDataRep1_chr17.counts wgEncodeBroadHistoneGm12878CtcfStdRawDataRep1_chr17.txt
# ./aggregateSignal: error while loading shared libraries: libgsl.so.0: cannot open shared object file: No such file or directory

## GNU Scientific Library(GSL): a numerical library for C and C++ programmers (https://www.gnu.org/software/gsl/).
## https://www.songbingjia.com/ios/show-18738.html
wget -c https://mirror.ibcp.fr/pub/gnu/gsl/gsl-latest.tar.gz
tar -zxvf gsl-latest.tar.gz
cd gsl-2.7.1
./configure --prefix=/share/home/jlz21/softwares/gsl (without root permission)
make
make install 
vi ~/.bashrc
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/softwares/gsl/lib
#export CFLAGS="-I/~/softwares/gsl/include"
#export LDFLAGS="-L/softwares/gsl/lib"
source ~/.bashrc
cd ~/softwares/gsl/lib
ln libgsl.so libgsl.so.0
