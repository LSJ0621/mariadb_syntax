# 덤프파일 생성 : dumpfile.sql 이라는 이름의 덤프파일 생성
mysqldump -u root -p board > dumpfile.sql
# 한글깨질때
mysqldump -u root -p board -r dumpfile.sql
# 덤프파일 적용(복원)
# < 가 특수문자로 인식되어, window에서는 적용이 안될경우, git bash 터미널창을 활용
mysql -u root -p board < dumpfile.sql

# dump파일을 github에 업로드

# 리눅스ㅔ서 mariadb 설치
sudo apt -get install mariadb-server

# mariadb 서버 실행
sudo systemctl start mariadb

# mariadb 접속 : 1234
mairadb -u root -p 
create database board;

# git 설치
sudo apt install git

# git에서 repository clone
git clone https://github.com/LSJ0621?tab=repositories

# mariadb 덤프파일 복원