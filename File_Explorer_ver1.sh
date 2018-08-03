#!/bin/bash


declare -a file_list=() #출력할 리스트를 저장할 배열 선언
declare -a a_list=() # 배열로 저장한 배열을 저장하기 위한 배열 선언


file_list=`ls -a | grep '\.\.'; ls -d */ | rev | cut -c 2- | rev; ls -1F | sort | grep -v '/$';`
a_list=($file_list)



declare -i I=0 # 커서를 저장할 정수형 변수 선언







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
			check_file_type3=`stat -c "%n" ${a_list[$I]} | grep '.sh' | wc -l`
			if [ -d ${a_list[$I]} ]                                               #디렉토리이면
			then
				echo -e "\e[7m" "[34m ${a_list[$i]} [0m" "\e[27m" | cut -c 1-35 # 예외처리 길면 짜름
			elif [ $check_file_type -eq 1 ]                                       #압축파일이면
			then
				echo -e "\e[7m" "[31m ${a_list[$i]} [0m" "\e[27m" | cut -c 1-35
			elif [ $check_file_type2 -eq 1 ]                                      #압축파일이면2
			then
				echo -e "\e[7m" "[31m ${a_list[$i]} [0m" "\e[27m" | cut -c 1-35
			elif [ $check_file_type3 -eq 1 ]                                       #실행파일이면
			then
				echo -e "\e[7m" "[32m ${a_list[$i]} [0m" "\e[27m" | cut -c 1-35
			else
				echo -e "\e[7m ${a_list[$i]} \e[27m" | cut -c 1-35                  #일반파일이면
			fi
			printf "[0m"
		else # 커서 위치가 아닌곳 색깔 변화
			if [ -d ${a_list[$i]} ]                                         #디렉토리이면
			then
				echo -e "[34m ${a_list[$i]} [0m" | cut -c 1-35
			elif [ -f ${a_list[$i]} ]                                #파일구분
			then

			case "${a_list[$i]}"
			in
			*.gz | *.zip ) echo -e "[31m ${a_list[$i]} [0m" | cut -c 1-35;;  # 압축파일이다
			*.sh ) echo -e "[32m ${a_list[$i]} [0m" | cut -c 1-35;;          # 실행파일이다
			* ) echo -e ${a_list[$i]}  | cut -c 1-35;;                           # 아니다
			esac

			else
				echo -e "${a_list[$i]}" | cut -c 1-35 # 디렉토리도 파일도 아니면 그냥 일반색으로 출력
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
	echo  "`stat -c 'file name : %n' ${a_list[$I]}`"      #파일 이름

	tput cup 32 2
	if [ -d ${a_list[$I]} ]
	then
	echo -e "[34mfile type : directory [0m"      #파일 타입이 디렉토리
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
	

	tput cup 33 2
	echo "`stat -c 'file size : %s' ${a_list[$I]}`"      #파일크기
	tput cup 34 2
	echo "`stat -c 'creation time : %x' ${a_list[$I]}`"  #마지막 엑세스 시간
	tput cup 35 2
	echo "`stat -c 'permission : %a' ${a_list[$I]}`"     #8진수 형태의 접근권한
	tput cup 36 2
	echo -n "absolute path :  `pwd`                                                                    " 
	#예외처리 잔상 남는것 방지
	tput cup 37 40
	echo "/${a_list[$I]}" | cut -c 1-55        #파일의 절대경로
	tput cup 38 2
}

function Total_Info(){ #현제 경로의의 총 정보 출력
	Total_n=`ls | wc -l` #파일 전체 개수
	Dir_n=`ls -lF | grep '/' | wc -l`			# 디렉토리 개수
	S1file_n=`ls -lF | grep 'sh' | wc -l`			# sh파일 개수
	S2file_n=`ls -lF | grep 'zip' | wc -l`
	S3file_n=`ls -lF | grep 'gz' | wc -l`
	SFile_n=`expr $S1file_n + $S2file_n + $S3file_n`
	File_n=`expr $Total_n - $Dir_n - $SFile_n`		# 일반 파일 개수
	Byte_n=`du . | tail -n 1 | head -c 2`			# 현재 디렉토리의 전체
	tput cup 38 2
	echo "$Total_n total  $Dir_n dir  $File_n file    $SFile_n Sfile  $Byte_n byte"
}


function Print_files_cont(){ #2번째 칸 파일 내용 출력
	k=2
	if [ -f ${a_list[$I]} ]
	then
	while read -r rline
	do
	tput cup $k 42
	echo "$rline" | cut -c 1-35; # 예외처리 칸 넘어가면 자름
	line_num=`expr $line_num + 1` # 다음 줄 출력
	k=`expr $k + 1`			# 출력할 위치 1 증가
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
	for element in `ls -a | grep '\.\.'; ls -d */ | rev | cut -c 2- | rev; ls -1F | sort | grep -v '/$';`
	do
		a_list[$d]="$element"  #배열에 다시 저장
		d=`expr $d + 1`
	done
	tput cup 0 0
	PrintForm	# 다시 전부 출력
	Print_Files
	Statement
	Total_Info
	Move
	fi
}



function Move(){   # 커서 이동 함수
	declare -i I=0 #커서 위치 초기화
	Statement
	tput cup 2 2
	x=2
	y=2
	size_of_list=`expr ${#a_list[@]} + 1` # 예외처리 배열크기만큼까지만 커서 내려가도록 함
	while [ 1 ]
	do
	read -sn 3 key # 3개만 입력받음
	case "$key"
	in
	"[A" )
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
	"[B" )
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
	"[C" )
		y=`expr $y + 80`; #일단은 3번째 칸까지만 이동
		tput cup $x $y; #우로 이동
		Renew;;
	"[D" )
		y=`expr $y - 80`; #역시 3번째 칸까지만 이동
		tput cup $x $y; #좌로 이동
		Renew;;
	"" ) #엔터를 입력받으면
		Change_dir; # 경로 변경
		Print_files_cont;; #파일경로 출력하기
	*) continue
	esac
	tput cup $x $y
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
