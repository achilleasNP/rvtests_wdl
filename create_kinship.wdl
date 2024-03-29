task vcf2kinship  {
       File? inputVcf
       File? pedfile
       Boolean? xHemi
       String outputPrefix
       Boolean useBaldingNicols 
       Boolean useIBS

       command  {
            vcf2kinship  ${"--inVcf " + inputVcf} \
             ${"--ped " + pedfile} \
             ${true="--bn" false="" useBaldingNicols} \
             ${true="--ibs" false=""  useIBS} \
             ${true="--xHemi" false="" xHemi} \
             --out ${outputPrefix} 
        }
     output {
       Array[File] outputs = glob( "${outputPrefix}*" )
     }

     runtime {
       docker: "quay.io/achilleasnp/rvtests:v0.0.2"
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

 
