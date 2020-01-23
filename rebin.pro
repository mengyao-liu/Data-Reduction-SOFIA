;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Create figures suitable for publication ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


PRO rebin



;;7um

;;;; Crop to size desired for publication ;;;;
; Read in calibrated data and astrometry corrected data
fits_read, 'CepE_SOFIA_7.7um_cal_ast_combine.fits', im, hdr
;; Find pixel coordinates for what will be the center of the images (input as RA/Dec)
ADXY, hdr, 345.8033333, 61.70722222, xc, yc
; Define size of image in pixels and extract
bsiz=134.0   ;;This is the size of the box in pixels to crop around the centroid of the source
bsize=bsiz/2.0
x1=xc-bsize & x2=xc+bsize
y1=yc-bsize & y2=yc+bsize
hextract, im, hdr, im2, hdr2, x1, x2, y1, y2
sz=size(im2)

hcongrid, im2, hdr2, fimf, fhdrf, 1000.0, 1000.0, /HALF, cubic=-0.5
fimf=fimf/((1000.0/sz[1])*(1000.0/sz[2]))
pixsize = sxpar(fhdrf, 'CDELT1')    
fimf = fimf*1e3/(pixsize*3600.)^2  ; Jy/pix to mJy/sq-arc
sxaddpar, fhdrf, 'FUNITS','mJy/sq-arc','Flux density units'
writefits, 'SOFIA7uma.fits', fimf, fhdrf



;;19um
img_ref=readfits('SOFIA7uma.fits', h_ref)
img_old=readfits('CepE_SOFIA_19.7um_cal_ast_combine.fits', h_old)
pixsize = sxpar(h_old, 'CDELT1')    
img_old = img_old*1e3/(pixsize*3600.)^2  ; Jy/pix to mJy/sq-arc
sxaddpar, h_old, 'FUNITS','mJy/sq-arc','Flux density units'
hastrom, img_old, h_old, newim, newh, h_ref, missing=0
mwrfits, newim, 'SOFIA19uma.fits', newh, /create


;;31um
img_ref=readfits('SOFIA7uma.fits', h_ref)
img_old=readfits('CepE_SOFIA_31.5um_cal_skyfitm.fits', h_old)
pixsize = sxpar(h_old, 'CDELT1')    
img_old = img_old*1e3/(pixsize*3600.)^2  ; Jy/pix to mJy/sq-arc
sxaddpar, h_old, 'FUNITS','mJy/sq-arc','Flux density units'
hastrom, img_old, h_old, newim, newh, h_ref, missing=0
mwrfits, newim, 'SOFIA31uma.fits', newh, /create


;;37um

img_ref=readfits('SOFIA7uma.fits', h_ref)
img_old=readfits('CepE_SOFIA_37.1um_cal_ast_combine.fits', h_old)
pixsize = sxpar(h_old, 'CDELT1')    
img_old = img_old*1e3/(pixsize*3600.)^2  ; Jy/pix to mJy/sq-arc
sxaddpar, h_old, 'FUNITS','mJy/sq-arc','Flux density units'
hastrom, img_old, h_old, newim, newh, h_ref, missing=0
mwrfits, newim, 'SOFIA37uma.fits', newh, /create


;; IRAC 8um

img_ref=readfits('SOFIA7uma.fits', h_ref)
img_old=readfits('SPITZER_I4_6064384_0000_7_E8772406_maic.fits', h_old)
pixsize = sxpar(h_old, 'CD2_2')    
sxaddpar, h_old, 'PXSCAL1',pixsize*3600,'[arcsec/pix] Scale for axis 1 at CRPIX1,CRPIX2'
sxaddpar, h_old, 'PXSCAL2',pixsize*3600,'[arcsec/pix] Scale for axis 1 at CRPIX1,CRPIX2'
img_old = img_old*1e3*(!pi/(18.*36.))^2  ; MJy/sr to mJy/sq-arc   
sxaddpar, h_old, 'BUNIT','mJy/sq-arc','Flux density units'
hastrom, img_old, h_old, newim, newh, h_ref, missing=0
mwrfits, newim, 'IRAC8uma.fits', newh, /create

;;70um

img_ref=readfits('SOFIA7uma.fits', h_ref)
FITS_OPEN, 'hpacs_25HPPJSMAPB_blue_2259_p6114_00_v1.0_1472196483439.fits', fcb 
FITS_READ, fcb, img_old, h_old, exten_no = 1 
pixsize = sxpar(h_old, 'CDELT1')    
img_old = img_old*1e3/(pixsize*3600.)^2  ; Jy/pix to mJy/sq-arc
sxaddpar, h_old, 'BUNIT','mJy/sq-arc','Flux density units'
hastrom, img_old, h_old, newim, newh, h_ref, missing=0
FITS_CLOSE, fcb 
WRITEFITS, 'Herschel70uma.fits', newim, newh



END

