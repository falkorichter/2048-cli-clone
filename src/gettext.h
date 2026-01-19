#ifndef GETTEXT_H
#define GETTEXT_H

/* 
 * Optional gettext support
 * If libintl.h is not available (e.g., on macOS), provide stub macros
 */

#ifdef HAVE_LIBINTL
#include <libintl.h>
#else
/* Stub macros when gettext is not available */
#define gettext(Msgid) ((const char *) (Msgid))
#define dgettext(Domainname, Msgid) ((const char *) (Msgid))
#define dcgettext(Domainname, Msgid, Category) ((const char *) (Msgid))
#define ngettext(Msgid1, Msgid2, N) \
    ((N) == 1 ? (const char *) (Msgid1) : (const char *) (Msgid2))
#define dngettext(Domainname, Msgid1, Msgid2, N) \
    ((N) == 1 ? (const char *) (Msgid1) : (const char *) (Msgid2))
#define dcngettext(Domainname, Msgid1, Msgid2, N, Category) \
    ((N) == 1 ? (const char *) (Msgid1) : (const char *) (Msgid2))

#define textdomain(Domainname) ((const char *) (Domainname))
#define bindtextdomain(Domainname, Dirname) ((const char *) (Dirname))
#define bind_textdomain_codeset(Domainname, Codeset) ((const char *) (Codeset))
#endif /* HAVE_LIBINTL */

/* Include locale.h for setlocale if available */
#ifdef HAVE_LOCALE_H
#include <locale.h>
#else
#define setlocale(Category, Locale) ((char *) NULL)
#define LC_ALL 0
#define LC_CTYPE 1
#endif

#endif /* GETTEXT_H */
