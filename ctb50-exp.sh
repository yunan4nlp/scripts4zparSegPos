

rm ctb50/devo.txt.* ctb50/testo.txt.*  ctb50/joint.model*
for i in `seq 1 40`;
do
    echo "Test iteration $i"
    ./train ctb50/train.ctb50.pos ctb50/joint.model 1
    ./tagger ctb50/joint.model ctb50/dev.ctb50.chars ctb50/devo.txt.$i 
    java -Xmx1G -jar JointSTEvaluate.jar  ctb50/dev.ctb50.pos  ctb50/devo.txt.$i 
    ./tagger ctb50/joint.model ctb50/test.ctb50.chars ctb50/testo.txt.$i 
    java -Xmx1G -jar JointSTEvaluate.jar  ctb50/test.ctb50.pos  ctb50/testo.txt.$i 
    cp ctb50/joint.model ctb50/joint.model.$i
done
