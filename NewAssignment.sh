#!/bin/bash
echo Sheet Number:
read sheetNumber

echo Number of Exercises:
read nmbrExercises

date=$(date '+%Y-%m-%d')

title=$(sed -n '1p' config.txt | sed -E 's/(.*):(.*)/\2/')
group=$(sed -n '2p' config.txt | sed -E 's/(.*):(.*)/\2/')
students=""
studentNames=""

while IFS= read -r line
do
	if echo "$line" | grep -Eq 'Name: .*'
	then
		name=$(echo $line | sed -E 's/Name: (.*) StudentNumber: (.*)/\1/')
		studentid=$(echo $line | sed -E 's/Name: (.*) StudentNumber: (.*)/\2/')
		students="${students}$name ($studentid) \\\\\\\\ "
		studentNames="${studentNames}$(echo $name | sed -E 's/(.*)\s(.*)/\2/')"
	fi
done < config.txt

cp -a "Template/." "UE0"$sheetNumber"/"

cd UE0"$sheetNumber"

cd main

sed -i "s/%sheetnr/$sheetNumber/g" main.tex
sed -i "s/%Authors/$students/g" main.tex
sed -i "s/XXXXXXXX/$date/g" main.tex
sed -i "s/%Title/$title/g" main.tex
sed -i "s/.*%title/${title} \\\\\\\\ %title/g" ../../styles/FormatAndHeader.tex
sed -i "s/.*%Authors/${students}%Authors/g" ../../styles/FormatAndHeader.tex
sed -i "s/.*%group/${group}%group/g" ../../styles/FormatAndHeader.tex

month=$(date '+%m')
year=$(date '+%Y')
if [ $month -le 3 ] || [ $month -ge 10 ]
then
	sed -i "s/.*%tornus/Wintersemester $year \\\\\\\\ %tornus/g" ../../styles/FormatAndHeader.tex
else
	sed -i "s/.*%tornus/Sommersemester $year \\\\\\\\ %tornus/g" ../../styles/FormatAndHeader.tex
fi

studentNames=$(echo $studentNames | sed -i 's/ü/ue/g')
studentNames=$(echo $studentNames | sed -i 's/ä/ae/g')
studentNames=$(echo $studentNames | sed -i 's/ö/oe/g')
mv main.tex "${studentNames}_UE0${sheetNumber}.tex"

cd ..
subfilestring=""

for (( i=1; i<=$nmbrExercises; i++ ))
do
	cp -a "Exercise_Template/." "Exercise_0"$i"/"
	mv Exercise_0"$i"/Ex00.tex Exercise_0"$i"/Ex0"$i".tex
	command=s/"$filename"_UE00.tex/"$filename"_UE0"$sheetNumber".tex/g
	sed -i "$command" "Exercise_0"$i"/Ex0"$i".tex"
	subfilestring="$subfilestring"\\\\subfile\\\{../Exercise_0"$i"/Ex0"$i"\\\}
	sed -i "s/FILENAME/..\/main\/${studentNames}_UE0${sheetNumber}.tex/g" "Exercise_0${i}/Ex0${i}.tex"
	sed -i "s/%subfile/\\\\subfile\{..\/Exercise_0${i}\/Ex0${i}.tex\}\n%subfile/g" "main/${studentNames}_UE0${sheetNumber}.tex"
done

rm -r Exercise_Template
