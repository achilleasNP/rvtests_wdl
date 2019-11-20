task rvtests {
      File inVCF
      File phenoFile
      File? covarFile
      Boolean? inverseNormal
      Boolean? useResidualsAsPhenotype
      String phenoName
      String prefix
      Array[String]? covars
      Array[String]? singleTests
      Array[String]? burdenTests
      Array[String]? vtTests
      Array[String]? kernelTests
      Array[String]? metaTests
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
      File? setFile
      File? kinship
      Array[String]? set

      command {
         rvtest --inVcf ${inVCF} \
	        --out ${prefix} \
	        --pheno ${phenoFile} \
		--pheno-name ${phenoName} \
		${"--covar " + covarFile } \
		if ${default=false inverseNormal} then "--inverseNormal" else "" \
		if ${default=false useResidualsAsPhenotype} then "--useResidualAsPhenotype" else "" \
                if defined covars then "--covar-name " + ${sep="," covars} else "" \ 
                if defined singleTests then "--single " + ${sep="," singleTests} else "" \ 
                if defined burdenTests then "--burden " + ${sep="," burdenTests} else "" \ 
                if defined burdenTests then "--vt " + ${sep="," vtTests} else "" \ 
                if defined burdenTests then "--kernel " + ${sep="," kernelTests} else "" \ 
                if defined metaTests then "--meta " + ${sep="," metaTests} else "" \ 
                ${ "--peopleIncludeFile" + peopleIncludeFile } \
                --freqUpper ${freqUpper} \
                --freqLower ${freqLower} \
                ${ "--rangeFile " + rangeFile } \
                ${ "--siteFile " +  siteFile } \
                ${ "--siteMACMin " +  siteMACMin } \
                ${ "--annoType " +  annoType } \
                ${ "--impute " +  impute } \
		if ${default=false imputePheno} then "--imputePheno" else "" \
                ${ "--geneFile " +  geneFile } \
                if defined genes then "--gene " + ${sep="," genes} else "" \
                ${ "--setFile " +  setFile } \
                if defined setList then "--set " + ${sep="," set} else "" \
                ${ "--kinship " +  kinship } 
       }
}
 
workflow association {
    call rvtests
}

     
                
                 

		
		

 

