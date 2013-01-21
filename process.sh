for i in "$@"; do 
    k=$(basename "$i")
    j="${k%.*}.tcx"
    echo "$i => $j"
    xsltproc gym2tcx.xslt "$i" > "$j"
done

