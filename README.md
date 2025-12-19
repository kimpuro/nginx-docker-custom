# nginx-docker-custom

기존 사이트(또는 도메인)로 들어오는 요청을 **새 사이트로 301(Moved Permanently) 리다이렉트**하는 nginx 컨테이너입니다.

## 설정

Cloud Run 포함 모든 환경에서 목적지 URL은 **환경변수**로 주입하는 걸 권장합니다.

- `REDIRECT_TO`: 새 사이트 베이스 URL (예: `https://new.example.com`)

로컬에서 파일로 바꾸고 싶다면 템플릿인 `conf.d/redirect.conf.template`를 수정할 수 있습니다:

- `return 301 ${REDIRECT_TO}$request_uri;`
  - `${REDIRECT_TO}`는 환경변수로 치환됩니다
  - `$request_uri`는 경로/쿼리를 그대로 유지합니다 (예: `/a?b=1`)

## 실행 (docker compose)

```bash
docker compose up -d --build
```

테스트:

```bash
curl -I 'http://localhost:8080/some/path?x=1'
```

## 실행 (docker run)

```bash
docker build -t nginx-redirect:local .
docker run --rm -e PORT=8080 -e REDIRECT_TO=https://example.com -p 8080:8080 nginx-redirect:local
```

## GCP Cloud Run

별도 복잡한 설정은 없고, **`REDIRECT_TO`만 환경변수로 지정**하면 됩니다. Cloud Run은 기본적으로 컨테이너에 `PORT`(보통 8080)를 주입하므로, 이 프로젝트는 그 값을 자동으로 따라갑니다.
