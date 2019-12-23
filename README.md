# NDTP
NDTP(National Digital Twin Platform Pilot Service)는  지속 가능한 확장형 시범도시(세종, 부산) 디지털트윈 플렛폼 개발 및 파일럿 서비스 개발
## 사업 개요
### 1. 사업 일반
 - 사업명 : 2019년 스마트시트 시범도시(세종, 부산) 디지털트윈 마스터플랜 수립 및 시범시스템 구축 용역
 - 사업기간 : ~ 2020.02.14
 
### 2. 사업 범위
 - 파일럿 서비스 개발 : 지속가능한 확장형 시범도시(세종, 부산) 디지털트윈 플랫폼 및 파일럿 서비스 개발

### 3. 목표
#### 스마트시티의 활용 기반이 되는 도시 공간 데이터 수집 시스템 기능을 포함하는 디지털트윈 플랫폼을 설계하고, 이를 기반으로 대상 구역의 디지털 트윈을 개발
 - 파일럿 시스템 및 데이터 구축을 위한 개발 타당성 검증 및 사용자 참여 기반 마련
< 그림 >
## Features


## Development Environment
- Spring
- mybatis
- lombok
- PostgreSQL
- PostGIS
- Gradle

## Getting Started

### 1. Install
#### [java](https://jdk.java.net/archive/)
- OpenJDK 11.0.2 (build 11.0.2+9) : 11버전 설치

#### [eclipse](https://www.eclipse.org/downloads/download.php?file=/oomph/epp/2019-12/R/eclipse-inst-win64.exe)
- Eclipse IDE 2019-12 (2019-12(4.14.0) 버전 이상 설치)<br>
- Eclipse 설정 - STS(Spring Tools) 설정 <br>
  Help → Eclipse Marketplace → 'STS' 검색후, Spring Tools 4 설치
- Eclipse를 실행 후 Project Import <br>
  File → import → Gradle → Existing Gradle Project

#### [PostgreSQL](https://www.enterprisedb.com/downloads/postgres-postgresql-downloads)
- PostgreSQL11.6 버전으로 설정
- 설치경로 C:/PostgreSQL/11 <br>
  doc/database/doc/database/ 참조
  
#### [PostGIS](https://postgis.net/)
- PostGIS 최신 SQL 버전으로 설정
- 설치경로 C:/PostGIS

#### [GDAL](https://trac.osgeo.org/osgeo4w/)
- GDAL을 설치하기 위해서 OSGeo4W(FOSSGIS for Windows)를 설치
- 시스템 변수 추가 <br>
  Path) C:\OSGeo4W64\bin 

#### [gradle](https://gradle.org/docs/)
- 설치경로 C:/gradle
- 시스템 변수 추가 <br> 
  Path) C:\gradle\gradle-5.6.3 
- eclipse BuildShip Gradle Plugin을 이용하여 gradle을 사용할 수 있습니다.

#### [lombok](https://projectlombok.org/)
- 설치한 뒤에 다운로드 폴더 이동 후 실행
- eclipse 설치 위치 [Specify location..]를 검색해서 'eclipse.exe' 파일을 선택합니다.
- install/update 클릭합니다.

  
### 2. DB 생성 및 초기 데이터 등록
- Database & Extensions
	- ndtp 데이터베이스를 생성합니다.
	    한글 정렬을 위해 데이터베이스를 다음과 같이 설정합니다.
	  <pre><code>Name:ndtp, Encoding:UTF-8, Template:template0, Collation:C, Character type:C, Connection Limit:-1</code></pre>
	- psql(SQL Shell) 혹은 pgAdmin에서 Extensions를 실행합니다.
	  <pre><code>CREATE EXTENSION postgis</code></pre>
	  PosGIS Extensions이 성공적으로 끝나면 데이터베이스 생성 및 초기 데이더 등록 후 spatial_ref_sys라는 테이블이 자동 생성됩니다.

- 데이터 등록
	- download 한 소스의 /doc/database/ 폴더로 이동합니다.
	- PostgreSQL에서 database 폴더에 있는 쿼리를 실행해 줍니다. (windows 자동 실행 script는 개발 중입니다.) <br>
	   - ddl 폴더의 sql 파일을 실행하여 table을 생성합니다. <br>
	   - ddl 폴더의 sequence sql 실행하여 sequence 생성합니다.<br>
	   - index, trigger 폴더의 sql을 실행하여 index 및 partition 생성합니다.<br>
	   - dml 폴더의 sql을 실행하여 초기 데이터 등록합니다.
	   
### 3. Execution
- ndtp-admin project spring boot 실행 <br>
  url : http://localhost(:port)/
<pre><code>/ndtp-admin/src/main/java/ndtp/NdtpAdminApplication.java</code></pre>

## License

<br><br>