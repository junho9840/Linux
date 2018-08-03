#!/bin/bash


declare -a file_list=() #출력할 리스트를 저장할 배열 선언
declare -a a_list=() # 배열로 저장한 배열을 저장하기 위한 배열 선언
declare -a tree_list=() #트리 리스트를 배열에 저장


declare -a tree_list_dep1=() #트리 리스트를 배열에 저장
declare -a tree_list_dep2=() #트리 리스트를 배열에 저장
declare -a tree_list_dep3=() #트리 리스트를 배열에 저장
declare -a tree_list_dep4=() #트리 리스트를 배열에 저장
declare -a tree_list_dep5=() #트리 리스트를 배열에 저장



declare -i x=2
declare -i y=2

file_list=`ls -a | grep '\.\.'; ls | grep *"TrashBin"; ls -1 | sort | grep -v '/$' | grep -v "TrashBin";`
a_list=($file_list)



declare -i I=0 # 커서를 저장할 정수형 변수 선언


declare -a save_pwd=() #TrashBin 경로 저장
cd `ls | grep *"TrashBin"`
save_pwd=`pwd`
cd ../







function PrintForm(){ #print form 폼 출력
echo "============================================= 2015726099 JoonHo Lee ===================================================="
echo "======================================================== List =========================================================="
echo "|                                      |                                       |                                       |"
echo "|                                      |                                       |                                       |"
echo "|                                      |                                       |                                       |"
echo "|                                      |                                       |                                       |"
echo "|                                      |                                       |                                       |"
echo "|                                      |                                       |                                       |"
echo "|                                      |                                       |                                       |"
echo "|                                      |                                       |                                       |"
echo "|                                      |                                       |                                       |"
echo "|                                      |                                       |                                       |"
echo "|                                      |                                       |                                       |"
echo "|                                      |                                       |                                       |"
echo "|                                      |                                       |                                       |"
echo "|                                      |                                       |                                       |"
echo "|                                      |                                       |                                       |"
echo "|                                      |                                       |                                       |"
echo "|                                      |                                       |                                       |"
echo "|                                      |                                       |                                       |"
echo "|                                      |                                       |                                       |"
echo "|                                      |                                       |                                       |"
echo "|                                      |                                       |                                       |"
echo "|                                      |                                       |                                       |"
echo "|                                      |                                       |                                       |"
echo "|                                      |                                       |                                       |"
echo "|                                      |                                       |                                       |"
echo "|                                      |                                       |                                       |"
echo "|                                      |                                       |                                       |"
echo "|                                      |                                       |                                       |"
echo "===================================================== Information ======================================================"
echo "|                                                                                                                      |"
echo "|                                                                                                                      |"
echo "|                                                                                                                      |"
echo "|                                                                                                                      |"
echo "|                                                                                                                      |"
echo "|                                                                                                                      |"
echo "======================================================= Total =========================================================="
echo "|                                                                                                                      |"
echo "======================================================== END ==========================================================="
}




function Print_Files(){   #현재 위치의 파일 및 디렉토리 출력
	i=0
	j=2
	tput cup 2 3
	if [ $I -eq 0 ] #커서의 위치가 초기값이면
	then
	echo -e "\e[7m[34m..[0m\e[27m" #색칠한 ..출력
	else
	echo -e "[34m..[0m" # 색칠안한 ..출력
	fi
	until [ $i = ${#a_list[*]} ]
	do
	tput cup $j 2
		if (( i > 29 )) # 예외처리 출력할 파일들이 29줄 이상이면 그 이상은 출력 안함
		then
			:
		elif (( i == 0 )) # 초기값이면 그대로 진행
		then
			:
		elif (( $I == $i )) # 커서위치 색깔 변화
		then
			check_file_type=`stat -c "%n" ${a_list[$I]} | grep '.gz' | wc -l`
			check_file_type2=`stat -c "%n" ${a_list[$I]} | grep '.zip' | wc -l`
			if [ -d ${a_list[$I]} ]                                               #디렉토리이면
			then
				if [ ${a_list[$i]} = *"TrashBin" ]
				then
					echo -e "\e[7m" "[33m ${a_list[$i]} [0m" "\e[27m" | cut -c 1-39
				else
					echo -e "\e[7m" "[34m ${a_list[$i]} [0m" "\e[27m" | cut -c 1-39
				fi
			elif [ $check_file_type -eq 1 ]                                       #압축파일이면
			then
				echo -e "\e[7m" "[31m ${a_list[$i]} [0m" "\e[27m" | cut -c 1-39
			elif [ $check_file_type2 -eq 1 ]                                      #압축파일이면2
			then
				echo -e "\e[7m" "[31m ${a_list[$i]} [0m" "\e[27m" | cut -c 1-39
			elif [ -x ${a_list[$I]} ]                                       #실행파일이면
			then
				echo -e "\e[7m" "[32m ${a_list[$i]} [0m" "\e[27m" | cut -c 1-39
			else
				echo -e "\e[7m ${a_list[$i]} \e[27m" | cut -c 1-39                  #일반파일이면
			fi
			printf "[0m"
		else # 커서 위치가 아닌곳 색깔 변화
			if [ -d ${a_list[$i]} ]                                         #디렉토리이면
			then
				if [ ${a_list[$i]} = *"TrashBin" ]
				then
					echo -e "[33m ${a_list[$i]} [0m" | cut -c 1-35
				else
					echo -e "[34m ${a_list[$i]} [0m" | cut -c 1-35
				fi
			elif [ -f ${a_list[$i]} ]                                #파일구분
			then
				if [ -x ${a_list[$i]} ] #실행파일이면
				then
					echo -e "[32m ${a_list[$i]} [0m" | cut -c 1-35
				elif [ ${a_list[$i]} = *.gz ] || [ ${a_list[$i]} = *.zip ]
				then
					echo -e "[31m ${a_list[$i]} [0m" | cut -c 1-35
				else
					echo -e "${a_list[$i]}" | cut -c 1-35
				fi
			else
				echo -e "${a_list[$i]}" # 디렉토리도 파일도 아니면 그냥 일반색으로 출력
			fi		
		fi
	i=`expr $i + 1` # 다음 배열 불러오기 위해 1 증가
	j=`expr $j + 1` # 다음 출력할 위치 1 증가
	done
}



function Statement(){ #-c 출력형식을 지정
	check_file_type=`stat -c "%n" ${a_list[$I]} | grep '.gz' | wc -l` 
	check_file_type2=`stat -c "%n" ${a_list[$I]} | grep '.zip' | wc -l`
	check_file_type3=`stat -c "%n" ${a_list[$I]} | grep '.sh' | wc -l`


	tput cup 31 2
	echo  "`stat -c 'file name : %n' ${a_list[$I]}`" | cut -c 1-115      #파일 이름

	tput cup 32 2
	if [ -d ${a_list[$I]} ]
	then
		if [ ${a_list[$I]} = *"TrashBin" ]
		then
			echo -e "[33mfile type : TrashBin [0m"
		else
			echo -e "[34mfile type : directory [0m"      #파일 타입이 디렉토리
		fi
	elif [ $check_file_type -eq 1 ]
	then
	echo -e "[31mfile type : compressed file [0m"      #파일 타입이 압축파일
	elif [ $check_file_type2 -eq 1 ]
	then
	echo -e "[31mfile type : compressed file [0m"      #파일 타입이 압축파일
	elif [ $check_file_type3 -eq 1 ]
	then
	echo -e "[32mfile type : execute file [0m"      #파일 타입이 실행 파일
	else
	echo "file type : normal file"
	fi
	
	file_size_for_human=`du -sh ${a_list[$I]} | cut -f1`

	tput cup 33 2
	echo "file size : $file_size_for_human"		# file_size




	
	stat -c %x ${a_list[$I]} | cut -f1 -d'.' > date.txt
	tput cup 34 2
	sed -i 's/2018-01/Access time : January /g' date.txt
	tput cup 34 2
	sed -i 's/2018-02/Access time : Febuary /g' date.txt
	tput cup 34 2
	sed -i 's/2018-03/Access time : March /g' date.txt
	tput cup 34 2
	sed -i 's/2018-04/Access time : April /g' date.txt
	tput cup 34 2
	sed -i 's/2018-05/Accesstime ; May /g' date.txt
	tput cup 34 2
	sed -i 's/2018-06/Access time : June /g' date.txt
	tput cup 34 2
	sed -i 's/2018-07/Access time : July /g' date.txt
	tput cup 34 2
	sed -i 's/2018-08/Access time : August /g' date.txt
	tput cup 34 2
	sed -i 's/2018-09/Access time : September /g' date.txt
	tput cup 34 2
	sed -i 's/2018-10/Access time : October /g' date.txt
	tput cup 34 2
	sed -i 's/2018-11/Access time : November /g' date.txt
	tput cup 34 2
	sed -i 's/2018-12/Access time : December /g' date.txt



	tput cup 34 2
	sed -i 's/-//g' date.txt
	tput cup 34 2
	sed 's/$/ 2018/g' date.txt
	

	tput cup 34 2
	cat date.txt
	rm -r date.txt



	tput cup 35 2
	echo "`stat -c 'permission : %a' ${a_list[$I]}`"     #8진수 형태의 접근권한
	tput cup 36 2
	echo -n "absolute path :  `pwd`/${a_list[$I]}" | cut -c 1-115        #파일의 절대경로
	tput cup 38 2
}

function Total_Info(){ #현제 경로의의 총 정보 출력
	Total_n=`ls | wc -l` #파일 전체 개수
	Dir_n=`ls -lF | grep '/' | grep -v *"TrashBin" | wc -l`			# 디렉토리 개수
	S1file_n=`ls -lF | grep 'sh' | wc -l`			# sh파일 개수
	S2file_n=`ls -lF | grep 'zip' | wc -l`
	S3file_n=`ls -lF | grep 'gz' | wc -l`
	SFile_n=`expr $S1file_n + $S2file_n + $S3file_n`
	File_n=`expr $Total_n - $Dir_n - $SFile_n`		# 일반 파일 개수
#	Byte_n=`du . | tail -n 1 | head -c 2`			# 현재 디렉토리의 전체
	Byte_n=`du -sh | cut -f1`
	tput cup 38 2
	echo "Total : $Total_n, Directory : $Dir_n, SFile : $SFile_n, NFile : $File_n, Size : $Byte_n"
}


function Print_files_cont(){ #2번째 칸 파일 내용 출력
	k=2
	j=1
	if [ -f ${a_list[$I]} ]
	then
		if [ ${a_list[$I]} = *.gz ] || [ ${a_list[$I]} = *.zip ]
		then
			return
		fi
	while read -r rline
	do
	tput cup $k 42
	echo "$j $rline" | cut -c 1-35; # 예외처리 칸 넘어가면 자름
	line_num=`expr $line_num + 1` # 다음 줄 출력
	k=`expr $k + 1`			# 출력할 위치 1 증가
	j=`expr $j + 1`
	if [ $k -gt 29 ]		# 예외처리 칸 넘어가면 중지
	then
	break
	fi 
	done < ${a_list[$I]}
	fi
}

function Change_dir(){ #디렉토리 경로 변경
	if [ -d ${a_list[$I]} ] #디렉토리이면
	then
	cd ${a_list[$I]}  #경로이동
	clear #잔상 없애기 위해 지움
	$I=0 # 커서위치 초기화
	a_list=() #배열 초기화
	d=0
	for element in `ls -a | grep '\.\.'; ls | grep *"TrashBin"; ls -1 | sort | grep -v '/$' | grep -v "TrashBin";`
	do
		a_list[$d]="$element"  #배열에 다시 저장
		d=`expr $d + 1`
	done
	tput cup 0 0
	PrintForm
	Print_Files
	Total_Info
	Move	
	fi
}


function Delete(){

	tar -cvzf ${a_list[$I]}.tar.gz ${a_list[$I]}
	tar -xvzf ${a_list[$I]}.tar.gz -C $save_pwd

	rm -r ${a_list[$I]}  #delete Original file
	rm -r ${a_list[$I]}.tar.gz #delete gz file
	clear
	a_list=() #배열 초기화
	d=0
	for element in `ls -a | grep '\.\.'; ls | grep *"TrashBin"; ls -1 | sort | grep -v '/$' | grep -v "TrashBin";`
	do
		a_list[$d]="$element"  #배열에 다시 저장
		d=`expr $d + 1`
	done

	Renew
	Move
}





function Delete_form_TrashBin(){
	rm -r ${a_list[$I]}
	clear
	a_list=() #배열 초기화
	d=0
	for element in `ls -a | grep '\.\.'; ls | grep *"TrashBin"; ls -1 | sort | grep -v '/$' | grep -v "TrashBin";`
	do
		a_list[$d]="$element"  #배열에 다시 저장
		d=`expr $d + 1`
	done
	
	Renew
}


function PrintTree(){
	declare -a tree_list
	K2=`expr $K2 + 1`
	s=3
	a=0
	b=1
	tree_list=()
	for element in `find ${a_list[$I]} -maxdepth $K2 -type d | sort; find ${a_list[$I]} -maxdepth $K2 -type f | sort` 
	do
		tree_list[$a]="$element"
		a=`expr $a + 1`
	done

	tput cup 2 80
	echo -e "${tree_list[0]}"

	for count in *
	do
		tput cup $s 80
		echo -e "${tree_list[$b]}" | sed -e "s/${tree_list[0]}\//--/g" 
		b=`expr $b + 1`
		s=`expr $s + 1`
	done	
}


function PrintTree2(){
	tput cup 2 80
	echo -e "${a_list[$I]}"
	cd ${a_list[$I]}
	d=0
	s=3
	b=0
	for element in `ls` #depth 1
	do
		tree_list_dep1[$d]="$element"
		d=`expr $d + 1`
	done

	for count in *
	do
	tput cup $s 80
	if [ -d ${tree_list_dep1[$b]} ]
	then
		echo -e "-- +${tree_list_dep1[$b]}"
	elif [ -f ${tree_list_dep1[$b]} ] #1
	then
		echo -e "-- ${tree_list_dep1[$b]}"
	else
		echo -e "-- ${tree_list_dep1[$b]}"
	fi
	b=`expr $b + 1`
	s=`expr $s + 1`

	done
	
	cd ../
}





function PrintTree_test(){
	tput cup 2 80
	echo -e "[34m${a_list[$I]}[0m"
	cd ${a_list[$I]}
	d=0
	s=3
	b=0
	d2=0
	d3=0
	d4=0
	d5=0
	c=0
	c2=0
	c3=0
	c4=0
	c5=0
	for element in `ls`
	do
		tree_list_dep1[$d]="$element"
		d=`expr $d + 1`
	done

	for count in `ls`
	do
	tput cup $s 80
	if [ -d ${tree_list_dep1[$b]} ] #depth 1
	then
		s=`expr $s + 1`
		echo -e "-- -[34m${tree_list_dep1[$b]}[0m" | cut -c 1-42
		cd ${tree_list_dep1[$b]}
		for element in `ls`
		do
			tree_list_dep2[$d2]="$element"
			d2=`expr $d2 + 1`
		done
	
		for count in `ls`
		do
		tput cup $s 80
		if [ -d ${tree_list_dep2[$c]} ] #depth2
		then
			s=`expr $s + 1`
			echo -e "---- -[34m${tree_list_dep2[$c]}[0m" | cut -c 1-40
	
			cd ${tree_list_dep2[$c]}
			for element in `ls`
			do
				tree_list_dep3[$d3]="$element"
				d3=`expr $d3 + 1`
			done	

			for count in `ls`
			do
			tput cup $s 80
			if [ -d ${tree_list_dep3[$c2]} ] #depth3
			then
				s=`expr $s + 1`
				echo -e "------ -[34m${tree_list_dep3[$c2]}[0m" | cut -c 1-38
		
				cd ${tree_list_dep3[$c2]}
				for element in `ls`
				do
					tree_list_dep4[$d4]="$element"
					d4=`expr $d4 + 1`
				done	

				for count in `ls`
				do
				tput cup $s 80
				if [ -d ${tree_list_dep4[$c3]} ] #depth4
				then
					s=`expr $s + 1`
					echo -e "-------- -[34m${tree_list_dep4[$c3]}[0m" | cut -c 1-36
					
					cd ${tree_list_dep4[$c3]}
					for element in `ls`
					do
						tree_list_dep5[$d5]="$element"
						d5=`expr $d5 + 1`
					done
	

					for count in `ls`
					do
					tput cup $s 80
					if [ -d ${tree_list_dep5[$c4]} ] #depth5
					then
						s=`expr $s + 1`
						echo -e "---------- -[34m${tree_list_dep5[$c4]}[0m" | cut -c 1-34
						
					elif [ -f ${tree_list_dep5[$c4]} ]
					then
						if [ -x ${tree_list_dep5[$c4]} ]
						then
							echo -e "----------  [32m${tree_list_dep5[$c4]}[0m" | cut -c 1-34
						elif [ ${tree_list_dep5[$c4]} = *.gz ] || [ ${tree_list_dep5[$c4]} = *.zip ]
						then
							echo -e "----------  [31m${tree_list_dep5[$c4]}[0m" | cut -c 1-34
						else
							echo -e "----------  ${tree_list_dep5[$c4]}" | cut -c 1-30 | cut -c 1-34
						fi
					else

						echo -e "[0m----------  ${tree_list_dep5[$c4]}" | cut -c 1-34
					fi

					printf "[0m"
					c4=`expr $c4 + 1`
					s=`expr $s + 1`
					done

					s=`expr $s - 1`
					cd ../
		
					
				elif [ -f ${tree_list_dep4[$c3]} ]
				then
		#			s=`expr $s - 1`
					if [ -x ${tree_list_dep4[$c3]} ]
					then
						echo -e "--------  [32m${tree_list_dep4[$c3]}[0m" | cut -c 1-36
					elif [ ${tree_list_dep4[$c3]} = *.gz ] || [ ${tree_list_dep4[$c3]} = *.zip ]
					then
						echo -e "--------  [31m${tree_list_dep4[$c3]}[[0m" | cut -c 1-36
					else
						echo -e "--------  ${tree_list_dep4[$c3]}" | cut -c 1-36
					fi
				else
					echo -e "--------  ${tree_list_dep4[$c3]}" | cut -c 1-36
				fi
				printf "[0m"

				c3=`expr $c3 + 1`
				s=`expr $s + 1`
				done

				s=`expr $s - 1`
				cd ../
		

			elif [ -f ${tree_list_dep3[$c2]} ]
			then
		#		s=`expr $s - 1`
				if [ -x ${tree_list_dep3[$c2]} ]
				then
					echo -e "------  [32m${tree_list_dep3[$c2]}[0m" | cut -c 1-38
				elif [ ${tree_list_dep3[$c2]} = *.gz ] || [ ${tree_list_dep3[$c2]} = *.zip ]
				then
					echo -e "------  [31m${tree_list_dep3[$c2]}[[0m" | cut -c 1-38
				else
					echo -e "------  ${tree_list_dep3[$c2]}" | cut -c 1-38
				fi
			else
				echo -e "------  ${tree_list_dep3[$c2]}" | cut -c 1-38
			fi

			printf "[0m"
			c2=`expr $c2 + 1`
			s=`expr $s + 1`
			done

			s=`expr $s - 1`

			cd ../
		
		elif [ -f ${tree_list_dep2[$c]} ]
		then
			if [ -x ${tree_list_dep2[$c]} ]
			then
				echo -e "----  [32m${tree_list_dep2[$c]}[0m" | cut -c 1-40
			elif [ ${tree_list_dep2[$c]} = *.gz ] || [ ${tree_list_dep2[$c]} = *.zip ]
			then
				echo -e "----  [31m${tree_list_dep2[$c]}[0m" | cut -c 1-40
			else
				echo -e "----  ${tree_list_dep2[$c]}" | cut -c 1-40
			fi
		else
			echo -e "----  ${tree_list_dep2[$c]}" | cut -c 1-40
		fi
			printf "[0m"
		c=`expr $c + 1`
		s=`expr $s + 1`
		done

		s=`expr $s - 1`
		cd ../
		

	elif [ -f ${tree_list_dep1[$b]} ]
	then
		if [ -x ${tree_list_dep1[$b]} ]
		then
			echo -e "-- [32m${tree_list_dep1[$b]}[0m" | cut -c 1-42
		elif [ ${tree_list_dep1[$b]} = *.gz ] || [ ${tree_list_dep1[$b]} = *.zip ]
		then
			echo -e "--  [31m${tree_list_dep1[$b]}[0m" | cut -c 1-42
		else
			echo -e "-- ${tree_list_dep1[$b]}" | cut -c 1-42
		fi
	else
		echo -e "-- ${tree_list_dep1[$b]}" | cut -c 1-42
	fi
	printf "[0m"
	b=`expr $b + 1`
	s=`expr $s + 1`
	done
	cd ../
}













function Move(){   # 커서 이동 함수
	declare -i I=0
	Statement
	tput cup 2 2
	x=2
	y=2
	size_of_list=`expr ${#a_list[@]} + 1` # 예외처리 배열크기만큼까지만 커서 내려가도록 함
	while [ 1 ]
	do
	read -sn 1 key # 3개만 입력받음
	case "$key"
	in
	"A" )
		x=`expr $x - 1`;
		if [ $x -lt 2 ]
		then #범위 초과
			x=`expr $x + 1`; # 다시 원상복귀
			tput cup $x $y;
			Renew;
		else #재대로된 범위
			tput cup $x $y;
			I=`expr $I - 1`; #위로 이동
			Renew;
		fi;;
	"B" )
		x=`expr $x + 1`;
		if [ $x -gt $size_of_list ]
			then  #범위초과
			x=`expr $x - 1`; # 다시 원상복귀
			tput cup $x $y;
			Renew;
		else
		tput cup $x $y; #아래로 이동
		I=`expr $I + 1`;
		Renew;
		fi;;
	"" ) #엔터를 입력받으면
		Change_dir; # 경로 변경
		Print_files_cont;; #파일경로 출력하기
	"d" )
		if [ `pwd` = $save_pwd  ] #in the TrashBin 수정 요망
		then
			Delete_form_TrashBin;
		else
			Delete;
		fi;;
	"t" )
		if [ -d ${a_list[$I]} ]
		then
			PrintTree_test;
			y=`expr $y + 80`;#우로 이동
			tput cup $x $y;
			Move_tree;
		fi;;
	*) continue
	esac
	tput cup $x $y
	done
}


function Move2(){   # 커서 이동 함수
	Statement
	tput cup $x $y
	size_of_list=`expr ${#a_list[@]} + 1` # 예외처리 배열크기만큼까지만 커서 내려가도록 함
	while [ 1 ]
	do
	read -sn 1 key # 3개만 입력받음
	case "$key"
	in
	"A" )
		x=`expr $x - 1`;
		if [ $x -lt 2 ]
		then #범위 초과
			x=`expr $x + 1`; # 다시 원상복귀
			tput cup $x $y;
			Renew;
		else #재대로된 범위
			tput cup $x $y;
			I=`expr $I - 1`; #위로 이동
			Renew;
		fi;;
	"B" )
		x=`expr $x + 1`;
		if [ $x -gt $size_of_list ]
			then  #범위초과
			x=`expr $x - 1`; # 다시 원상복귀
			tput cup $x $y;
			Renew;
		else
		tput cup $x $y; #아래로 이동
		I=`expr $I + 1`;
		Renew;
		fi;;
	"" ) #엔터를 입력받으면
		Change_dir; # 경로 변경
		Print_files_cont;; #파일경로 출력하기
	"d" )
		if [ `pwd` = $save_pwd  ] #in the TrashBin
		then
			Delete_form_TrashBin;
		else
			Delete;
		fi;;
	"t" )
		if [ -d ${a_list[$I]} ]
		then
			PrintTree_test;
			y=`expr $y + 80`;#우로 이동
			tput cup $x $y;
			Move_tree;
		fi;;
	*) continue
	esac
	tput cup $x $y
	done
}


function Move_tree(){
	declare -i I2=0
	tput cup 3 80
	x2=3
	size_of_list2=`expr ${#tree_list_dep1[@]} + 1`
	while [ 1 ]
	do
	read -sn 1 key
	case "$key"
	in
	"A" )
		x2=`expr $x2 - 1`;
		if [ $x2 -lt 2 ]
		then
			x2=`expr $x2 + 1`;
			tput cup $x2 $y;
		else
			tput cup $x2 $y;
			I2=`expr $I2 - 1`;
		fi;;
	"B" )
		x2=`expr $x2 + 1`;
		if [ $x2 -gt 29 ]
		then
			x2=`expr $x2 - 1`;
			tput cup $x2 $y;
		else
			tput cup $x2 $y;
			I2=`expr $I2 + 1`;
		fi;;
	"" )
		x2=3;
		$I2=0;
		Renew;
		PrintTree_test;;
	"r" )
		y=`expr $y - 80`;
		tput cup $I $y;
		Renew;
		Move2;;
	*) continue
	esac
	done
}



function Renew(){ #잔상을 없애기 위해 다시 출력
clear
PrintForm
Print_Files
Statement
Total_Info
}




clear
PrintForm 
Print_Files
Statement
Total_Info
Move
