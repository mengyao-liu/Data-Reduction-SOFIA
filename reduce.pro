; All Spitzer images saturated, use another weak point. 
PRO reduce

;19um

fits_read, 'F0254_FO_IMA_030109184_FORF197_COA_0215-0234.fits', x19, h19

writefits, 'CepE_uncal_19um.fits', x19[*,*,0]   ;;ENTER output file name;;

TELESCOP = sxpar(h19, 'TELESCOP')
MISSNID  = sxpar(h19, 'MISSN-ID')
INSTRUME = sxpar(h19, 'INSTRUME')
OBJECT   = sxpar(h19, 'OBJECT')
DATEOBS = sxpar(h19, 'DATE-OBS')
FILTER   = sxpar(h19, 'FILTER')
d=sxpar(h19, 'DETITIME')*2.0*20.0 ; 234-215+1
print, 'Int time=', d

fits_read, 'CepE_uncal_19um.fits', d19, head

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
CRPIX1=182.930            ;;ENTER info here;;
CRPIX2=151.159            ;;ENTER info here;;
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

writefits, 'CepE_SOFIA_19.7um_cal_ast.fits', d19*CALFACT, head    ;;ENTER final name here;;




;; 7um data

fits_read, 'F0254_FO_IMA_030109182_FORF077_COA_0222-0228.fits', x7, h7  ;;ENTER archive file name;;

writefits, 'CepE_uncal_7um.fits', x7[*,*,0]   ;;ENTER output file name;;

TELESCOP = sxpar(h7, 'TELESCOP')
MISSNID  = sxpar(h7, 'MISSN-ID')
INSTRUME = sxpar(h7, 'INSTRUME')
OBJECT   = sxpar(h7, 'OBJECT')
DATEOBS = sxpar(h7, 'DATE-OBS')
FILTER   = sxpar(h7, 'FILTER')
d=sxpar(h7, 'DETITIME')*2.0*7.0  ; 228-222+1
print, 'Int time=', d



fits_read, 'CepE_uncal_7um.fits', d7, head    ;;ENTER output file name again;;

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

writefits, 'CepE_SOFIA_7.7um_cal_ast.fits', d7*CALFACT, head



;31um

fits_read, 'F0254_FO_IMA_030109184_FORF315_COA_0215-0234.fits', x31, h31

writefits, 'CepE_uncal_31um.fits', x31[*,*,0]

TELESCOP = sxpar(h31, 'TELESCOP')
MISSNID  = sxpar(h31, 'MISSN-ID')
INSTRUME = sxpar(h31, 'INSTRUME')
OBJECT   = sxpar(h31, 'OBJECT')
DATEOBS = sxpar(h31, 'DATE-OBS')
FILTER   = sxpar(h31, 'FILTER')
d=sxpar(h31, 'DETITIME')*2.0*20.0  ; 234-215+1
print, 'Int time=', d

fits_read, 'CepE_uncal_31um.fits', d31, head

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
adxy, h31, ra_ref, dec_ref, xref, yref
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
CALFACT   = 1.0/(sxpar(h31, 'CALFCTR'))
print, calfact
sxaddpar, head, 'FUNITS  ','Jy/pix','Flux density units'

writefits, 'CepE_SOFIA_31.5um_cal_ast.fits', d31*CALFACT, head

;37um

fits_read, 'F0254_FO_IMA_030109182_FORF371_COA_0222-0228.fits', x37, h37

writefits, 'CepE_uncal_37um.fits', x37[*,*,0]

TELESCOP = sxpar(h37, 'TELESCOP')
MISSNID  = sxpar(h37, 'MISSN-ID')
INSTRUME = sxpar(h37, 'INSTRUME')
OBJECT   = sxpar(h37, 'OBJECT')
DATEOBS = sxpar(h37, 'DATE-OBS')
FILTER   = sxpar(h37, 'FILTER')
d=sxpar(h37, 'DETITIME')*2.0*7.0  ;228-222+1
print, 'Int time=', d

fits_read, 'CepE_uncal_37um.fits', d37, head

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

writefits, 'CepE_SOFIA_37.1um_cal_ast.fits', d37*CALFACT, head



;70um

fits_read, 'unimap_l110_blue_wglss_rcal.fits', d70, head

; Find centroid value in Spitzer image for source: 
; Galactic lon 
CRVAL1=110.44652D              ;;ENTER info here;;
; Galactic lat
CRVAL2=1.5059051D  

; Find same source centroid in pipeline data
CRPIX1=979.172
CRPIX2=2050.06

; Update header
sxaddpar, head, 'CRPIX1  ',CRPIX1,'Ref pix of axis 1'
sxaddpar, head, 'CRPIX2  ',CRPIX2,'Ref pix of axis 2'
sxaddpar, head, 'CRVAL1  ',CRVAL1,'GLON at Ref pix in decimal degrees', format="f12.8"
sxaddpar, head, 'CRVAL2  ',CRVAL2,'GLAT at Ref pix in decimal degrees', format="f12.8"

;Convert MJy/sr to Jy/pix
cdelt70 = sxpar(head, 'CDELT2')
d70=d70*cdelt70^2*304.61741978670857
sxaddpar, head, 'BUNIT', 'Jy/pix', 'Units of image data (Jy/pix)'

writefits, 'CepE_Herschel_70um_cal_ast.fits', d70, head


;160um

fits_read, 'unimap_l110_red_wglss_rcal.fits', d160, head

; Find centroid value in Spitzer image for source: 
; Galactic lon 
CRVAL1=110.44652D              ;;ENTER info here;;
; Galactic lat
CRVAL2=1.5059051D  


; Find same source centroid in pipeline data
CRPIX1=694.133
CRPIX2=1455.87

; Update header
sxaddpar, head, 'CRPIX1  ',CRPIX1,'Ref pix of axis 1'
sxaddpar, head, 'CRPIX2  ',CRPIX2,'Ref pix of axis 2'
sxaddpar, head, 'CRVAL1  ',CRVAL1,'GLON at Ref pix in decimal degrees', format="f12.8"
sxaddpar, head, 'CRVAL2  ',CRVAL2,'GLAT at Ref pix in decimal degrees', format="f12.8"

;Convert MJy/sr to Jy/pix
cdelt160 = sxpar(head, 'CDELT2')
d160=d160*cdelt160^2*304.61741978670857
sxaddpar, head, 'BUNIT', 'Jy/pix', 'Units of image data (Jy/pix)'

writefits, 'CepE_Herschel_160um_cal_ast.fits', d160, head


;250um

fits_read, 'unimap_l110_PSW_wglss_rcal.fits', d250, head

;Convert MJy/sr to Jy/pix
cdelt250 = sxpar(head, 'CDELT2')
d250=d250*cdelt250^2*304.61741978670857
sxaddpar, head, 'BUNIT', 'Jy/pix', 'Units of image data (Jy/pix)'

writefits, 'CepE_Herschel_250um_cal_ast.fits', d250, head



;350um

fits_read, 'unimap_l110_PMW_wglss_rcal.fits', d350, head

;Convert MJy/sr to Jy/pix
cdelt350 = sxpar(head, 'CDELT2')
d350=d350*cdelt350^2*304.61741978670857
sxaddpar, head, 'BUNIT', 'Jy/pix', 'Units of image data (Jy/pix)'

writefits, 'CepE_Herschel_350um_cal_ast.fits', d350, head



;500um

fits_read, 'unimap_l110_PLW_wglss_rcal.fits', d500, head

;Convert MJy/sr to Jy/pix
cdelt500 = sxpar(head, 'CDELT2')
d500=d500*cdelt500^2*304.61741978670857
sxaddpar, head, 'BUNIT', 'Jy/pix', 'Units of image data (Jy/pix)'

writefits, 'CepE_Herschel_500um_cal_ast.fits', d500, head





END