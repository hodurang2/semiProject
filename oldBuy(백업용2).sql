-- 시퀀스 삭제
DROP SEQUENCE USER_SEQ;
DROP SEQUENCE ACCESS_SEQ;
DROP SEQUENCE CATEGORY_SEQ;
DROP SEQUENCE PRODUCT_SEQ;
DROP SEQUENCE PRODUCT_IMAGE_SEQ;
DROP SEQUENCE PRODUCT_COMMENT_SEQ;
DROP SEQUENCE WATCH_HISTORY_SEQ;
DROP SEQUENCE WISHLIST_SEQ;
DROP SEQUENCE ALARM_SEQ;
DROP SEQUENCE INACTIVE_USER_SEQ;
DROP SEQUENCE LEAVE_USER_SEQ;
DROP SEQUENCE INQUIRY_SEQ;
DROP SEQUENCE ANSWER_SEQ;
DROP SEQUENCE INQUIRY_ATTACH_SEQ;
DROP SEQUENCE NOTICE_SEQ;
DROP SEQUENCE NOTICE_ATTACH_SEQ;
DROP SEQUENCE SEARCH_SEQ;


-- 시퀀스 생성
CREATE SEQUENCE USER_SEQ NOCACHE;
CREATE SEQUENCE ACCESS_SEQ NOCACHE;
CREATE SEQUENCE CATEGORY_SEQ NOCACHE;
CREATE SEQUENCE PRODUCT_SEQ NOCACHE;
CREATE SEQUENCE PRODUCT_IMAGE_SEQ NOCACHE;
CREATE SEQUENCE PRODUCT_COMMENT_SEQ NOCACHE;
CREATE SEQUENCE WATCH_HISTORY_SEQ NOCACHE;
CREATE SEQUENCE WISHLIST_SEQ NOCACHE;
CREATE SEQUENCE ALARM_SEQ NOCACHE;
CREATE SEQUENCE INACTIVE_USER_SEQ NOCACHE;
CREATE SEQUENCE LEAVE_USER_SEQ NOCACHE;
CREATE SEQUENCE INQUIRY_SEQ NOCACHE;
CREATE SEQUENCE ANSWER_SEQ NOCACHE;
CREATE SEQUENCE INQUIRY_ATTACH_SEQ NOCACHE;
CREATE SEQUENCE NOTICE_SEQ NOCACHE;
CREATE SEQUENCE NOTICE_ATTACH_SEQ NOCACHE;
CREATE SEQUENCE SEARCH_SEQ NOCACHE;



-- 테이블 삭제
DROP TABLE SEARCH;
DROP TABLE NOTICE_ATTACH;
DROP TABLE NOTICE;
DROP TABLE INQUIRY_ATTACH;
DROP TABLE ANSWER;
DROP TABLE LEAVE_USER;
DROP TABLE INACTIVE_USER;
DROP TABLE ALARM;
DROP TABLE INQUIRY;
DROP TABLE WISHLIST;
DROP TABLE WATCH_HISTORY;
DROP TABLE PRODUCT_COMMENT;
DROP TABLE PRODUCT_IMAGE;
DROP TABLE PRODUCT;
DROP TABLE CATEGORY;
DROP TABLE ACCESS_T;
DROP TABLE USER_T;

-- 사용자 테이블
CREATE TABLE USER_T (
    USER_NO         NUMBER                  NOT NULL        ,
    EMAIL           VARCHAR2(100 BYTE)      NOT NULL UNIQUE ,
    NAME            VARCHAR2(50 BYTE)       NULL            ,
    PW              VARCHAR2(64 BYTE)       NULL            ,   -- 비밀번호 SHA-256 암호화 방식 사용
    GENDER          VARCHAR2(2 BYTE)        NULL            ,   -- 성별
    PHONE           VARCHAR2(15 BYTE)       NULL            ,   -- 휴대폰 번호 하이픈('-') 제거 후 저장
    AGREE           NUMBER                  NULL            ,   -- 서비스동의여부 0:필수, 1:이벤트
    STATE           NUMBER                  NULL            ,   -- 가입형태 0:정상 1:네이버
    JOINED_AT       TIMESTAMP               NULL            ,   -- 가입일
    SIDO            VARCHAR2(20 BYTE)       NOT NULL        ,   -- 시도
    SIGUNGU         VARCHAR2(20 BYTE)       NOT NULL        ,   -- 시군구
    INTEREST_CITY   VARCHAR2(40 BYTE)       NULL            ,   -- 관심지역
    CONSTRAINT PK_USER_T PRIMARY KEY(USER_NO) 
);

-- 접속기록
CREATE TABLE ACCESS_T (
    EMAIL    VARCHAR2(100 BYTE) NOT NULL                    ,  -- 접속한 사용자
    LOGIN_AT TIMESTAMP          NOT NULL                    ,  -- 로그인 일시
    CONSTRAINT FK_ACCESS_T FOREIGN KEY(EMAIL) REFERENCES USER_T (EMAIL) ON DELETE CASCADE
);

-- 카테고리 테이블
CREATE TABLE CATEGORY (
    CATEGORY_ID     NUMBER                  NOT NULL        ,
    NAME            VARCHAR2(500 BYTE)      NOT NULL        ,
    CONSTRAINT PK_CATEGORY PRIMARY KEY(CATEGORY_ID)
);

-- 상품 테이블
CREATE TABLE PRODUCT (
    PRODUCT_NO              NUMBER                  NOT NULL    ,
    SELLER_NO               NUMBER                  NULL        ,
    BUYER_NO                NUMBER                  NULL        ,
    CATEGORY_ID             NUMBER                  NOT NULL    ,
    PRODUCT_NAME            VARCHAR2(100 BYTE)      NOT NULL    ,
    PRODUCT_PRICE           NUMBER                  NOT NULL    ,
    PRODUCT_INFO            VARCHAR2(4000 BYTE)     NULL        ,
    PRODUCT_CREATED_AT      TIMESTAMP               NULL        ,
    PRODUCT_MODIFIED_AT     TIMESTAMP               NULL        ,
    PRODUCT_HIT             NUMBER   DEFAULT 0      NULL        ,
    PRODUCT_STATE           NUMBER                  NULL        ,        -- 판매상태 0:판매중 1:예약중 2:판매완료
    PRODUCT_TRADE_ADDRESS   VARCHAR2(100 BYTE)      NULL        ,        -- 거래지역
    REVIEW_CONTENTS         VARCHAR2(1000 BYTE)     NULL        ,        -- 후기내용
    REVIEW_SCORE            NUMBER                  NULL        ,        -- 별점
    CREATED_AT              TIMESTAMP               NULL        ,        -- 후기작성일
    TRADE_AT                TIMESTAMP               NULL        ,        -- 거래일
    CONSTRAINT PK_PRODUCT PRIMARY KEY(PRODUCT_NO),
    CONSTRAINT FK_SELLER_PRODUCT FOREIGN KEY(SELLER_NO) REFERENCES USER_T (USER_NO) ON DELETE SET NULL,
    CONSTRAINT FK_BUYER_PRODUCT FOREIGN KEY(BUYER_NO) REFERENCES USER_T (USER_NO) ON DELETE SET NULL,
    CONSTRAINT FK_CATEGORY_ID_PRODUCT FOREIGN KEY(CATEGORY_ID) REFERENCES CATEGORY(CATEGORY_ID) ON DELETE CASCADE
);

-- 상품 이미지 테이블
CREATE TABLE PRODUCT_IMAGE (
    IMAGE_NO             NUMBER                  NOT NULL        ,
    PRODUCT_NO           NUMBER                  NOT NULL        ,
    PATH                 VARCHAR2(100 BYTE)      NULL            ,     -- 이미지경로
    FILESYSTEM_NAME      VARCHAR2(300 BYTE)      NULL            ,     -- 파일시스템이름
    IMAGE_ORIGINAL_NAME  VARCHAR2(300 BYTE)      NOT NULL        ,     -- 이미지 원본 이름
    HAS_THUMBNAIL        NUMBER                  NULL            ,     -- 썸네일 있으면 1, 없으면 0
    CONSTRAINT PK_PRODUCT_IMAGE PRIMARY KEY(IMAGE_NO),
    CONSTRAINT FK_PRODUCT_NO FOREIGN KEY(PRODUCT_NO) REFERENCES PRODUCT(PRODUCT_NO) ON DELETE CASCADE
);

-- 상품 댓글 테이블
CREATE TABLE PRODUCT_COMMENT (
    COMMENT_NO          NUMBER              NOT NULL        ,  -- 댓글번호
    PRODUCT_NO          NUMBER              NOT NULL        ,  -- 상품번호
    USER_NO             NUMBER              NOT NULL        ,  -- 사용자번호
    CONTENTS            VARCHAR2(500 BYTE)  NOT NULL        ,  -- 댓글내용
    CREATED_AT          TIMESTAMP           NULL            ,  -- 작성일
    DEPTH               NUMBER              NOT NULL        ,  -- 댓글수준
    GROUP_NO            NUMBER              NOT NULL        ,  -- 댓글그룹 
    STATUS              NUMBER              NULL            ,  -- 댓글상태
    CONSTRAINT PK_COMMENT PRIMARY KEY(COMMENT_NO),
    CONSTRAINT FK_PRODUCT_NO_COMMENT FOREIGN KEY(PRODUCT_NO) REFERENCES PRODUCT (PRODUCT_NO) ON DELETE CASCADE,
    CONSTRAINT FK_USER_NO_COMMENT FOREIGN KEY(USER_NO) REFERENCES USER_T (USER_NO)  ON DELETE SET NULL
);

-- 상품 조회 내역
CREATE TABLE WATCH_HISTORY (
    USER_NO     NUMBER      NOT NULL    , -- 사용자번호
    PRODUCT_NO  NUMBER      NOT NULL    , -- 상품번호
    CREATED_AT  TIMESTAMP   NOT NULL    , -- 조회일
    CONSTRAINT FK_USER_WATCH FOREIGN KEY(USER_NO) REFERENCES USER_T (USER_NO) ON DELETE CASCADE,
    CONSTRAINT FK_PRODUCT_WATCH FOREIGN KEY(PRODUCT_NO) REFERENCES PRODUCT (PRODUCT_NO) ON DELETE CASCADE
);

-- 관심 상품 테이블
CREATE TABLE WISHLIST (
    PRODUCT_NO       NUMBER          NOT NULL               ,  -- 상품번호
    USER_NO          NUMBER          NOT NULL               ,  -- 사용자번호
    CREATED_AT       TIMESTAMP       NOT NULL               ,  -- 등록일
    CONSTRAINT FK_PRODUCT_WISH FOREIGN KEY(PRODUCT_NO) REFERENCES PRODUCT (PRODUCT_NO) ON DELETE CASCADE,
    CONSTRAINT FK_USER_WISH FOREIGN KEY(USER_NO) REFERENCES USER_T(USER_NO) ON DELETE CASCADE
);

-- 1:1 문의 테이블
CREATE TABLE INQUIRY (
    INQUIRY_NO          NUMBER              NOT NULL        ,  -- 문의번호
    USER_NO             NUMBER              NOT NULL        ,  -- 사용자번호
    INQUIRY_TITLE       VARCHAR2(100 BYTE)  NOT NULL        ,  -- 문의제목
    INQUIRY_CONTENT     VARCHAR2(4000 BYTE) NOT NULL        ,  -- 문의내용
    INQUIRY_CREATED_AT  TIMESTAMP           NULL            ,  -- 작성일
    CONSTRAINT PK_INQUIRY PRIMARY KEY(INQUIRY_NO),
    CONSTRAINT FK_INQUIRY_USER FOREIGN KEY (USER_NO) REFERENCES USER_T(USER_NO) ON DELETE CASCADE  -- 사용자 탈퇴 시, 문의 삭제
);

-- 알림 테이블
CREATE TABLE ALARM (
    NOTICE_NO        NUMBER                 NOT NULL   ,  -- 알림번호
    PRODUCT_NO       NUMBER                 NULL       ,  -- 알림 온 상품번호
    INQUIRY_NO       NUMBER                 NULL       ,  -- 알림 온 문의번호
    NOTIFI_CONTENTS  VARCHAR2(100 BYTE)     NOT NULL   ,  -- 알림 내용
    NOTIFI_TYPE      VARCHAR2(20 BYTE)      NOT NULL   ,  -- 알림 유형
    CREATED_AT       TIMESTAMP              NULL       ,  -- 알림 생성된 일자
    NOTIFI_AT        TIMESTAMP              NULL       ,  -- 알림 확인 일자
    CONSTRAINT PK_NOTIFICATION PRIMARY KEY (NOTICE_NO),
    CONSTRAINT FK_PRODUCT_NOTIFICATION FOREIGN KEY(PRODUCT_NO) REFERENCES PRODUCT(PRODUCT_NO) ON DELETE SET NULL,  -- 상품 삭제 시, 상품 번호 NULL 처리
    CONSTRAINT FK_INQUIRY_NOTIFICATION FOREIGN KEY(INQUIRY_NO) REFERENCES INQUIRY(INQUIRY_NO) ON DELETE SET NULL  -- 문의 삭제 시, 문의 번호 NULL 처리
);

-- 휴면회원 테이블
CREATE TABLE INACTIVE_USER (
    USER_NO         NUMBER              NOT NULL            ,  -- 사용자번호
    EMAIL           VARCHAR2(100 BYTE)  NOT NULL            ,  -- 사용자이메일
    NAME            VARCHAR2(50 BYTE)   NULL                ,  -- 사용자이름
    PW              VARCHAR2(64 BYTE)   NULL                ,  -- 비밀번호
    GENDER          VARCHAR2(2 BYTE)    NULL                ,  -- 성별
    PHONE           VARCHAR2(15 BYTE)   NULL                ,  -- 휴대폰 번호
    AGREE           NUMBER              NOT NULL            ,  -- 서비스동의여부
    STATE           NUMBER              NULL                ,  -- 가입형태
    JOINED_AT       TIMESTAMP           NULL                ,  -- 가입일
    INACTIVED_AT    TIMESTAMP           NULL                ,  -- 휴면처리일
    SIDO            VARCHAR2(20 BYTE)   NOT NULL            ,  -- 시도
    SIGUNGU         VARCHAR2(20 BYTE)   NOT NULL            ,  -- 시군구
    CONSTRAINT PK_INACTIVE_USER PRIMARY KEY(USER_NO)
);

-- 탈퇴한 회원 테이블
CREATE TABLE LEAVE_USER (
    EMAIL           VARCHAR2(50 BYTE)   NULL                ,  -- 탈퇴한 사용자이메일
    JOINED_AT       TIMESTAMP           NULL                ,  -- 가입일
    LEAVED_AT       TIMESTAMP           NULL                   -- 탈퇴일
);

-- 1:1문의 댓글(답변) 테이블
CREATE TABLE ANSWER (
    ANSWER_NO       NUMBER          NOT NULL                ,  -- 답변번호
    INQUIRY_NO      NUMBER          NOT NULL                ,  -- 문의번호
    CONTENTS        VARCHAR2(500)   NULL                    ,  -- 댓글내용
    CREATED_AT      TIMESTAMP       NULL                    ,  -- 작성일
    DEPTH           NUMBER          NOT NULL                ,  -- 댓글수준
    STATUS          NUMBER          NULL                    ,  -- 댓글상태
    GROUP_NO        NUMBER          NULL                    ,  -- 댓글그룹
    CONSTRAINT PK_ANSWER PRIMARY KEY (ANSWER_NO),
    CONSTRAINT FK_INQUIRY_ANSWER FOREIGN KEY (INQUIRY_NO) REFERENCES INQUIRY(INQUIRY_NO) ON DELETE CASCADE  -- 문의 삭제 시, 문의 댓글 삭제
);

-- 1:1문의 파일첨부
CREATE TABLE INQUIRY_ATTACH (
    ATTACH_NO           NUMBER              NOT NULL    ,  -- 첨부한 파일의 번호
    INQUIRY_NO          NUMBER              NOT NULL    ,  -- 문의번호
    PATH                VARCHAR2(100 BYTE)  NOT NULL    ,  -- 파일의 위치경로
    ORIGINAL_FILENAME   VARCHAR2(300 BYTE)  NOT NULL    ,  -- 원본 파일의 이름
    FILESYSTEM_NAME     VARCHAR2(300 BYTE)  NOT NULL    ,  -- 변경된 파일 이름
    CONSTRAINT PK_INQUIRY_ATTACH PRIMARY KEY (ATTACH_NO),
    CONSTRAINT FK_INQUIRY_ATTACH FOREIGN KEY (INQUIRY_NO) REFERENCES INQUIRY(INQUIRY_NO) ON DELETE CASCADE  -- 1:1 문의 삭제 시, 첨부된 사진 삭제
);

-- 공지사항 테이블
CREATE TABLE NOTICE (
    NOTICE_NO           NUMBER              NOT NULL        ,  -- 공지번호
    TITLE               VARCHAR2(1000 BYTE) NOT NULL        ,  -- 제목
    CONTENTS            VARCHAR2(4000 BYTE) NOT NULL        ,  -- 내용
    CREATED_AT          TIMESTAMP           NULL            ,  -- 작성일
    CONSTRAINT PK_NOTICE PRIMARY KEY(NOTICE_NO)
);

-- 공지사항 파일첨부
CREATE TABLE NOTICE_ATTACH (
    ATTACH_NO           NUMBER              NOT NULL    ,  -- 첨부한 파일의 번호
    NOTICE_NO           NUMBER              NOT NULL    ,  -- 공지번호
    PATH                VARCHAR2(100 BYTE)  NOT NULL    ,  -- 파일의 위치경로
    ORIGINAL_FILENAME   VARCHAR2(300 BYTE)  NOT NULL    ,  -- 원본 파일의 이름
    FILESYSTEM_NAME     VARCHAR2(300 BYTE)  NOT NULL    ,  -- 변경된 파일의 이름
    CONSTRAINT PK_NOTICE_ATTACH PRIMARY KEY (ATTACH_NO),
    CONSTRAINT FK_NOTICE_ATTACH FOREIGN KEY (NOTICE_NO) REFERENCES NOTICE(NOTICE_NO) ON DELETE CASCADE      -- 공지 삭제 시, 첨부된 사진 삭제
);

-- 검색어 테이블
CREATE TABLE SEARCH (
    USER_NO         NUMBER              NULL        ,  -- 사용자번호
    SEARCH_WORD     VARCHAR2(70 BYTE)   NOT NULL    ,  -- 검색어
    SEARCH_DATE     TIMESTAMP           NULL        ,  -- 검색한 날짜
    CONSTRAINT FK_SEARCH FOREIGN KEY(USER_NO) REFERENCES USER_T (USER_NO) ON DELETE SET NULL
);




-- INSERT 쿼리 테스트

-- 관리자 INSERT
INSERT INTO USER_T VALUES(USER_SEQ.NEXTVAL, 'admin01@naver.com', '관리자1', '1111', 'F', '010-1111-1111', 1, 1, SYSTIMESTAMP, '경기도', '오산', '서울');

---사용자 (USER_T)
INSERT INTO USER_T VALUES(USER_SEQ.NEXTVAL, 'user01@naver.com', '사용자1', '1111', 'M', '010-3333-3333', 0, 1, TO_TIMESTAMP('2023-01-20 12:33:23'), '서울', '금천', '인천');
INSERT INTO USER_T VALUES(USER_SEQ.NEXTVAL, 'user02@naver.com', '사용자2', '1111', 'F', '010-2222-2222', 1, 1, TO_TIMESTAMP('2022-04-29 20:41:00'), '경기도', '용인', '제주');
INSERT INTO USER_T VALUES(USER_SEQ.NEXTVAL, 'user03@naver.com', '사용자3', '1111', 'M', '010-2222-2222', 1, 0, TO_TIMESTAMP('2023-06-10 03:05:01'), '부산', '해운대', '부산');
INSERT INTO USER_T VALUES(USER_SEQ.NEXTVAL, 'user04@naver.com', '사용자4', '1111', 'F', '010-2222-2222', 1, 0, TO_TIMESTAMP('2023-01-01 16:22:00'), '경기도', '수원', '속초');
INSERT INTO USER_T VALUES(USER_SEQ.NEXTVAL, 'user05@naver.com', '사용자5', '1111', 'M', '010-2222-2222', 1, 1, TO_TIMESTAMP('2022-03-15 09:19:32'), '강원도', '강릉', '담양');

--사용자 접속기록 (ACCESS_T)
INSERT INTO ACCESS_T VALUES('admin01@naver.com', SYSTIMESTAMP);
COMMIT;

-- 카테고리 (CATEGORY)
INSERT INTO CATEGORY VALUES (CATEGORY_SEQ.NEXTVAL, '가전제품');
INSERT INTO CATEGORY VALUES (CATEGORY_SEQ.NEXTVAL, '잡화');
INSERT INTO CATEGORY VALUES (CATEGORY_SEQ.NEXTVAL, '식품');

-- 상품 (PRODUCT)
INSERT INTO PRODUCT VALUES(PRODUCT_SEQ.NEXTVAL, 3, 2, 1, '김치냉장고', 30000, '김치냉장고팔아요', SYSTIMESTAMP, SYSTIMESTAMP, 3, 2, '경기도 평택', '김치가썩었어요', 1, SYSTIMESTAMP, SYSTIMESTAMP);
INSERT INTO PRODUCT VALUES(PRODUCT_SEQ.NEXTVAL, 1, 2, 3, '음료수', 2000, '음료수싸요', SYSTIMESTAMP, SYSTIMESTAMP, 3, 2, '서울시 금천', '조아요', 3, SYSTIMESTAMP, SYSTIMESTAMP);
INSERT INTO PRODUCT VALUES(PRODUCT_SEQ.NEXTVAL, 1, 3, 1, '핸드크림', 5000, '향이 좋은 핸드크림', SYSTIMESTAMP, SYSTIMESTAMP, 1, 2, '경기도 수원', '가까워요', 4, SYSTIMESTAMP, SYSTIMESTAMP);
INSERT INTO PRODUCT VALUES(PRODUCT_SEQ.NEXTVAL, 2, 1, 3, '초콜릿', 1000, '달콤한 초콜릿', SYSTIMESTAMP, SYSTIMESTAMP, 3, 2, '경기도 가평', '맛있어요', 3, SYSTIMESTAMP, SYSTIMESTAMP);
INSERT INTO PRODUCT VALUES(PRODUCT_SEQ.NEXTVAL, 4, 3, 2, '마우스', 10000, '로지텍마우스임', SYSTIMESTAMP, SYSTIMESTAMP, 10, 2, '서울시 관악', '최고에요', 4, SYSTIMESTAMP, SYSTIMESTAMP);
INSERT INTO PRODUCT VALUES(PRODUCT_SEQ.NEXTVAL, 1, 2, 1, '커피', 5000, '맛있는 커피', SYSTIMESTAMP, SYSTIMESTAMP, 1, 2, '서울시 동작', '고급원두인듯', 5, SYSTIMESTAMP, SYSTIMESTAMP);
COMMIT;

-- 상품 이미지 (PRODUCT_IMAGE)
INSERT INTO PRODUCT_IMAGE VALUES (PRODUCT_IMAGE_SEQ.NEXTVAL, 1, 'upload/image', 'computer.jpg', 'dogIT', 1);

-- 상품댓글 (PRODUCT_COMMENT)
INSERT INTO PRODUCT_COMMENT VALUES (PRODUCT_COMMENT_SEQ.NEXTVAL, 1, 1, '내용입니다4', SYSTIMESTAMP, 1, 1, 1);

-- 상품 조회 내역
INSERT INTO WATCH_HISTORY VALUES (WATCH_HISTORY_SEQ.NEXTVAL, 1, SYSTIMESTAMP);

-- 관심 상품 (WISHLIST)
INSERT INTO WISHLIST VALUES (WISHLIST_SEQ.NEXTVAL, 1, SYSTIMESTAMP);

-- 알림 (ALARM)
INSERT INTO ALARM VALUES (ALARM_SEQ.NEXTVAL, 1, 1, '댓글왔어요~', '댓글달림', SYSTIMESTAMP, SYSTIMESTAMP);

-- 휴면 회원 (INACTIVE_USER)
INSERT INTO INACTIVE_USER VALUES (INACTIVE_USER_SEQ.NEXTVAL, 'goo2jo@naver.com', '구디2조', '1111', 'F', '010-1111-2222', 1, 1, SYSTIMESTAMP, SYSTIMESTAMP, '서울시', '양천구');

-- 탈퇴한 회원 (LEAVE_USER)
INSERT INTO LEAVE_USER VALUES ('goo2jo@naver.com', SYSTIMESTAMP, SYSTIMESTAMP);

-- 1:1 문의 (INQUIRY)
INSERT INTO INQUIRY VALUES(INQUIRY_SEQ.NEXTVAL, 1, '질문2번입니다.', '제발 보내줘', SYSTIMESTAMP);
INSERT INTO INQUIRY VALUES(INQUIRY_SEQ.NEXTVAL, 3, '질문3번입니다.', '운영자야', SYSTIMESTAMP);
INSERT INTO INQUIRY VALUES(INQUIRY_SEQ.NEXTVAL, 4, '질문4번입니다.', '조정석', SYSTIMESTAMP);
INSERT INTO INQUIRY VALUES(INQUIRY_SEQ.NEXTVAL, 5, '질문5번입니다.', '동원참치~참치', SYSTIMESTAMP);
INSERT INTO INQUIRY VALUES(INQUIRY_SEQ.NEXTVAL, 6, '질문6번입니다.', '야 나두!', SYSTIMESTAMP);
INSERT INTO INQUIRY VALUES(INQUIRY_SEQ.NEXTVAL, 5, '질문7번입니다.', '야 너두?', SYSTIMESTAMP);
INSERT INTO INQUIRY VALUES(INQUIRY_SEQ.NEXTVAL, 4, '질문8번입니다.', '이러다 다 죽어', SYSTIMESTAMP);
INSERT INTO INQUIRY VALUES(INQUIRY_SEQ.NEXTVAL, 3, '질문9번입니다.', '살려줘', SYSTIMESTAMP);
INSERT INTO INQUIRY VALUES(INQUIRY_SEQ.NEXTVAL, 2, '질문10번입니다.', '제발', SYSTIMESTAMP);

-- 1:1 문의 댓글(답변) (ANSWER)
INSERT INTO ANSWER VALUES(ANSWER_SEQ.NEXTVAL, 1, '답변1입니다.', SYSTIMESTAMP, 1, 1, 1);
INSERT INTO ANSWER VALUES(ANSWER_SEQ.NEXTVAL, 2, '답변2입니다.', SYSTIMESTAMP, 1, 1, 1);
INSERT INTO ANSWER VALUES(ANSWER_SEQ.NEXTVAL, 3, '답변3입니다.', SYSTIMESTAMP, 1, 1, 1);
INSERT INTO ANSWER VALUES(ANSWER_SEQ.NEXTVAL, 4, '답변4입니다.', SYSTIMESTAMP, 1, 1, 1);
INSERT INTO ANSWER VALUES(ANSWER_SEQ.NEXTVAL, 5, '답변5입니다.', SYSTIMESTAMP, 1, 1, 1);
INSERT INTO ANSWER VALUES(ANSWER_SEQ.NEXTVAL, 6, '답변6입니다.', SYSTIMESTAMP, 1, 1, 1);
INSERT INTO ANSWER VALUES(ANSWER_SEQ.NEXTVAL, 7, '답변7입니다.', SYSTIMESTAMP, 1, 1, 1);
INSERT INTO ANSWER VALUES(ANSWER_SEQ.NEXTVAL, 8, '답변8입니다.', SYSTIMESTAMP, 1, 1, 1);
INSERT INTO ANSWER VALUES(ANSWER_SEQ.NEXTVAL, 9, '답변9입니다.', SYSTIMESTAMP, 1, 1, 1);
INSERT INTO ANSWER VALUES(ANSWER_SEQ.NEXTVAL, 10, '답변10입니다.', SYSTIMESTAMP, 1, 1, 1);
COMMIT;

-- 1:1 문의 파일첨부
INSERT INTO INQUIRY_ATTACH VALUES (INQUIRY_ATTACH_SEQ.NEXTVAL, 1, '/upload/image', 'dog.jpg', 'photo1.jpg');

-- 공지사항 (NOTICE)
INSERT INTO NOTICE VALUES (NOTICE_SEQ.NEXTVAL, '제목입니다1', '내용입니다2', SYSTIMESTAMP);
INSERT INTO NOTICE VALUES (NOTICE_SEQ.NEXTVAL, '제목입니다1',  '내용입니다2', SYSTIMESTAMP);

-- 공지사항 파일첨부
INSERT INTO NOTICE_ATTACH VALUES (NOTICE_ATTACH_SEQ.NEXTVAL, 1, '/upload/image', 'flower.jpg', 'sea2.jpg');

-- 검색어
INSERT INTO SEARCH VALUES (SEARCH_SEQ.NEXTVAL, '여행 핫플레이스', SYSTIMESTAMP);