options( show.error.messages=F, error = function () { cat( geterrmessage(), file=stderr() ); q( "no", 1, F ) } )
Sys.setlocale("LC_MESSAGES", "en_US.UTF-8")
args<-commandArgs(TRUE)

DATA_RD =args[1]
DATA_filtered_centered_RD=args[2]
DATA_RD_PCA=args[3]
DATA_RD_PCA_normalized=args[4]
DATA_RD_PCA_normalized_filtered_sample_zscores=args[5]
DATA_same_filtered=args[6]
DATA_posteriors=args[7]
DATA_xcnv=args[8]
user=args[9]
tmppath=args[10]
output=args[11]
annotated_targets=args[12]

path=paste0(tmppath,"/",user,"/")
graphic_path=paste0(path,"graphics/")

dir.create(path, showWarnings = FALSE)
dir.create(graphic_path,showWarnings = FALSE)

JOB_PREFICES = paste0(path,"DATA")

DATA_RD_PCA_PC=paste0(DATA_RD_PCA,".PC.txt")
DATA_RD_PCA_PC_SD=paste0(DATA_RD_PCA,".PC_SD.txt")
DATA_RD_PCA_PC_LOADINGS=paste0(DATA_RD_PCA,".PC_LOADINGS.txt")

DATA_PCA_normalized_num_removed_PC=paste0(DATA_RD_PCA_normalized,".num_removed_PC.txt")

DATA_posteriors_DEL=paste0(DATA_posteriors,".posteriors.DEL.txt")
DATA_posteriors_DIP=paste0(DATA_posteriors,".posteriors.DIP.txt")
DATA_posteriors_DUP=paste0(DATA_posteriors,".posteriors.DUP.txt")


file.copy(DATA_RD,paste0(path,"DATA.RD.txt"))
file.copy(DATA_filtered_centered_RD,paste0(path,"DATA.filtered_centered.RD.txt"))
file.copy(DATA_RD_PCA_PC,paste0(path,"DATA.RD_PCA.PC.txt"))
file.copy(DATA_RD_PCA_PC_SD,paste0(path,"DATA.RD_PCA.PC_SD.txt"))
file.copy(DATA_RD_PCA_PC_LOADINGS,paste0(path,"DATA.RD_PCA.PC_LOADINGS.txt"))
file.copy(DATA_RD_PCA_normalized,paste0(path,"DATA.PCA_normalized.txt"))
file.copy(DATA_PCA_normalized_num_removed_PC,paste0(path,"DATA.PCA_normalized.txt.num_removed_PC.txt"))
file.copy(DATA_RD_PCA_normalized_filtered_sample_zscores,paste0(path,"DATA.PCA_normalized.filtered.sample_zscores.RD.txt"))
file.copy(DATA_same_filtered,paste0(path,"DATA.same_filtered.RD.txt"))
file.copy(DATA_xcnv,paste0(path,"DATA.xcnv"))
file.copy(DATA_posteriors_DEL,paste0(path,"DATA.posteriors.DEL.txt"))
file.copy(DATA_posteriors_DIP,paste0(path,"DATA.posteriors.DIP.txt"))
file.copy(DATA_posteriors_DUP,paste0(path,"DATA.posteriors.DUP.txt"))


library(xhmmScripts)

###########################################################
## CHANGE TO DESIRED OUTPUT PATH FOR PLOTS:
###########################################################
PLOT_PATH = graphic_path


###########################################################
## CHANGE TO FULL PATH AND PREFIX FOR ALL XHMM PIPELINE OUTPUT:
##
## (e.g., DATA.RD.txt, DATA.RD_PCA.PC.txt, 
## DATA.PCA_normalized.filtered.sample_zscores.RD.txt, etc.)
##
###########################################################
#JOB_PREFICES = "./DATA"


###########################################################
## CHANGE TO FULL PATH OF PLINK/Seq FORMAT EXON-TO-GENE LIST:
##
## THIS CAN BE GENERATED FOR EXOME.interval_list USING THE FOLLOWING PLINK/Seq COMMAND:
##
## pseq . loc-intersect --group refseq --locdb /path/to/locdb --file ./EXOME.interval_list --out ./annotated_targets.refseq
##
###########################################################
##JOB_TARGETS_TO_GENES = "./annotated_targets.refseq.loci"
JOB_TARGETS_TO_GENES=annotated_targets


###########################################################
## CAN BE (OPTIONALLY) POPULATED FROM EITHER CHOICE BELOW:
###########################################################
SAMPLE_FEATURES = NULL


###########################################################
## CHOICE A: CHANGE TO FULL PATH OF PLINK/Seq PEDIGREE FILE
## (SEE  http://atgu.mgh.harvard.edu/plinkseq/input.shtml#ped):
###########################################################
#PEDIGREE_FILE = "/path/to/pseq_pedigree_file"
#PEDIGREE_DATA = readPedigreeFile(PEDIGREE_FILE)
#SAMPLE_FEATURES = pedigreeDataToBinarySampleProperties(PEDIGREE_DATA)


###########################################################
## CHOICE B: OR, INSTEAD OF A PLINK/Seq PEDIGREE FILE, USE A PLINK/Seq SAMPLE PHENOTYPES FILE
## (SEE  https://atgu.mgh.harvard.edu/plinkseq/input.shtml#phe):
###########################################################
#PHENOTYPES_FILE = "/path/to/pseq_phenotypes_file"
#PHENOTYPES_DATA = readPhenotypesFile(PHENOTYPES_FILE)
#SAMPLE_FEATURES = phenotypeDataToBinarySampleProperties(PHENOTYPES_DATA)

XHMM_plots(PLOT_PATH, JOB_PREFICES, JOB_TARGETS_TO_GENES, SAMPLE_FEATURES)
setwd(path)
tar(output,"graphics")
