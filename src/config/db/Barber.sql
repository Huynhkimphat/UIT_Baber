-----------------------------------------------UIT 's BABER-------------------------------------------------------
-- Intro
-- ...
-- ...
-- END INTRO
-----------------------------------------------DELETE TABLE-------------------------------------------------------
DROP TABLE KhachHang;
DROP TABLE LoaiKhachHang;
DROP TABLE NhanVien;
DROP TABLE TaiKhoan;
DROP TABLE Luong;
DROP TABLE NhanLuong;-- Super_primary_key
DROP TABLE DichVu;
DROP TABLE LoaiSanPham;
DROP TABLE SanPham;
DROP TABLE GioDat;
DROP TABLE DatLich;
DROP TABLE HoaDon;
DROP TABLE CTHD
DROP TABLE CTHDDV; -- Super_primary_key
DROP TABLE CTHDSP; -- Super_primary_key
DROP TABLE DANHGIANHANVIEN;
DROP TABLE DANHGIASANPHAM;
DROP TABLE DANHGIA;

----------------------------------------------DELETE SEQUENCE----------------------------------------------------
DROP SEQUENCE MAKH_SEQ1;
DROP SEQUENCE MALKH_SEQ2;
DROP SEQUENCE MANV_SEQ3;
DROP SEQUENCE MATK_SEQ4;
DROP SEQUENCE MALUONG_SEQ5;
DROP SEQUENCE MADV_SEQ6;
DROP SEQUENCE MALSP_SEQ7;
DROP SEQUENCE MASP_SEQ8;
DROP SEQUENCE MAGD_SEQ9;
DROP SEQUENCE MADL_SEQ10;
DROP SEQUENCE MAHD_SEQ11;
DROP SEQUENCE MADG_SEQ12;--mn nho chay dong nay de xoa di identity
DROP SEQUENCE MADGNV_SEQ12;
DROP SEQUENCE MADGSP_SEQ13;


----------------------------------------------BANG KHACH HANG----------------------------------------------------
CREATE TABLE KhachHang
(
    MaKH            NUMBER              NOT NULL,
    Ho              VARCHAR2(10)        NOT NULL,
    Ten             VARCHAR2(40)        NOT NULL,
    NgaySinh        DATE                NOT NULL,
    GioiTinh        VARCHAR2(10)        DEFAULT 'Unknown',
    SoDT            VARCHAR2(15)        NOT NULL,
    DiaChi          VARCHAR2(255)       DEFAULT 'Unknown', 
    DiemTichLuy     NUMBER              DEFAULT 0,
    HinhAnh         VARCHAR2(4000)      DEFAULT 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Unknown_person.jpg/1200px-Unknown_person.jpg',
    CONSTRAINT      PK_KHACHHANG        PRIMARY KEY(MaKH),
    CONSTRAINT      CHK_KHACHHANG1      CHECK   (GioiTinh in ('Nam','Nu','Unknown') )
);
CREATE SEQUENCE MAKH_SEQ1 START WITH 1;
----------------------------------------------BANG LOAI KHACH HANG -----------------------------------------------
CREATE TABLE LoaiKhachHang
(
    MaLKH           NUMBER              NOT NULL,
    MaKH            NUMBER              CONSTRAINT FK_LOAIKHACHHANG_KHACHHANG    REFERENCES KhachHang(MaKH)  NOT NULL,
    LoaiKH          VARCHAR2(10)        DEFAULT 'Member',
    NgayKichHoatVip DATE                NOT NULL,
    NgayHetHanVip   DATE                NOT NULL,
    CONSTRAINT      PK_LOAIKHACHHANG    PRIMARY KEY(MaLKH),
    CONSTRAINT      CHK_LOAIKHACHHANG1  CHECK   (LoaiKH in ('Member','Vip') ),
    CONSTRAINT      CHK_LOAIKHACHHANG2  CHECK   (NgayKichHoatVip <  NgayHetHanVip)
);
CREATE SEQUENCE MALKH_SEQ2 START WITH 1;

----------------------------------------------BANG NHAN VIEN------------------------------------------------------
CREATE TABLE NhanVien
(
    MaNV            NUMBER          NOT NULL,
    Ho              VARCHAR2(10)    NOT NULL,
    Ten             VARCHAR2(40)    NOT NULL,
    NgaySinh        DATE            NOT NULL,
    GioiTinh        VARCHAR2(10)    DEFAULT 'Unknown',
    SoDT            VARCHAR2(15)    NOT NULL,
    DiaChi          VARCHAR2(255)   DEFAULT 'Unknown',
    NgayVaoLam      DATE            NOT NULL,
    LoaiNhanVien    VARCHAR2(15)    DEFAULT 'Staff',
    HinhAnh         VARCHAR2(4000)  DEFAULT 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Unknown_person.jpg/1200px-Unknown_person.jpg',
    CONSTRAINT      PK_NHANVIEN     PRIMARY KEY(MaNV),
    CONSTRAINT      CHK_NHANVIEN1   CHECK   (GioiTinh in ('Nam','Nu','Unknown') ),
    CONSTRAINT      CHK_NHANVIEN2   CHECK   (LoaiNhanVien in ('Staff','Admin') ),
    CONSTRAINT      CHK_NHANVIEN3   CHECK   (NgaySinh <  NgayVaoLam)
);
CREATE SEQUENCE MANV_SEQ3 START WITH 1;

---------------------------------------------BANG TAI KHOAN-------------------------------------------------------
CREATE TABLE TaiKhoan
(
    MaTK            NUMBER          NOT NULL,
    Email           VARCHAR2(255)   NOT NULL UNIQUE,
    Password        VARCHAR2(255)    NOT NULL,
    MaKH            NUMBER          CONSTRAINT FK_TAIKHOAN_KHACHHANG    REFERENCES KhachHang(MaKH),
    MaNV            NUMBER          CONSTRAINT FK_TAIKHOAN_NHANVIEN     REFERENCES NhanVien(MaNV),
    CONSTRAINT      PK_TAIKHOAN     PRIMARY KEY(MATK)
);
CREATE SEQUENCE MATK_SEQ4 START WITH 1;

---------------------------------------------BANG LUONG-----------------------------------------------------------
CREATE TABLE Luong
(
    MaLuong     NUMBER      NOT NULL,
    MaNV        NUMBER      CONSTRAINT FK_LUONG_NHANVIEN    REFERENCES NhanVien(MaNV)   NOT NULL,
    LuongCoBan  NUMBER      NOT NULL,
    CONSTRAINT  PK_LUONG    PRIMARY KEY(MaLuong)
);
CREATE SEQUENCE MALUONG_SEQ5 START WITH 1;

--------------------------------------------BANG NHAN LUONG-------------------------------------------------------
CREATE TABLE NhanLuong
(
    MaLuong         NUMBER              CONSTRAINT FK_NHANLUONG_LUONG       REFERENCES Luong(MaLuong)   NOT NULL,
    MaNV            NUMBER              CONSTRAINT FK_NHANLUONG_NHANVIEN    REFERENCES NhanVien(MaNV)   NOT NULL,
    NgayNhanLuong   DATE                NOT NULL,
    LuongCoBan      NUMBER              NOT NULL,
    LuongThuong     NUMBER              NOT NULL,
    LuongDuocNhan   NUMBER              NOT NULL,
    CONSTRAINT      PK_NHANLUONG        PRIMARY KEY(MaLuong,MaNV,NgayNhanLuong)
);

--------------------------------------------BANG DICH VU----------------------------------------------------------
CREATE TABLE DichVu
(
    MaDV        NUMBER          NOT NULL,
    TenDichVu   VARCHAR2(255)   NOT NULL,
    Gia         NUMBER          default 0,
    MotaDichVu  VARCHAR2(4000)  NOT NULL,
    HinhAnh     VARCHAR2(4000)  DEFAULT 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Unknown_person.jpg/1200px-Unknown_person.jpg',
    CONSTRAINT  PK_DICHVU       PRIMARY KEY(MaDV)
);
CREATE SEQUENCE MADV_SEQ6 START WITH 1;
--------------------------------------------BANG LOAI SAN PHAM----------------------------------------------------
CREATE  TABLE LOAISANPHAM
(
    MaLSP           NUMBER              NOT NULL,
    TenLoaiSanPham  VARCHAR2(255)       NOT NULL,
    CONSTRAINT      PK_LOAISANPHAM      PRIMARY KEY (MaLSP)
);
CREATE SEQUENCE MALSP_SEQ7 START WITH 1;

---------------------------------------------BANG SAN PHAM--------------------------------------------------------
CREATE  TABLE SanPham
(
    MaSP            NUMBER          NOT NULL,
    TenSanPham      VARCHAR2(255)   NOT NULL,
    Gia             NUMBER          NOT NULL,
    MOTASANPHAM     VARCHAR2(4000)  NOT NULL,
    XuatXu          VARCHAR2(100)   NOT NULL,
    HinhAnh         VARCHAR2(4000)  DEFAULT 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Unknown_person.jpg/1200px-Unknown_person.jpg',
    TinhTrang       NUMBER          DEFAULT 1,
    SoLuong         NUMBER          DEFAULT 0,
    MaLSP           NUMBER          CONSTRAINT FK_SANPHAM_LOAISANPHAM    REFERENCES LOAISANPHAM(MaLSP)   NOT NULL,
    CONSTRAINT      PK_SANPHAM      PRIMARY KEY (MaSP)
);
CREATE SEQUENCE MASP_SEQ8 START WITH 1;
---------------------------------------------BANG GIO DAT---------------------------------------------------------
CREATE TABLE GioDat
(
    MaGio       NUMBER              NOT NULL,
    KhungGio    VARCHAR2(20)        NOT NULL,
    CONSTRAINT  PK_GIODAT           PRIMARY KEY(MaGio)
);
CREATE SEQUENCE MAGD_SEQ9 START WITH 1;
---------------------------------------------BANG DAT LICH--------------------------------------------------------
CREATE TABLE DatLich
(
    MaDL        NUMBER          NOT NULL,
    Ngay        DATE            NOT NULL,
    MaGio       NUMBER          CONSTRAINT FK_DATLICH_GIODAT    REFERENCES GioDat(MaGio)    NOT NULL,
    MaKH        NUMBER          CONSTRAINT FK_DATLICH_KHACHHANG REFERENCES KhachHang(MaKH)  NOT NULL,
    MaNV        NUMBER          CONSTRAINT FK_DATLICH_NHANVIEN  REFERENCES NhanVien(MaNV)   NOT NULL,
    MaDV        NUMBER          CONSTRAINT FK_DATLICH_DICHVU    REFERENCES DichVu(MaDV)     NOT NULL,
    CONSTRAINT  PK_DatLich      PRIMARY KEY (MaDL)
);
CREATE SEQUENCE MADL_SEQ10 START WITH 1;
---------------------------------------------BANG HOA DON---------------------------------------------------------
CREATE TABLE HoaDon
(
    MaHD        NUMBER      NOT NULL,
    MaKH        NUMBER      CONSTRAINT FK_HOADON_KHACHHANG REFERENCES KhachHang(MaKH)  NOT NULL,
    KhuyenMai   NUMBER      DEFAULT 0,
    TongTien    NUMBER      NOT NULL,
    CONSTRAINT  PK_HD       PRIMARY KEY(MaHD)
);
CREATE SEQUENCE MAHD_SEQ11 START WITH 1;
--------------------------------------------BANG CTHDDV-----------------------------------------------------------
CREATE TABLE CTHDDV
( 
    MaHD        NUMBER      CONSTRAINT FK_CTHDDV_HOADON     REFERENCES HOADON(MaHD)    NOT NULL,
    MaDV        NUMBER      CONSTRAINT FK_CTHDDV_DICHVU     REFERENCES DICHVU(MaDV)    NOT NULL,
    CONSTRAINT  PK_CTHDDV   PRIMARY KEY(MaHD,MaDV)
);
--------------------------------------------BANG CTHDSP-----------------------------------------------------------
CREATE TABLE CTHDSP
( 
    MaHD        NUMBER      CONSTRAINT FK_CTHDSP_HOADON      REFERENCES HOADON(MaHD)    NOT NULL,
    MaSP        NUMBER      CONSTRAINT FK_CTHDSP_SANPHAM     REFERENCES SANPHAM(MaSP)   ,
    SoLuong     NUMBER,
    CONSTRAINT  PK_CTHDSP   PRIMARY KEY(MaHD,MaSP)
);
--------------------------------------------BANG DANH GIA NHAN VIEN-----------------------------------------------
CREATE TABLE DANHGIANHANVIEN
( 
    MaDGNV            NUMBER          NOT NULL,
    MaKH            NUMBER          CONSTRAINT FK_DANHGIA_KHACHHANG     REFERENCES KHACHHANG(MaKH)      NOT NULL,
    MaNV            NUMBER          CONSTRAINT FK_DANHGIA_NHANVIEN      REFERENCES NHANVIEN(MaNV)       NOT NULL,
    NgayDanhGia     DATE            NOT NULL,
    DANHGIA         NUMBER          NOT NULL,
    CHITIETDANHGIA  VARCHAR2(255)   NOT NULL,
    CONSTRAINT      PK_DGNV           PRIMARY KEY(MaDGNV)
);
CREATE SEQUENCE MADGNV_SEQ12 START WITH 1;
--------------------------------------------BANG DANH GIA SAN PHAM------------------------------------------------
CREATE TABLE DANHGIASANPHAM
( 
    MaDGSP          NUMBER          NOT NULL,
    MaKH            NUMBER          CONSTRAINT FK_DANHGIA_KHACHHANG1     REFERENCES KHACHHANG(MaKH)      NOT NULL,
    MaSP            NUMBER          CONSTRAINT FK_DANHGIA_SANPHAM       REFERENCES SANPHAM(MaSP)       NOT NULL,
    NgayDanhGia     DATE            NOT NULL,
    DANHGIA         NUMBER          NOT NULL,
    CHITIETDANHGIA  VARCHAR2(255)   NOT NULL,
    CONSTRAINT      PK_DGSP           PRIMARY KEY(MaDGSP)
);
CREATE SEQUENCE MADGSP_SEQ13 START WITH 1;

--------------------------------------------SELECT RECORDS-------------------------------------------------------
-- Khach Hang
SELECT * FROM KhachHang
-- Loai Khach Hang
SELECT * FROM LoaiKhachHang
-- Nhan Vien
SELECT * FROM NhanVien
-- Tai Khoan
SELECT * FROM TaiKhoan
-- Luong
SELECT * FROM Luong
-- Luong Thuong
SELECT * FROM LuongThuong
-- Tang Luong
SELECT * FROM TangLuong
-- Nhan Luong
SELECT * FROM NhanLuong
-- Dich Vu
SELECT * FROM DichVu
-- Loai San Pham
SELECT * FROM LoaiSanPham
-- San Pham
SELECT * FROM SanPham
-- Gio Dat
SELECT * FROM GioDat
-- Dat Lich
SELECT * FROM DatLich
-- Hoa Don
SELECT * FROM HoaDon
-- CTHD
SELECT * FROM CTHD
-- Danh Gia
SELECT * FROM DanhGia
--------------------------------------------INSERT RECORDS-------------------------------------------------------
ALTER SESSION SET NLS_DATE_FORMAT ='DD-MM-YYYY HH24:MI:SS';
-- Nhan Vien
INSERT INTO NhanVien(MaNV,Ho,Ten,NgaySinh,GioiTinh,SoDT,NgayVaoLam,LoaiNhanVien) VALUES (
    MANV_SEQ3.nextval,'Nguyen','Nhut',To_Date('02-09-1999','dd-mm-yyyy'),'Nam','0374349383',To_Date('12-03-2021','dd-mm-yyyy'),'Admin');
INSERT INTO NhanVien(MaNV,Ho,Ten,NgaySinh,GioiTinh,SoDT,NgayVaoLam) VALUES (   
            MANV_SEQ3.nextval,'Quy','Tường',to_date('09-06-2020','dd-mm-yyyy'),'Nu','0935589947',To_Date('20-3-2021','dd-mm-yyyy'));
-- TaiKhoan
INSERT INTO TaiKhoan VALUES (
    MATK_SEQ4.nextval,'1@gmail.com','1',null,MANV_SEQ3.CURRVAL);
-- GioDat
INSERT INTO GioDat VALUE(MAGD_SEQ9.NEXTVAL,'8h30-10h00');
INSERT INTO GioDat VALUE(MAGD_SEQ9.NEXTVAL,'10h00-11h30');
INSERT INTO GioDat VALUE(MAGD_SEQ9.NEXTVAL,'13h00-14h30');
INSERT INTO GioDat VALUE(MAGD_SEQ9.NEXTVAL,'14h30-16h00');
INSERT INTO GioDat VALUE(MAGD_SEQ9.NEXTVAL,'16h00-17h30');
INSERT INTO GioDat VALUE(MAGD_SEQ9.NEXTVAL,'17h30-19h00');
INSERT INTO GioDat VALUE(MAGD_SEQ9.NEXTVAL,'19h30-20h30');
INSERT INTO GioDat VALUE(MAGD_SEQ9.NEXTVAL,'20h30-22h00');


--------------------------------------------ALTER CHECKS---------------------------------------------------------
-- ALTER TABLE KHACHHANG
-- ADD CHECK (LOAIKH IN('Than thiet','VIP','Super VIP'));

-- ALTER TABLE KHACHHANG
-- ADD CONSTRAINT check_constraint_name CHECK(expression);
--------------------------------------------TRIGGER--------------------------------------------------------------
-- TRIGGER 15
-- Ngày đặt lịch lớn hơn ngày sinh của khách hàng và nhân viên.
-- Khach Hang Sua
SET DEFINE OFF;
CREATE TRIGGER TRIGGER_15_KHACHHANG
AFTER UPDATE ON KHACHHANG
FOR EACH ROW
DECLARE
    t_ngaysinh KHACHHANG.ngaysinh%TYPE
    t_ngaydatlich DATLICH.Ngay%TYPE
BEGIN 
    t_ngaysinh := :NEW.ngaysinh

    SELECT dl.ngay into t_ngaydatlich
    FROM (
        SELECT dl.ngay from DATLICH dl 
        WHERE dl.MaKH=:NEW.MaKH
        ORDER BY dl.ngay ASC
    )
    WHERE ROWNUM=1

    IF(t_ngaysinh>t_ngaydatlich)
    THEN 
        DBMS_OUTPUT.PUT_LINE('ERORR!!!!');
        RAISE_APPLICATION_ERROR(-2000, 'LOI !!!');
END;
-- Nhan VIen Sua

SET DEFINE OFF;
CREATE TRIGGER TRIGGER_15_NHANVIEN
AFTER UPDATE ON NHANVIEN
FOR EACH ROW
DECLARE
    t_ngaysinh NHANVIEN.ngaysinh%TYPE
    t_ngaydatlich DATLICH.Ngay%TYPE
BEGIN 
    t_ngaysinh := :NEW.ngaysinh

    SELECT dl.ngay into t_ngaydatlich
    FROM (
        SELECT dl.ngay from DATLICH dl 
        WHERE dl.MaNV=:NEW.MaNV
        ORDER BY dl.ngay ASC
    )
    WHERE ROWNUM=1

    IF(t_ngaysinh>t_ngaydatlich)
    THEN 
        DBMS_OUTPUT.PUT_LINE('ERORR!!!!');
        RAISE_APPLICATION_ERROR(-2000, 'LOI !!!');
END;
-- Dat Lich Them Sua
SET DEFINE OFF;
CREATE TRIGGER TRIGGER_15_DATLICH
AFTER INSERT,UPDATE ON DATLICH
FOR EACH ROW
DECLARE
    t_ngaysinhKH KHACHHANG.ngaysinh%TYPE
    t_ngaysinhNV NHANVIEN.ngaysinh%TYPE
    t_ngaydatlich DATLICH.Ngay%TYPE
BEGIN 
    t_ngaydatlich := :NEW.ngay
    

    SELECT nv.ngaysinh into t_ngaysinhNV
    FROM NHANVIEN nv
    WHERE nv.MANV=:NEW.MANV;

    SELECT kh.ngaysinh into t_ngaysinhKH
    FROM KHACHHANG kh
    WHERE kh.MaKH=:NEW.MaKH;

    IF(t_ngaysinhNV>t_ngaydatlich or t_ngaysinhKH>t_ngaydatlich)
    THEN 
        DBMS_OUTPUT.PUT_LINE('ERORR!!!!');
        RAISE_APPLICATION_ERROR(-2000, 'LOI !!!');
END;
-- TRIGGER 19
-- Ngày vào làm của một nhân viên phải nhỏ hơn hoặc bằng ngày đặt lịch.
-- Nhan Vien Sua
SET DEFINE OFF;
CREATE TRIGGER TRIGGER_19_NHANVIEN
AFTER UPDATE ON NHANVIEN
FOR EACH ROW
DECLARE
    t_ngayvaolam NHANVIEN.NgayVaoLam%TYPE
    t_ngaydatlich DATLICH.Ngay%TYPE
BEGIN
    t_ngayvaolam := :NEW.NgayVaoLam

    SELECT dl.ngay into t_ngaydatlich
    FROM (
        SELECT dl.ngay from DATLICH dl 
        WHERE dl.MaNV=:NEW.MaNV
        ORDER BY dl.ngay ASC
    )
    WHERE ROWNUM=1

    IF(t_ngayvaolam>t_ngaydatlich)
    THEN 
        DBMS_OUTPUT.PUT_LINE('ERORR!!!!');
        RAISE_APPLICATION_ERROR(-2000, 'LOI !!!');
END;
-- Dat Lich Sua
SET DEFINE OFF;
CREATE TRIGGER TRIGGER_19_DATLICH
AFTER UPDATE ON DATLICH
FOR EACH ROW
DECLARE
    t_ngayvaolam NHANVIEN.NgayVaoLam%TYPE
    t_ngaydatlich DATLICH.Ngay%TYPE
BEGIN 
    t_ngaydatlich := :NEW.ngay

    SELECT nv.NgayVaoLam into t_ngayvaolam
    FROM NHANVIEN nv
    WHERE nv.MaNV=:NEW.MaNV;

    IF(t_ngayvaolam>t_ngaydatlich)
    THEN 
        DBMS_OUTPUT.PUT_LINE('ERORR!!!!');
        RAISE_APPLICATION_ERROR(-2000, 'LOI !!!');
END;
--------------------------------------------INSERT TABLE: SANPHAM---------------------------------------------------------
DESCRIBE SANPHAM;
INSERT INTO SANPHAM VALUES (
    MASP_SEQ8.NEXTVAL, 'Seri', 220000, 'Dầu gội giữ màu tóc','VietNam', 2);
INSERT INTO SANPHAM VALUES (
    MASP_SEQ8.NEXTVAL, 'Glanzen Clay 60g', 329000, 'Sáp Chính Hãng Bán Chạy Số 1 Thị Trường','Đức', 1);
INSERT INTO SANPHAM VALUES (
    MASP_SEQ8.NEXTVAL, 'ACSYS', 289000, 'Sữa Rửa Mặt trị mụn - Phiên bản đặc biệt','Hàn Quốc', 3);


--------------------------------------------INSERT TABLE: LOAISANPHAM---------------------------------------------------------
DESCRIBE LOAISANPHAM;
INSERT INTO LOAISANPHAM VALUES (MALSP_SEQ7.NEXTVAL,'Sáp');
INSERT INTO LOAISANPHAM VALUES (MALSP_SEQ7.NEXTVAL,'Dầu gội');
INSERT INTO LOAISANPHAM VALUES (MALSP_SEQ7.NEXTVAL,'Sữa rửa mặt');

INSERT INTO DichVu VALUES (
    MADV_SEQ6.NEXTVAL, 'Dich vu 1', 220000, 'Day la dich vu so 1');
    INSERT INTO DichVu VALUES (
    MADV_SEQ6.NEXTVAL, 'Dich vu 2', 220000, 'Day la dich vu so 2');
    INSERT INTO DichVu VALUES (
    MADV_SEQ6.NEXTVAL, 'Dich vu 3', 220000, 'Day la dich vu so 3');

SELECT * FROM SANPHAM
INSERT INTO KHACHHANG VALUES (
    MAKH_SEQ1.NEXTVAL, 'Phat','Huynh',To_Date('02-09-1999','dd-mm-yyyy'),'Nam','0374349383','111',0);

INSERT INTO DATLICH VALUES(MADL_SEQ10.NEXTVAL, To_Date('02-09-1999','dd-mm-yyyy'),1,1,1,1);
SELECT * FROM DATLICH
CREATE TABLE DatLich

SELECT * FROM KHACHHANG, LoaiKhachHang
WHERE KHACHHANG.MaKH = LoaiKhachHang.MaKH


CREATE TABLE LoaiKhachHang
(
    MaLKH           NUMBER              NOT NULL,
    MaKH            NUMBER              CONSTRAINT FK_LOAIKHACHHANG_KHACHHANG    REFERENCES KhachHang(MaKH)  NOT NULL,
    LoaiKH          VARCHAR2(10)        DEFAULT 'Member',
    NgayKichHoatVip DATE                NOT NULL,
    NgayHetHanVip   DATE                NOT NULL,
    CONSTRAINT      PK_LOAIKHACHHANG    PRIMARY KEY(MaLKH),
    CONSTRAINT      CHK_LOAIKHACHHANG1  CHECK   (LoaiKH in ('Member','Vip') ),
    CONSTRAINT      CHK_LOAIKHACHHANG2  CHECK   (NgayKichHoatVip <  NgayHetHanVip)
);

SELECT * FROM LoaiKhachHang
SELECT * FROM KHACHHANG
INSERT INTO LoaiKhachHang VALUES (MALKH_SEQ2.NEXTVAL, 1, 'Vip', To_Date('11-09-2020','dd-mm-yyyy'), To_Date('02-09-2021','dd-mm-yyyy'))
<<<<<<< HEAD
--------------------------------------------INSERT TABLE: DICHVU---------------------------------------------------------
DESCRIBE DICHVU
SELECT * FROM DICHVU
INSERT INTO DICHVU VALUES (MADV_SEQ6.NEXTVAL, 'Service 1', 50000, 'Brand new service',DEFAULT );
INSERT INTO DICHVU VALUES (MADV_SEQ6.NEXTVAL, 'Service 2', 50000, 'Brand new service',DEFAULT );
INSERT INTO DICHVU VALUES (MADV_SEQ6.NEXTVAL, 'Service 3', 50000, 'Brand new service',DEFAULT );
--------------------------------------------INSERT TABLE: KHACHHANG---------------------------------------------------------
DESCRIBE KHACHHANG
SELECT * FROM KHACHHANG
INSERT INTO KHACHHANG VALUES (MAKH_SEQ1.NEXTVAL, 'LE DUY','HOANG 1', To_Date('22-10-2001','dd-mm-yyyy'),'Nam','22102001','BT',0,DEFAULT);
INSERT INTO KHACHHANG VALUES (MAKH_SEQ1.NEXTVAL, 'LE DUY','HOANG 2', To_Date('22-10-2002','dd-mm-yyyy'),'Nam','22102002','BT',0,DEFAULT);
INSERT INTO KHACHHANG VALUES (MAKH_SEQ1.NEXTVAL, 'LE DUY','HOANG 3', To_Date('22-10-2003','dd-mm-yyyy'),'Nam','22102003','BT',0,DEFAULT);
--------------------------------------------INSERT TABLE: LOAIKHACHHANG---------------------------------------------------------
DESCRIBE LOAIKHACHHANG
SELECT * FROM LOAIKHACHHANG
INSERT INTO LOAIKHACHHANG VALUES(MALKH_SEQ2.NEXTVAL, 1, 'Vip', To_Date('22-10-2020','dd-mm-yyyy'), To_Date('22-10-2021','dd-mm-yyyy'));
INSERT INTO LOAIKHACHHANG VALUES(MALKH_SEQ2.NEXTVAL, 2, 'Vip', To_Date('22-10-2020','dd-mm-yyyy'), To_Date('22-10-2021','dd-mm-yyyy'));
INSERT INTO LOAIKHACHHANG VALUES(MALKH_SEQ2.NEXTVAL, 3, 'Vip', To_Date('22-10-2020','dd-mm-yyyy'), To_Date('22-10-2021','dd-mm-yyyy'));
--------------------------------------------INSERT TABLE: TAIKHOAN---------------------------------------------------------
DESCRIBE TAIKHOAN
SELECT * FROM TAIKHOAN
INSERT INTO TAIKHOAN VALUES (MATK_SEQ4.NEXTVAL, 'ldh8d@gmail.com', '123456', 1, null);
INSERT INTO TAIKHOAN VALUES (MATK_SEQ4.NEXTVAL, 'ldh9d@gmail.com', '123456', 2, null);
INSERT INTO TAIKHOAN VALUES (MATK_SEQ4.NEXTVAL, 'ldh10d@gmail.com', '123456', 3, null);
INSERT INTO TAIKHOAN VALUES (MATK_SEQ4.NEXTVAL, 'kp8d@gmail.com', '123456', null, 1);
INSERT INTO TAIKHOAN VALUES (MATK_SEQ4.NEXTVAL, 'kp9d@gmail.com', '123456', null, 2);
INSERT INTO TAIKHOAN VALUES (MATK_SEQ4.NEXTVAL, 'kp10d@gmail.com', '123456', null, 3);
SELECT * FROM KHACHHANG, LoaiKhachHang, TAIKHOAN 
WHERE KHACHHANG.MAKH = LOAIKHACHHANG.MAKH
AND   KHACHHANG.MAKH = TAIKHOAN.MAKH
--------------------------------------------INSERT TABLE: NHANVIEN---------------------------------------------------------
DESCRIBE NHANVIEN
SELECT * FROM NHANVIEN
INSERT INTO NHANVIEN VALUES (MANV_SEQ3.NEXTVAL, 'KIM', 'PHAT 1', To_Date('02-09-2001','dd-mm-yyyy'), 'Nam', '02092001', 'GV', To_Date('22-10-2018','dd-mm-yyyy'), 'Staff', DEFAULT);
INSERT INTO NHANVIEN VALUES (MANV_SEQ3.NEXTVAL, 'KIM', 'PHAT 2', To_Date('02-09-2002','dd-mm-yyyy'), 'Nam', '02092002', 'GV', To_Date('22-10-2018','dd-mm-yyyy'), 'Staff', DEFAULT);
INSERT INTO NHANVIEN VALUES (MANV_SEQ3.NEXTVAL, 'KIM', 'PHAT 3', To_Date('02-09-2003','dd-mm-yyyy'), 'Nam', '02092003', 'GV', To_Date('22-10-2018','dd-mm-yyyy'), 'Staff', DEFAULT);
--------------------------------------------INSERT TABLE: LUONG---------------------------------------------------------
DESCRIBE LUONG
SELECT * FROM LUONG
INSERT INTO LUONG VALUES (MALUONG_SEQ5.NEXTVAL, 1, 20000000);
INSERT INTO LUONG VALUES (MALUONG_SEQ5.NEXTVAL, 2, 20000000);
INSERT INTO LUONG VALUES (MALUONG_SEQ5.NEXTVAL, 3, 20000000);
--------------------------------------------INSERT TABLE: NHANLUONG---------------------------------------------------------
DESCRIBE NHANLUONG
SELECT * FROM NHANLUONG
INSERT INTO NHANLUONG VALUES (1, 1, To_Date('01-01-2020','dd-mm-yyyy'), 20000000, 0, 20000000);
INSERT INTO NHANLUONG VALUES (2, 2, To_Date('01-01-2020','dd-mm-yyyy'), 20000000, 0, 20000000);
INSERT INTO NHANLUONG VALUES (3, 3, To_Date('01-01-2020','dd-mm-yyyy'), 20000000, 0, 20000000);

SELECT * FROM NHANVIEN, TAIKHOAN, LUONG, NHANLUONG WHERE NHANVIEN.MANV = TAIKHOAN.MANV AND NHANVIEN.MANV = LUONG.MANV AND NHANVIEN.MANV = NHANLUONG.MANV;
=======



DELETE FROM DATLICH WHERE MaDL = 1
>>>>>>> master
