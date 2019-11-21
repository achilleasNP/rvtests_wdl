task rvtests {
      File inVCF
      File phenoFile
      File? covarFile
      Boolean? inverseNormal
      Boolean? useResidualAsPhenotype
      Boolean? xHemi
      String? xLabel
      String? xParRegion
      String phenoName
      String prefix
      Array[String]? covarsMaybe
      Array[String]? singleTestsMaybe
      Array[String]? burdenTestsMaybe
      Array[String]? vtTestsMaybe
      Array[String]? kernelTestsMaybe
      Array[String]? metaTestsMaybe

      String covarsPrefix = if defined(covarsMaybe) then "--covar-name "  else "" 
      String singlePrefix = if defined(singleTestsMaybe) then "--single " else "" 
      String burdenPrefix = if defined(burdenTestsMaybe) then "--burden " else "" 
      String vtPrefix = if defined(vtTestsMaybe) then "--vt " else "" 
      String kernelPrefix =if defined(kernelTestsMaybe) then "--kernel " else "" 
      String metaPrefix = if defined(metaTestsMaybe) then "--meta " else ""


      File? peopleIncludeFile
      Float freqUpper
      Float freqLower
      File? rangeFile
      File? siteFile
      Int? siteMACMin
      String? annoType
      String? impute
      Boolean? imputePheno
      File? geneFile
      Array[String]? genes
      String genesPrefix = if defined(genes) then "--genes " else "" 

      File? setFile
      File? kinship
      Array[String]? set
      String setPrefix = if defined(set) then "--set " else "" 
      
      command {
         rvtest --inVcf ${inVCF} \
	        --out ${prefix} \
	        --pheno ${phenoFile} \
		--pheno-name ${phenoName} \
		${"--covar " + covarFile } \
		${"--xLabel " + xLabel } \
		${"--xParRegion " + xParRegion } \
		${true="--inverseNormal" false="" inverseNormal} \
		${true="--useResidualAsPhenotype" false="" useResidualAsPhenotype} \
                ${true="--xHemi" false="" xHemi }\
                ${covarsPrefix} ${sep="," covarsMaybe} \
                ${singlePrefix} ${sep="," singleTestsMaybe} \
                ${burdenPrefix} ${sep="," burdenTestsMaybe} \
                ${vtPrefix} ${sep="," vtTestsMaybe} \
                ${kernelPrefix} ${sep="," kernelTestsMaybe} \
                ${metaPrefix} ${sep="," metaTestsMaybe} \
                ${ "--peopleIncludeFile" + peopleIncludeFile } \
                --freqUpper ${freqUpper} \
                --freqLower ${freqLower} \
                ${ "--rangeFile " + rangeFile } \
                ${ "--siteFile " +  siteFile } \
                ${ "--siteMACMin " +  siteMACMin } \
                ${ "--annoType " +  annoType } \
                ${ "--impute " +  impute } \
                ${true="--imputePheno" false="" imputePheno} \
                ${ "--geneFile " +  geneFile } \
                ${genesPrefix} ${sep="," genes} \
                ${ "--setFile " +  setFile } \
                ${setPrefix} ${sep="," set} \
                ${ "--kinship " +  kinship } 
       }

     output {
       Array[File] outputs = glob( "${prefix}*" )
     }

     runtime {
       docker: "quay.io/achilleasnp/rvtests:v0.0.1"
    }

    meta { 
        author: "Achilleas Pitsillides"
        email: "anp4r at bu.edu"
        description: "## rvtest \n # Workflow to run association with [rvtests](https://github.com/zhanxw/rvtests) \n"
    }       

}
 
workflow association {
    call rvtests
}

     
                
                 

		
		

 

