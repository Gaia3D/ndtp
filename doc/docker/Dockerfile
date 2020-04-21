# 베이스 이미지 설정
FROM centos:7

RUN touch /etc/yum.repos.d/nginx.repo && echo -e '[nginx]\nname=nage repo\nbaseurl=http://nginx.org/packages/centos/7/$basearch/\ngpgcheck=0\nenabled=1' > /etc/yum.repos.d/nginx.repo
RUN yum -y install nginx

# 작업 디렉토리. 없으면 새로 생성
WORKDIR /gaia3d

# 환경 변수

# 포트 지정
EXPOSE 80

# 웹 컨텐츠 배치(호스트에서 컨테이너로 복사)cls

# ADD 명령은 원격 파일의 다운로드나 아카이브 압축 해제 등과 같은 기능을 갖고 있지만, COPY 명령은 호스트 상의 파일을 이미지 안으로 복사하는 처리만 함
ONBUILD ADD mago3djs.zip /gaia3d

# 서버 실행
CMD ["nginx", "-g", "daemon off;"]