#!/bin/bash
# very simple example shell script for managing a CD collection
# Copyright 

# This program is free software

# 设置全局变量
menu_choice=""
current_cd=""
title_file="title.cdb"
tracks_file="tracks.cdb"
temp_file=/tmp/cdb.$$

#设置Ctrl+C组合键的中断处理，以确保在用户中断脚本程序时，删除临时文件
trap 'rm -f $temp_file' EXIT

get_return(){
	echo -e "Press return \c"
	read x
	return 0
}

get_confirm(){
	echo -e "Are you sure? \c"
	while true
	do
		read x
		case "$x" in 
			y | yes | Yes | YES)
				return 0;;
			n | no | N | No | NO) 
				echo
				echo "Cancelled"
				return 1;;
			*) echo "Please enter yes or no";;
		esac
	done
}

set_menu_choice(){
	clear
	echo "Options :-"
	echo
	echo "	a) Add new CD"
	echo "	f) Find CD"
	echo "	c) Count the CDs and tracks in the catalog"
	if [ "$cdcatnum" != "" ]; then
		echo "	l) List tracks on $cdtitle"
		echo "	r) Remove $cdtitle"
		echo "	u) Update track information for $cdtitle"
	fi
	echo "	q) Quit"
	echo
	echo -e "Please enter a choice then press return \c"
	read menu_choice
	return
}

insert_title(){
	echo $* >> $title_file
	return
}

insert_track(){
	echo $* >> $tracks_file
	return
}

add_record_tracks(){
	echo "Enter track information for this CD"
	echo "When no more tracks enter q"
	cdtrack=1
	cdttitle=""
	while [ "$cdttitle" != "q" ]
	do
		echo -e "Track $cdtrack, track title? \c"
		read tmp
		#删掉第一个“,”及其右边的所有字符
		cdttitle=${tmp%%,*}
		if [ "$tmp" != "$cdttile" ] ; then
			echo "Sorry, no commas allowd"
			continue
		fi
		if [ -n "$cdttitle" ] ; then
			if [ "$cdttitle" != "q" ] ; then
				insert_track $cdcatnum,$cdtrack, $cdttitle
			fi
		else
			cdtrack=$((cdtrack-1))
		fi
	    cdtrack=$((cdtrack+1))
	done
}

#输入新CD唱片的标题信息
add_records(){
	# Prompt for the initial information
	echo -e "Enter catalog name \c"
	read tmp
	cdcatnum=${tmp%%,*}

	echo -e "Enter title \c"
	read tmp
	cdtitle=${tmp%%,*}

	echo -e "Enter type \c"
	read tmp
	cdtype=${tmp%%,*}

	echo -e "Enter artist/composer \c"
	read tmp
	cdac=${tmp%%,*}
	# Check that they want to enter the information
	echo About to add new entry
	echo "$cdcatnum $cdtitle $cdtype $cdac"

	#if confirmed then append it to the titles file

	if get_confirm ; then
		insert_title $cdcatnum,$cdtitle,$cdtype,$cdac
		add_record_tracks
	else
		remove records;
	fi
	return
}	


# find_cd 函数的作用是使用grep命令在CD唱片标题文件中查找CD唱片的有关资料
find_cd(){
	if [ "$1" = "n" ] ; then 
		asklist=n
	else
		asklist=y
	fi
	cdcatnum=""
	echo -e "Enter a string to search for in the CD titles \c"
	read searchstr
	if [ "$searchstr" = "" ]; then
		return 0
	fi

	grep "$searchstr" $title_file > $temp_file
	# 把参数的值赋给位置参数
	set $(wc -l $temp_file)
	linesfound=$1
	
	case "$linefound" in
	0)	echo "Sorry, nothing found"
		get_return
		return 0
		;;
	1)	;;
	2)	echo "Sorry, not unique."
		echo "Found the following"
		cat $temp_file
		get_return
		return 0
	esac
	IFS=","
	read cdcatnum cdtitle cdtype cdac < $temp_file
	IFS=" "
	if [ -z "$cdcatnum" ]; then
		echo "Sorry, could not extract catalog field from $temp_file"
		get_return
		return 0
	fi
	
	echo
	echo Catalog number: $cdcatnum
	echo Title: $cdtitle
	echo Type: $cdtype
	echo Artist/Composer: $cdac
	echo
	get_return

	if [ "$asklist" = "y" ]; then
		echo -e "View tracks for this CD? \c"
		read x
		if [ "$x" = "y" ]; then
			echo 
			list_tracks
			echo
		fi
	fi
	return 1
}

# update_cd 函数用于重新输入CD唱片的资料
update_cd(){
	if [ -z "$cdcatnum" ]; then
		echo "You must select a CD first"
		find_cd n
	fi
	if [ -n "$cdcatnum" ]; then
		echo "Current tracks are :-"
		list_tracks
		echo
		echo "This will re-enter the tracks for $cdtitle"
		get_confirm && {
			grep -v "^${cdcatnum}," $tracks_file > $temp_file
			mv $temp_file $tracks_file
			echo
			add_record_tracks
		}
	fi
	return
}

# count_cds 快速统计数据库中CD唱片个数和曲目总数
count_cds(){
	set $(wc -l $title_file)
	num_titles=$1
	set $(wc -l $tracks_file)
	num_tracks=$1
	echo found $num_titles CDs, with a total of $num_tracks tracks
	get_return
	return
}

#10 remove_records grep -v命令删除所有匹配的字符串
remove_records(){
	if [ -z "$cdcatnum" ]; then
		echo You must select a CD first
		find_cd n
	fi
	if [ -n "$cdcatnum" ]; then
		echo "You are about to delete $cdtitle"
		get_confirm && {
			grep -v "^${cdcatnum}," $title_file > $temp_file
			mv $temp_file $title_file
			grep -v "^${cdcatnum}," $tracks_file > $temp_file
			mv $temp_file $tracks_file
			cdcatnum=""
			echo Entry removed
		}
	fi
	return
}

# list_tracks
list_tracks(){
	if [ "$cdcatnum" = "" ]; then
		echo no CD selected yet
		return
	else
		grep "^${cdcatnum}," $tracks_file > $temp_file
		num_tracks=$(wc -l $temp_file)
		if [ "$num_tracks" = "0" ]; then
			echo no tracks found for $cdtitle
		else {
			echo 
			echo "$cdtitle :-"
			echo 
			cut -f 2- -d , $temp_file
			echo
		} |${PAGER:-more}
		fi
	fi
	get_return
	return
}

#main
rm -f $temp_file
if [ ! -f $title_file ]; then
	touch $title_file
fi
if [ ! -f $tracks_file ]; then
	touch $tracks_file
fi

#now the applicaiton proper
clear
echo
echo
echo "Mini CD manager"
sleep 1
quit=n
while [ "$quit" != "y" ];
do
	set_menu_choice
	case "$menu_choice" in
		a)	add_records;;
		r)	remove_records;;
		f)	find_cd y;;
		u)	update_cd;;
		c)	count_cds;;
		l)	list_tracks;;
		b)
			echo
			more $title_file
			echo
			get_return;;
		q | Q)	quit=y;;
		*) echo "Sorry, choice not recognized";;
	esac
done
# Tidy up and leave
rm -f $temp_file
echo "Finished"
exit 0

