# generated by configure / remove this line to disable regeneration
prefix="/usr/local"
exec_prefix="${prefix}"
bindir="${exec_prefix}/bin"
libdir="/raid/huwf_dev/build/c2hipc_v0.11/pet/.libs"
datarootdir="${prefix}/share"
datadir="${datarootdir}"
sysconfdir="${prefix}/etc"
includedir="/raid/huwf_dev/build/c2hipc_v0.11/pet/./include"
package="pet"
suffix=""

for option; do case "$option" in --list-all|--name) echo  "pet"
;; --help) pkg-config --help ; echo Buildscript Of "pet Library"
;; --modversion|--version) echo "0.11.3"
;; --requires) echo : ""
;; --libs) echo -L${libdir} "" "-lpet -lisl"
       :
;; --cflags) echo -I${includedir} ""
       :
;; --variable=*) eval echo '$'`echo $option | sed -e 's/.*=//'`
;; --uninstalled) exit 0 
;; *) ;; esac done
