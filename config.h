/* config.h.  Generated from config.h.in by configure.  */
/* Size of off_T */
#define SIZEOF_OFF_T 8

/* Version number of package */
/* #undef VERSION */

/* Define to make fseeko etc. visible, on some hosts. */
/* #undef _LARGEFILE_SOURCE */

/* Define for large files, on AIX-style hosts. */
/* #undef _LARGE_FILES */

/* Number of bits in a file offset, on hosts where this is settable.
       case  in
        # HP-UX 10.20 and later
        hpux10.2-90-9* | hpux11-9* | hpux2-90-9*)
          ac_cv_sys_file_offset_bits=64 ;;
        esac */     
/* #undef _FILE_OFFSET_BITS */

#define HAVE_LIBSSL 1
/* #undef HAVE_ZEROCONF */

#define HAVE_LIBPAM 1
/* #undef HAVE_PAM_PAM_APPL_H */
#define HAVE_SECURITY_PAM_APPL_H 1

#define HAVE_DNSSD 1
/* #undef HAVE_LCHOWN */
/* #undef HAVE_LCHMOD */
#define HAVE_ZLIB 1

#define HAVE_WAIT4 1
#define HAVE_STRTOLL 1

#ifndef MIN
#define MIN(a,b)        ((a)<(b)?(a):(b))
#endif /* MIN */

#ifndef MAX
#define MAX(a,b)        ((a)>(b)?(a):(b))
#endif /* MAX */
