package com.virtualsw

import org.springframework.web.multipart.MultipartFile

class ImageIndirectService {

    static transactional = false

    def grailsApplication
    def grailsLinkGenerator

    /*String fullPath(String category = null) {

        String returnPath = grailsApplication.config.imageindirect.basePath
        String categoryUrl = category ? grailsApplication.config.imageindirect.category."${category}" : null

        if (categoryUrl) {
            if (categoryUrl.startsWith("/")) {
                returnPath = categoryUrl
            } else {
                returnPath += "/${categoryUrl}"
            }
        }
        return returnPath
    }*/
    String fullDirPath(String category = null) {

        String returnPath = grailsApplication.config.imageindirect.basePath
//        String categoryUrl = category ? grailsApplication.config.imageindirect.category."${category}" : null

        /*if (categoryUrl) {
            if (categoryUrl.startsWith("/")) {
                returnPath = categoryUrl
            } else {
                returnPath += "/${categoryUrl}"
            }
        }*/
        if (category) {
            if (category.startsWith("/")) {
                returnPath = returnPath+category
            } else {
                returnPath = returnPath+"/${category}"
            }
        }

        return returnPath
    }

    /*File storeImage(MultipartFile multipartFile, String desiredName = null, String category = null) {
        if (!multipartFile) {
            return null
        }

        def storagePath = fullPath(category)
        def physicalFileName = desiredName ?: multipartFile.originalFilename
        File file = new File(storagePath, physicalFileName)
        multipartFile.transferTo(file)
        return file
    }*/
    File storeFile(MultipartFile multipartFile, String desiredName = null, String category = null) {
        if (!multipartFile) {
            return null
        }

        String storagePath = fullDirPath(category)

        String physicalFileName = desiredName ? desiredName.replaceAll(' ','_') : multipartFile.originalFilename.replaceAll(' ','_')
        File dirPath
        try{
            dirPath = new File(storagePath)
            if( !dirPath.exists() ) {
                dirPath.mkdirs()
            }
            dirPath = new File(storagePath, physicalFileName)
            println "dirPath " + dirPath
            multipartFile.transferTo(dirPath)
        }catch (Exception ex){
            ex.printStackTrace()
            dirPath = null
        }

        return dirPath
    }

    String imageLink( String imageName, String category) {
        grailsLinkGenerator.link(controller: 'imageIndirect' , params: [imageName: imageName, category:category] )
    }
    /*String imageLink2( String imageName, String category, String fileDir) {
        println("called it")
        grailsLinkGenerator.link(controller: 'imageIndirect' , params: [imageName: imageName, category:category,fileDir:fileDir] )
    }*/

    String lastResortImage() {
        grailsApplication.config.imageindirect.nophoto
    }
}
