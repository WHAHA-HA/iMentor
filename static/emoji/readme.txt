Tools Used :
ImageMagic
glue

$  for file in *.png; do convert $file  -resize 20 $file; done

$ glue-sprite img-apple-20 sprite-20 --sprite-namespace= --namespace=emoji 
$ glue-sprite img-apple-20 sprite-20-png8 --sprite-namespace= --namespace=emoji --png8

