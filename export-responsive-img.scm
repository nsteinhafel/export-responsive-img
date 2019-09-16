(define (export-responsive-img originalFile exportDirectory exportFileNameBase widthAtOneX heightAtOneX)
    (let*
        (
            ; file name for @1x
            (fileForOneX (string-append exportDirectory "/" exportFileNameBase ".jpg"))
            ; file name and dimensions for @2x
            (fileForTwoX (string-append exportDirectory "/" exportFileNameBase "@2x.jpg"))
            (widthAtTwoX (* widthAtOneX 2))
            (heightAtTwoX (* heightAtOneX 2))
            ; file name and dimensions for @3x
            (fileForThreeX (string-append exportDirectory "/" exportFileNameBase "@3x.jpg"))
            (widthAtThreeX (* widthAtOneX 3))
            (heightAtThreeX (* heightAtOneX 3))
        )

        (let* 
            (
                ; load image into "image"
                (image (car (gimp-file-load RUN-NONINTERACTIVE originalFile originalFile)))
            )

            ; disable the undo stack
            (gimp-image-undo-disable image)

            ; scale for 1x
            (gimp-image-scale image widthAtOneX heightAtOneX)

            ; save the image to the output file name
            (file-jpeg-save 1 image (car (gimp-image-active-drawable image)) fileForOneX fileForOneX 0.9 0 1 1 "" 0 1 0 0 )
            ; 0.9 quality -- TODO as arg?
            ; 0 smoothing factor
            ; 1 opt for entropy
            ; 1 enable prog loading
            ; "" comment, 0 subsampling
            ; 1 force creation of a baseline JPG
            ; 0 no restart markers
            ; 0 DCT algo
        )

        (let* 
            (
                ; load image into "image"
                (image (car (gimp-file-load RUN-NONINTERACTIVE originalFile originalFile)))
            )

            ; disable the undo stack
            (gimp-image-undo-disable image)

            ; scale for 2x
            (gimp-image-scale image widthAtTwoX heightAtTwoX)

            ; save the image to the output file name
            (file-jpeg-save 1 image (car (gimp-image-active-drawable image)) fileForTwoX fileForTwoX 0.9 0 1 1 "" 0 1 0 0 )
        )
        
        (let* 
            (
                ; load image into "image"
                (image (car (gimp-file-load RUN-NONINTERACTIVE originalFile originalFile)))
            )

            ; disable the undo stack
            (gimp-image-undo-disable image)
            
            ; scale for 3x
            (gimp-image-scale image widthAtThreeX heightAtThreeX)

            ; save the image to the output file name
            (file-jpeg-save 1 image (car (gimp-image-active-drawable image)) fileForThreeX fileForThreeX 0.9 0 1 1 "" 0 1 0 0 )
        )

        ; done
    )
)

; register with script fu
(script-fu-register
    ; function
    "export-responsive-img"
    ; label for menu
    "Export Responsive Image Set"
    ; description
    "Export an image as a set of responsive images ('example@1x.jpg', 'example@2x.jpg', 'example@3x.jpg') for web use"
    ; author
    ""
    ; copyright notice
    ""
    ; date
    "2019-01-30"
    ; image type restriction
    ""
    ; ARGUMENTS
    ; source file (originalFile)
    SF-FILENAME "Source File" ""
    ; destination folder (exportDirectory)
    SF-DIRNAME "Destination Folder" ""
    ; base name of exported files (exportFileBaseName)
    SF-STRING "Base Name" ""
    ; width at 1x (widthAtOneX)
    SF-VALUE "Width at 1x" "1000"
    ; height at 1x argument (heightAtOneX)
    SF-VALUE "Height at 1x" "1000"
  )
  
  ; register with the GIMP menu
  (script-fu-menu-register "export-responsive-img" "<Image>/File/Create")
