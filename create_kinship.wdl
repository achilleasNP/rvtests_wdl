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

     runtime {
       docker: "quay.io/achilleasnp/rvtests:v0.0.1"
    }

    meta {
        author: "Achilleas Pitsillides"
        email: "anp4r at bu.edu"
        description: "## vcf2kinship \n # Workflow to generate kinship matrix for use with rvtests. \n"
    }       
}

workflow calculateKinship {
  call vcf2kinship

}

 
