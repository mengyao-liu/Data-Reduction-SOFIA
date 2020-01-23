PRO combine

;19um

fits_read, 'F0216_FO_IMA_030109183_FORF197_COA_0083-0090.fits', x19, h19

writefits, '2CepE_uncal_19um.fits', x19[*,*,0]   ;;ENTER output file name;;

TELESCOP = sxpar(h19, 'TELESCOP')
MISSNID  = sxpar(h19, 'MISSN-ID')
INSTRUME = sxpar(h19, 'INSTRUME')
OBJECT   = sxpar(h19, 'OBJECT')
DATEOBS = sxpar(h19, 'DATE-OBS')
FILTER   = sxpar(h19, 'FILTER')
d=sxpar(h19, 'DETITIME')*2.0*8.0 ; 90-83+1
print, 'Int time=', d

fits_read, '2CepE_uncal_19um.fits', d19, head

sxaddpar, head, 'OBSERVAT', TELESCOP,'Observatory'
sxaddpar, head, 'MISSN-ID=',MISSNID,'SOFIA Mission ID' 
sxaddpar, head, 'INSTRUME', INSTRUME,'Instrument name'
sxaddpar, head, 'OBJECT  ', OBJECT,'Name given by observer' 
sxaddpar, head, 'DATE-OBS',DATEOBS,'Observation start ccyy-mm-ddThh:mm:ss.s'   
sxaddpar, head, 'FILTER  ',FILTER,'FORCAST Filter Wavelength (microns)'

;Fill in by Hand:
sxaddpar, head, 'DICHROIC','YES','Dichroic present?'
sxaddpar, head, 'ITIME   ', d, 'On-source integration time (s)'


; Find centroid value in Spitzer image for source:    
CRVAL1=345.80325D              ;;ENTER info here;;
CRVAL2=61.707203D              ;;ENTER info here;;

; Find same source centroid in pipeline data
CRPIX1=185.208             ;;ENTER info here;;
CRPIX2=161.325            ;;ENTER info here;;
; Find the RA and DEC in the raw data to calibrate other images
xyad, h19, CRPIX1-1, CRPIX2-1, ra_ref, dec_ref



; Update header
sxaddpar, head, 'CRPIX1  ',CRPIX1,'Ref pix of axis 1'
sxaddpar, head, 'CRPIX2  ',CRPIX2,'Ref pix of axis 2'
sxaddpar, head, 'CRVAL1  ',CRVAL1,'RA at Ref pix in decimal degrees', format="f12.8"
sxaddpar, head, 'CRVAL2  ',CRVAL2,'DEC at Ref pix in decimal degrees', format="f12.8"
sxaddpar, head, 'EQUINOX','J2000','Equinox of observations
sxaddpar, head, 'CTYPE1  ','RA---TAN','R.A. in tangent plane projection'
sxaddpar, head, 'CTYPE2  ','DEC--TAN','DEC. in tangent plane projection'
sxaddpar, head, 'CDELT1  ',-2.1333333D-4,'Coord value increment deg/pixel'
sxaddpar, head, 'CDELT2  ',2.1333333D-4,'Coord value increment deg/pixel'
CALFACT   = 1.0/(sxpar(h19, 'CALFCTR'))
print, calfact
sxaddpar, head, 'FUNITS  ','Jy/pix','Flux density units'

writefits, '2CepE_SOFIA_19.7um_cal_ast.fits', d19*CALFACT, head    ;;ENTER final name here;;




;; 7um data

fits_read, 'F0216_FO_IMA_030109182_FORF077_COA_0075-0082.fits', x7, h7  ;;ENTER archive file name;;

writefits, '2CepE_uncal_7um.fits', x7[*,*,0]   ;;ENTER output file name;;

TELESCOP = sxpar(h7, 'TELESCOP')
MISSNID  = sxpar(h7, 'MISSN-ID')
INSTRUME = sxpar(h7, 'INSTRUME')
OBJECT   = sxpar(h7, 'OBJECT')
DATEOBS = sxpar(h7, 'DATE-OBS')
FILTER   = sxpar(h7, 'FILTER')
d=sxpar(h7, 'DETITIME')*2.0*8.0  ; 82-75+1
print, 'Int time=', d



fits_read, '2CepE_uncal_7um.fits', d7, head    ;;ENTER output file name again;;

sxaddpar, head, 'OBSERVAT', TELESCOP,'Observatory'
sxaddpar, head, 'MISSN-ID=',MISSNID,'SOFIA Mission ID' 
sxaddpar, head, 'INSTRUME', INSTRUME,'Instrument name'
sxaddpar, head, 'OBJECT  ', OBJECT,'Name given by observer' 
sxaddpar, head, 'DATE-OBS',DATEOBS,'Observation start ccyy-mm-ddThh:mm:ss.s'   
sxaddpar, head, 'FILTER  ',FILTER,'FORCAST Filter Wavelength (microns)'

;Fill in by Hand:
sxaddpar, head, 'DICHROIC','YES','Dichroic present?'  ;;ENTER YES or NO here;;


sxaddpar, head, 'ITIME   ', d, 'On-source integration time (s)'
; Find centroid value in Spitzer image for source: 
CRVAL1=345.80325D              ;;ENTER info here;;
CRVAL2=61.707203D              ;;ENTER info here;;


; Find same source centroid in pipeline data
adxy, h7, ra_ref, dec_ref, xref, yref
CRPIX1 = xref+1
CRPIX2 = yref+1



; Update header
sxaddpar, head, 'CRPIX1  ',CRPIX1,'Ref pix of axis 1'
sxaddpar, head, 'CRPIX2  ',CRPIX2,'Ref pix of axis 2'
sxaddpar, head, 'CRVAL1  ',CRVAL1,'RA at Ref pix in decimal degrees', format="f12.8"
sxaddpar, head, 'CRVAL2  ',CRVAL2,'DEC at Ref pix in decimal degrees', format="f12.8"
sxaddpar, head, 'EQUINOX','J2000','Equinox of observations
sxaddpar, head, 'CTYPE1  ','RA---TAN','R.A. in tangent plane projection'
sxaddpar, head, 'CTYPE2  ','DEC--TAN','DEC. in tangent plane projection'
sxaddpar, head, 'CDELT1  ',-2.1333333D-4,'Coord value increment deg/pixel'
sxaddpar, head, 'CDELT2  ',2.1333333D-4,'Coord value increment deg/pixel'
CALFACT   = 1.0/(sxpar(h7, 'CALFCTR'))
print, calfact
sxaddpar, head, 'FUNITS  ','Jy/pix','Flux density units'

writefits, '2CepE_SOFIA_7.7um_cal_ast.fits', d7*CALFACT, head





;37um

fits_read, 'F0216_FO_IMA_030109182_FORF371_COA_0075-0088.fits', x37, h37

writefits, '2CepE_uncal_37um.fits', x37[*,*,0]

TELESCOP = sxpar(h37, 'TELESCOP')
MISSNID  = sxpar(h37, 'MISSN-ID')
INSTRUME = sxpar(h37, 'INSTRUME')
OBJECT   = sxpar(h37, 'OBJECT')
DATEOBS = sxpar(h37, 'DATE-OBS')
FILTER   = sxpar(h37, 'FILTER')
d=sxpar(h37, 'DETITIME')*2.0*14.0  ;88-75+1
print, 'Int time=', d

fits_read, '2CepE_uncal_37um.fits', d37, head

sxaddpar, head, 'OBSERVAT', TELESCOP,'Observatory'
sxaddpar, head, 'MISSN-ID=',MISSNID,'SOFIA Mission ID' 
sxaddpar, head, 'INSTRUME', INSTRUME,'Instrument name'
sxaddpar, head, 'OBJECT  ', OBJECT,'Name given by observer' 
sxaddpar, head, 'DATE-OBS',DATEOBS,'Observation start ccyy-mm-ddThh:mm:ss.s'   
sxaddpar, head, 'FILTER  ',FILTER,'FORCAST Filter Wavelength (microns)'

;Fill in by Hand:
sxaddpar, head, 'DICHROIC','NO','Dichroic present?'
sxaddpar, head, 'ITIME   ', d, 'On-source integration time (s)'

; Find centroid value in Spitzer image for source: 
CRVAL1=345.80325D              ;;ENTER info here;;
CRVAL2=61.707203D              ;;ENTER info here;;


; Find same source centroid in pipeline data
adxy, h37, ra_ref, dec_ref, xref, yref
CRPIX1 = xref+1
CRPIX2 = yref+1


; Update header
sxaddpar, head, 'CRPIX1  ',CRPIX1,'Ref pix of axis 1'
sxaddpar, head, 'CRPIX2  ',CRPIX2,'Ref pix of axis 2'
sxaddpar, head, 'CRVAL1  ',CRVAL1,'RA at Ref pix in decimal degrees', format="f12.8"
sxaddpar, head, 'CRVAL2  ',CRVAL2,'DEC at Ref pix in decimal degrees', format="f12.8"
sxaddpar, head, 'EQUINOX','J2000','Equinox of observations
sxaddpar, head, 'CTYPE1  ','RA---TAN','R.A. in tangent plane projection'
sxaddpar, head, 'CTYPE2  ','DEC--TAN','DEC. in tangent plane projection'
sxaddpar, head, 'CDELT1  ',-2.1333333D-4,'Coord value increment deg/pixel'
sxaddpar, head, 'CDELT2  ',2.1333333D-4,'Coord value increment deg/pixel'
CALFACT   = 1.0/(sxpar(h37, 'CALFCTR'))
print, calfact
sxaddpar, head, 'FUNITS  ','Jy/pix','Flux density units'

writefits, '2CepE_SOFIA_37.1um_cal_ast.fits', d37*CALFACT, head




; combine
img_ref=readfits('CepE_SOFIA_7.7um_cal_cut.fits', h_ref)
d1 = sxpar(h_ref, 'ITIME')
img_old=readfits('2CepE_SOFIA_7.7um_cal_ast.fits', h_old)
d2 = sxpar(h_old, 'ITIME')
hastrom, img_old, h_old, newim, newh, h_ref, missing=0
sxaddpar, newh, 'ITIME   ', d1+d2, 'On-source integration time (s)'
im_combine = (img_ref*d1+newim*d2)/(d1+d2)
mwrfits, im_combine, 'CepE_SOFIA_7.7um_cal_ast_combine.fits', newh, /create


img_ref=readfits('CepE_SOFIA_19.7um_cal_cut.fits', h_ref)
d1 = sxpar(h_ref, 'ITIME')
img_old=readfits('2CepE_SOFIA_19.7um_cal_ast.fits', h_old)
d2 = sxpar(h_old, 'ITIME')
hastrom, img_old, h_old, newim, newh, h_ref, missing=0
mwrfits, newim, 'test.fits', newh, /create
sxaddpar, newh, 'ITIME   ', d1+d2, 'On-source integration time (s)'
im_combine = (img_ref*d1+newim*d2)/(d1+d2)
mwrfits, im_combine, 'CepE_SOFIA_19.7um_cal_ast_combine.fits', newh, /create



img_ref=readfits('CepE_SOFIA_37.1um_cal_cut.fits', h_ref)
d1 = sxpar(h_ref, 'ITIME')
img_old=readfits('2CepE_SOFIA_37.1um_cal_ast.fits', h_old)
d2 = sxpar(h_old, 'ITIME')
hastrom, img_old, h_old, newim, newh, h_ref, missing=0
sxaddpar, newh, 'ITIME   ', d1+d2, 'On-source integration time (s)'
im_combine = (img_ref*d1+newim*d2)/(d1+d2)
mwrfits, im_combine, 'CepE_SOFIA_37.1um_cal_ast_combine.fits', newh, /create





END