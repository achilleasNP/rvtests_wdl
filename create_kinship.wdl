task vcf2kinship  {
       File inputVcf
       File? pedigreeFile
       Boolean useBaldingNicols 
       Boolean useIBS
       String outputPrefix
 
       command  {
            vcf2kinship --inVCF ${inputVcf} \
             ${true="--bn" false="" useBaldingNicols} \
             ${true='--ibs' false=""  useIBS} \
             if defined pedigreeFile then "--pedigree " + pedigreeFile \
             --out ${outputPrefix} 
        }
     output {
       Array[File] outputs = glob( "${outputPrefix}*" )
     }
        
}

workflow calculateKinship {
  call vcf2kinship

}

