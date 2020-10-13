CREATE DATABASE QLBH;
USE QLBH;

--- Tao quan he, khoa chinh, khoa ngoai ---
--- TABLE KHACHHANG ---
CREATE TABLE KHACHHANG (
	MAKH char(4) PRIMARY KEY,
	HOTEN varchar(40),
	DCHI varchar(50),
	SODT varchar(20),
	NGSINH smalldatetime,
	NGDK smalldatetime,
	DOANHSO money
)
--- TABLE NHANVIEN ---
CREATE TABLE NHANVIEN (
	MANV char(4) PRIMARY KEY,
	HOTEN varchar(40),
	SODT varchar(20),
	NGVL smalldatetime
)
--- TABLE SANPHAM ---
CREATE TABLE SANPHAM (
	MASP char(4) PRIMARY KEY,
	TENSP varchar(40),
	DVT varchar(20),
	NUOCSX varchar(40),
	GIA money
)
--- TABLE HOADON ---
CREATE TABLE HOADON (
	SOHD int NOT NULL PRIMARY KEY,
	NGHD smalldatetime,
	MAKH char(4) CONSTRAINT FK_KHHD REFERENCES KHACHHANG(MAKH),
	MANV char(4) CONSTRAINT FK_NVHD REFERENCES  NHANVIEN(MANV),
	TRIGIA money,
)
--- TABLE CTHD ---
CREATE TABLE CTHD (
	SOHD int CONSTRAINT FK_HDCTTD REFERENCES HOADON(SOHD),
	MASP char(4) CONSTRAINT FK_SPCTTD REFERENCES SANPHAM(MASP),
	SL int,
	PRIMARY KEY (SOHD, MASP)
)
--- 2 ---
ALTER TABLE SANPHAM ADD GHICHU varchar(20);
--- 3 ---
ALTER TABLE KHACHHANG ADD LOAIKH tinyint;
--- 4 ---
ALTER TABLE SANPHAM
ALTER COLUMN GHICHU varchar(100);
--- 5 ---
ALTER TABLE SANPHAM
DROP COLUMN GHICHU;
--- 6 ---
ALTER TABLE KHACHHANG
ADD CONSTRAINT CHK_LOAIKH 
CHECK (LOAIKH in ('Vang lai', 'Thuong xuyen', 'Vip'));
--- 7 ---
ALTER TABLE SANPHAM
ADD CONSTRAINT CHK_DVT
CHECK (DVT in ('cay', 'hop', 'cai', 'quyen', 'chuc'));
--- 8 ---
ALTER TABLE SANPHAM
ADD CONSTRAINT CHK_GIA
CHECK (GIA > 500);
--- 9 ---
ALTER TABLE CTHD
ADD CONSTRAINT CHK_SL
CHECK (SL >= 1);
--- 10 ---
ALTER TABLE KHACHHANG
ADD CONSTRAINT CHK_NGSINH
CHECK (NGDK > NGSINH);

ALTER TABLE KHACHHANG
DROP CHK_NGSINH;

ALTER TABLE KHACHHANG
ADD CONSTRAINT CHK_NGDK
CHECK (DATEDIFF(day, NGSINH, NGDK) > 0);