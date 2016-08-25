#!/bin/bash
vercomp () {
if [[ $1 == $2 ]]
then
return 0
fi
local IFS=.
local i ver1=($1) ver2=($2)
    # fill empty fields in ver1 with zeros
    for ((i=${#ver1[@]}; i<${#ver2[@]}; i++))
do
ver1[i]=0
done
    for ((i=0; i<${#ver1[@]}; i++))
do
if [[ -z ${ver2[i]} ]]
then
            # fill empty fields in ver2 with zeros
ver2[i]=0
fi
        if ((10#${ver1[i]} > 10#${ver2[i]}))
then
return 1
fi
        if ((10#${ver1[i]} < 10#${ver2[i]}))
then
return 2
fi
done
return 0
}
 
glibc_vulnerable_version=2.17
glibc_vulnerable_revision=54
glibc_vulnerable_version2=2.5
glibc_vulnerable_revision2=122
glibc_vulnerable_version3=2.12
glibc_vulnerable_revision3=148
echo "Vulnerable glibc version <=" $glibc_vulnerable_version"-"$glibc_vulnerable_revision
echo "Vulnerable glibc version <=" $glibc_vulnerable_version2"-"$glibc_vulnerable_revision2
echo "Vulnerable glibc version <=" $glibc_vulnerable_version3"-1."$glibc_vulnerable_revision3
 
glibc_version=$(rpm -q glibc | awk -F"[-.]" '{print $2"."$3}' | sort -u)
if [[ $glibc_version == $glibc_vulnerable_version3 ]]
then
glibc_revision=$(rpm -q glibc | awk -F"[-.]" '{print $5}' | sort -u)
else
glibc_revision=$(rpm -q glibc | awk -F"[-.]" '{print $4}' | sort -u)
fi
echo "Detected glibc version" $glibc_version" revision "$glibc_revision
 
vulnerable_text=$"This system is vulnerable to CVE-2015-0235. <https://access.redhat.com/security/cve/CVE-2015-0235>
Update the glibc and ncsd packages on your system using the packages released with the following:
yum install glibc"
 
if [[ $glibc_version == $glibc_vulnerable_version ]]
then
vercomp $glibc_vulnerable_revision $glibc_revision
elif [[ $glibc_version == $glibc_vulnerable_version2 ]]
then
vercomp $glibc_vulnerable_revision2 $glibc_revision
elif [[ $glibc_version == $glibc_vulnerable_version3 ]]
then
vercomp $glibc_vulnerable_revision3 $glibc_revision
else
vercomp $glibc_vulnerable_version $glibc_version
fi
 
case $? in
    0) echo "$vulnerable_text";;
    1) echo "$vulnerable_text";;
    2) echo "Not Vulnerable.";;
esac

