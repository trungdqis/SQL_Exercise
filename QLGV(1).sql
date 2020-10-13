CREATE DATABASE QLGV;
USE QLGV;

CREATE TABLE KHOA (
	MAKHOA varchar(4) PRIMARY KEY,
	TENKHOA varchar(40),
	NGTLAP smalldatetime,
	TRGKHOA char(4)
)

CREATE TABLE MONHOC (
	MAMH varchar(10) PRIMARY KEY,
	TENMH varchar(40),
	TCLT tinyint,
	TCTH tinyint,
	MAKHOA varchar(4)
)

CREATE TABLE DIEUKIEN (
	MAMH varchar(10) CONSTRAINT FK_MHDK1 REFERENCES MONHOC(MAMH),
	MAMH_TRUOC varchar(10) CONSTRAINT FK_MHDK2 REFERENCES MONHOC(MAMH),
	PRIMARY KEY (MAMH, MAMH_TRUOC)
)

CREATE TABLE GIAOVIEN (
	MAGV char(4) PRIMARY KEY,
	HOTEN varchar(40),
	HOCVI varchar(10),
	HOCHAM varchar(10),
	GIOITINH varchar(3),
	NGSINH smalldatetime,
	NGVL smalldatetime,
	HESO numeric(4,2),
	MUCLUONG money,
	MAKHOA varchar(4) CONSTRAINT FK_KHOAGV REFERENCES KHOA(MAKHOA)
)

CREATE TABLE LOP (
	MALOP char(3) PRIMARY KEY,
	TENLOP varchar(40),
	TRGLOP char(5),
	SISO tinyint,
	MAGVCN char(4) CONSTRAINT FK_GVLOP REFERENCES GIAOVIEN(MAGV)
)

CREATE TABLE HOCVIEN (
	MAHV char(5) PRIMARY KEY,
	HO varchar(40),
	TEN varchar(10),
	NGSINH smalldatetime,
	GIOITINH varchar(3),
	NOISINH varchar(40),
	MALOP char(3) CONSTRAINT FK_LOPHV REFERENCES LOP(MALOP)
)
ALTER TABLE LOP
ADD CONSTRAINT FK_HVLOP FOREIGN KEY (TRGLOP) REFERENCES HOCVIEN(MAHV);

CREATE TABLE GIANGDAY (
	MALOP char(3) CONSTRAINT FK_LOPGD REFERENCES LOP(MALOP),
	MAMH varchar(10) CONSTRAINT FK_MHGD REFERENCES MONHOC(MAMH),
	MAGV char(4) CONSTRAINT FK_GVGD REFERENCES GIAOVIEN(MAGV),
	HOCKY tinyint,
	NAM smallint,
	TUNGAY smalldatetime,
	DENNGAY smalldatetime
	PRIMARY KEY (MALOP, MAMH)
)

CREATE TABLE KETQUATHI (
	MAHV char(5) REFERENCES HOCVIEN(MAHV),
	MAMH varchar(10) REFERENCES MONHOC(MAMH),
	LANTHI tinyint,
	NGTHI smalldatetime,
	DIEM numeric(4,2),
	KQUA varchar(10)
	PRIMARY KEY (MAHV, MAMH, LANTHI)
)

--- 1 ---
ALTER TABLE HOCVIEN
ADD GHICHU VARCHAR(50), 
	DIEMTB NUMERIC(2, 2), 
	XEPLOAI VARCHAR(5);

ALTER TABLE HOCVIEN
ALTER COLUMN DIEMTB NUMERIC(4,2);
--- 2 ---
ALTER TABLE HOCVIEN
ADD CONSTRAINT CK_MHV
CHECK (LEFT (MAHV,3) = MALOP AND RIGHT (MAHV, 2) LIKE '[0-9][0-9]');
--- 3 ---
ALTER TABLE HOCVIEN
ADD CONSTRAINT CK_GT1
CHECK (GIOITINH = 'Nam' OR GIOITINH = 'Nu');

ALTER TABLE GIAOVIEN
ADD CONSTRAINT CK_GT2
CHECK (GIOITINH = 'Nam' OR GIOITINH = 'Nu');
--- 4 ---
ALTER TABLE KETQUATHI 
ADD CONSTRAINT CK_DIEM
CHECK (DIEM >= 0 AND DIEM <= 10);
--- 5 ---
ALTER TABLE KETQUATHI
ADD CONSTRAINT CK_KQUA
CHECK ((KQUA = 'Dat' AND (DIEM >=5 AND DIEM <= 10)) OR (KQUA = 'Khong dat' AND DIEM < 5));
--- 6 ---
ALTER TABLE KETQUATHI
ADD CONSTRAINT CK_LANTHI
CHECK (LANTHI BETWEEN 1 AND 3);
--- 7 ---
ALTER TABLE GIANGDAY
ADD CONSTRAINT CHK_HK
CHECK (HOCKY IN (1, 2, 3));
--- 8 ---
ALTER TABLE GIAOVIEN
ADD CONSTRAINT CHK_HVGV
CHECK (HOCVI IN ('CN', 'KS', 'Ths', 'TS', 'PTS'));
