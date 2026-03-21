# Inception

42Seoul Circle 4 과제. Docker Compose로 LEMP 스택을 각각의 컨테이너로 분리하여 구축.

## 과제 설명

가상 머신(VM) 환경에서 Docker Compose를 사용하여 Nginx, WordPress + PHP-FPM, MariaDB를 각각 별도의 컨테이너로 구성한다. ft_server와 달리 서비스별로 컨테이너를 분리하고, Docker 네트워크와 볼륨을 활용한다.

## 아키텍처

```
[Client] --443/HTTPS--> [Nginx] --9000/FastCGI--> [WordPress + PHP-FPM]
                                                          |
                                                    3306/TCP
                                                          |
                                                     [MariaDB]
```

## 컨테이너 구성

| 컨테이너 | 베이스 이미지 | 역할 |
|-----------|-------------|------|
| nginx | Alpine 3.15 | HTTPS 리버스 프록시 (TLSv1.2/1.3) |
| wordpress | Alpine 3.15 | WordPress + PHP-FPM 7, wp-cli로 자동 설정 |
| mariadb | Alpine 3.15 | 데이터베이스 서버 |

## 주요 구현 내용

- 모든 컨테이너는 **Alpine Linux** 기반으로 직접 Dockerfile 작성
- Nginx: 자체 서명 SSL 인증서(RSA 4096), TLSv1.2/1.3만 허용
- WordPress: `wp-cli`로 설치/설정 자동화 (DB 연결 대기 후 초기화)
- MariaDB: 셸 스크립트로 초기 데이터베이스, 사용자 생성, 원격 접속 허용
- Docker volume으로 데이터 영속화 (WordPress 파일, DB 데이터)
- Docker 네트워크(`bridge`)로 컨테이너 간 통신
- 환경변수는 `.env` 파일로 관리

## 프로젝트 구조

```
inception/
├── Makefile
├── cleanup.sh                            # 전체 초기화 스크립트
└── srcs/
    ├── docker-compose.yml
    ├── .env                              # 환경변수
    └── requirements/
        ├── nginx/
        │   ├── Dockerfile
        │   └── conf/inception.conf       # Nginx 설정
        ├── wordpress/
        │   ├── Dockerfile
        │   ├── conf/www.conf             # PHP-FPM 설정
        │   └── tools/run.sh              # WP 초기화 스크립트
        └── mariadb/
            ├── Dockerfile
            └── tools/run.sh              # DB 초기화 스크립트
```

## 사용 기술

- Docker, Docker Compose
- Nginx (리버스 프록시, SSL)
- WordPress + PHP-FPM
- MariaDB
- Alpine Linux
- OpenSSL
- wp-cli

## 학습 내용

- Docker Compose를 이용한 멀티 컨테이너 구성
- 컨테이너 간 네트워크 통신과 서비스 분리
- Docker volume을 이용한 데이터 영속화
- 서비스 의존성 관리 (depends_on, 연결 대기 로직)
- 환경변수 기반 설정 관리

## 실행

```bash
make        # 볼륨 디렉토리 생성 후 docker-compose up --build
make clean  # 컨테이너 및 이미지 삭제
make fclean # 전체 초기화 (볼륨 포함)
make re     # 재구축
```
