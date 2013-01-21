for i in "$@"; do 
    k=$(basename "$i")
    j="${k%.*}.tcx"
    echo "$i => $j"
    xsltproc gym2tcx.xslt "$i" | perl -MPOSIX -ple 's/AWKME:(\d+):/$a=POSIX::strftime("%FT%T%z",localtime($1));substr($a,0,-2).":".substr($a,-2)/e;' > "$j"
done

