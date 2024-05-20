-- Tạo bảng chứa thông tin sản phẩm tồn kho
CREATE TABLE SanPhamTonKho (
    MaSanPham INT PRIMARY KEY,
    TenSanPham NVARCHAR(100),
    LoaiSanPham NVARCHAR(50),
    HinhSanPham NVARCHAR(255),
    NgayNhap DATE,
    SoLuong INT,
    TinhTrang NVARCHAR(50)
);

-- Tạo bảng chứa thông tin sản phẩm đang bán
CREATE TABLE SanPhamDangBan (
    MaSanPham INT PRIMARY KEY,
    TenSanPham NVARCHAR(100),
    HinhSanPham NVARCHAR(255),
    LoaiSanPham NVARCHAR(50),
    MoTaSanPham NVARCHAR(MAX),
    SoLuongTrongCuaHang INT,
    SoLuongDaBan INT,
    GiaNiemYet DECIMAL(18, 2),
    MaKhuyenMai INT,
    DoanhThu DECIMAL(18, 2)
);

-- Tạo bảng chứa thông tin đánh giá sản phẩm
CREATE TABLE DanhGiaSanPham (
    MaSanPham INT,
    MaNguoiDanhGia INT,
    NoiDungDanhGia NVARCHAR(MAX),
    NgayDanhGia DATE,
    PRIMARY KEY (MaSanPham, MaNguoiDanhGia)
);

-- Tạo bảng chứa thông tin khuyến mãi
CREATE TABLE KhuyenMai (
    MaKhuyenMai INT PRIMARY KEY,
    TenKhuyenMai NVARCHAR(100),
    GiaTriKhuyenMai DECIMAL(18, 2),
    TinhTrang NVARCHAR(50),
    LoaiKhuyenMai NVARCHAR(50)
);

-- Tạo bảng chứa thông tin hóa đơn
CREATE TABLE HoaDon (
    MaHoaDon INT PRIMARY KEY,
    TongGiaTriHoaDon DECIMAL(18, 2),
    NgayXuat DATE,
    MaKhachHang INT,
    MaKhuyenMai INT
);

-- Tạo bảng chứa chi tiết hóa đơn
CREATE TABLE ChiTietHoaDon (
    MaHoaDon INT,
    MaSanPham INT,
    SoLuong INT,
    TongGia DECIMAL(18, 2),
    PRIMARY KEY (MaHoaDon, MaSanPham)
);

-- Tạo bảng chứa thông tin đơn hàng
CREATE TABLE DonHang (
    MaHoaDon INT PRIMARY KEY,
    MaKhachHang INT,
    SDTKhachHang NVARCHAR(15),
    DiaChiKhachHang NVARCHAR(255),
    TinhTrang NVARCHAR(50)
);

-- Tạo bảng chứa thông tin chiến lược tiếp thị
CREATE TABLE ChienLuocTiepThi (
    MaChienLuoc INT PRIMARY KEY,
    LoaiSanPham NVARCHAR(50),
    TenChienLuoc NVARCHAR(100),
    NoiDungChienLuoc NVARCHAR(MAX),
    MaNguoiBienSoan INT,
    NgayLap DATE
);

-- Tạo bảng chứa thông tin tài khoản
CREATE TABLE TaiKhoan (
    MaTaiKhoan INT PRIMARY KEY,
    TenTaiKhoan NVARCHAR(50),
    MatKhau NVARCHAR(255),
    NgayLap DATE,
    LoaiTaiKhoan NVARCHAR(50)
);

-- Tạo bảng chứa thông tin khách hàng
CREATE TABLE KhachHang (
    MaKhachHang INT PRIMARY KEY,
    MaTaiKhoan INT,
    HinhDaiDien NVARCHAR(255),
    MaGioHang INT,
    TenKhachHang NVARCHAR(100),
    NgaySinh DATE,
    DiaChi NVARCHAR(255),
    SoDienThoai NVARCHAR(15),
    DiemTichLuy INT,
    TongGiaTriHoaDon DECIMAL(18, 2)
);

-- Tạo bảng chứa thông tin chi tiết giỏ hàng
CREATE TABLE ChiTietGioHang (
    MaGioHang INT,
    MaSanPham INT,
    SoLuong INT,
    PRIMARY KEY (MaGioHang, MaSanPham)
);

-- Tạo bảng chứa thông tin nhân viên
CREATE TABLE NhanVien (
    MaNhanVien INT PRIMARY KEY,
    TenNhanVien NVARCHAR(100),
    HinhDaiDien NVARCHAR(255),
    VaiTro NVARCHAR(50),
    HeSoLuong DECIMAL(5, 2),
    NgaySinh DATE,
    NgayVaoLam DATE
);

-- Thiết lập các khóa ngoại
GO
-- Khóa ngoại cho SanPhamDangBan
ALTER TABLE SanPhamDangBan 
ADD CONSTRAINT FK_SanPhamDangBan_SanPhamTonKho 
FOREIGN KEY (MaSanPham) REFERENCES SanPhamTonKho(MaSanPham);

ALTER TABLE SanPhamDangBan 
ADD CONSTRAINT FK_SanPhamDangBan_KhuyenMai 
FOREIGN KEY (MaKhuyenMai) REFERENCES KhuyenMai(MaKhuyenMai);
GO
-- Khóa ngoại cho DanhGiaSanPham
ALTER TABLE DanhGiaSanPham 
ADD CONSTRAINT FK_DanhGiaSanPham_SanPhamDangBan 
FOREIGN KEY (MaSanPham) REFERENCES SanPhamDangBan(MaSanPham);
GO
-- Khóa ngoại cho ChiTietHoaDon
ALTER TABLE ChiTietHoaDon 
ADD CONSTRAINT FK_ChiTietHoaDon_HoaDon 
FOREIGN KEY (MaHoaDon) REFERENCES HoaDon(MaHoaDon);

ALTER TABLE ChiTietHoaDon 
ADD CONSTRAINT FK_ChiTietHoaDon_SanPhamDangBan 
FOREIGN KEY (MaSanPham) REFERENCES SanPhamDangBan(MaSanPham);
GO
-- Khóa ngoại cho DonHang
ALTER TABLE DonHang 
ADD CONSTRAINT FK_DonHang_HoaDon 
FOREIGN KEY (MaHoaDon) REFERENCES HoaDon(MaHoaDon);

-- Khóa ngoại cho HoaDon
ALTER TABLE HoaDon 
ADD CONSTRAINT FK_HoaDon_KhuyenMai 
FOREIGN KEY (MaKhuyenMai) REFERENCES KhuyenMai(MaKhuyenMai);

ALTER TABLE HoaDon 
ADD CONSTRAINT FK_HoaDon_KhachHang 
FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang);
GO

-- Khóa ngoại cho KhachHang
ALTER TABLE KhachHang 
ADD CONSTRAINT FK_KhachHang_TaiKhoan 
FOREIGN KEY (MaTaiKhoan) REFERENCES TaiKhoan(MaTaiKhoan);
GO


--- Chạy ở tiếp tục ở phần này nhé

-- Thêm ràng buộc UNIQUE vào cột MaGioHang trong bảng KhachHang
ALTER TABLE KhachHang
ADD CONSTRAINT UQ_KhachHang_MaGioHang UNIQUE (MaGioHang);
-- Khóa ngoại cho ChiTietGioHang
ALTER TABLE ChiTietGioHang 
ADD CONSTRAINT FK_ChiTietGioHang_KhachHang 
FOREIGN KEY (MaGioHang) REFERENCES KhachHang(MaGioHang);

ALTER TABLE ChiTietGioHang 
ADD CONSTRAINT FK_ChiTietGioHang_SanPhamDangBan 
FOREIGN KEY (MaSanPham) REFERENCES SanPhamDangBan(MaSanPham);

GO

-- Chèn dữ liệu cho bảng KhuyenMai
INSERT INTO KhuyenMai (MaKhuyenMai, TenKhuyenMai, GiaTriKhuyenMai, TinhTrang, LoaiKhuyenMai)
VALUES
    (1, N'Giảm giá 10%', 0.1, N'Đang áp dụng', N'Giảm giá'),
    (2, N'Mua 1 tặng 1', 0.5, N'Đang áp dụng', N'Khuyến mãi'),
    (3, N'Tích lũy điểm đổi quà', NULL, N'Đang áp dụng', N'Tích điểm');

-- Chèn dữ liệu cho bảng TaiKhoan
INSERT INTO TaiKhoan (MaTaiKhoan, TenTaiKhoan, MatKhau, NgayLap, LoaiTaiKhoan)
VALUES
    (1, N'admin', N'matkhaunguoilon', '2023-01-01', N'Admin'),
    (2, N'user1', N'matkhauuser1', '2023-02-15', N'Khách hàng'),
    (3, N'user2', N'matkhauuser2', '2023-03-20', N'Khách hàng');

-- Chèn dữ liệu cho bảng KhachHang
INSERT INTO KhachHang (MaKhachHang, MaTaiKhoan, HinhDaiDien, MaGioHang, TenKhachHang, NgaySinh, DiaChi, SoDienThoai, DiemTichLuy, TongGiaTriHoaDon)
VALUES
    (1, 1, N'hinhdaidien_admin.jpg', 1, N'Nguyễn Văn A', '1990-05-15', N'123 Đường ABC, Quận 1, TP.HCM', N'0912345678', 100, 1000000),
    (2, 2, N'hinhdaidien_user1.jpg', 2, N'Trần Thị B', '1985-09-22', N'456 Đường XYZ, Quận 2, TP.HCM', N'0987654321', 50, 500000),
    (3, 3, N'hinhdaidien_user2.jpg', 3, N'Lê Văn C', '1992-11-05', N'789 Đường PQR, Quận 3, TP.HCM', N'0912345679', 75, 750000);

-- Chèn dữ liệu cho bảng SanPhamTonKho
INSERT INTO SanPhamTonKho (MaSanPham, TenSanPham, LoaiSanPham, HinhSanPham, NgayNhap, SoLuong, TinhTrang)
VALUES
    (1, N'Dây Chuyền Vàng 18K Đính Đá CZ', N'Trang Sức', N'day-chuyen-vang-18k-dinh-da-cz.jpg', '2023-04-01', 30, N'Mới'),
    (2, N'Vòng Tay Vàng 14K', N'Trang Sức', N'vong-tay-vang-14k.jpg', '2023-04-10', 25, N'Mới'),
    (3, N'Nhẫn Cưới Vàng 18K Đính Đá CZ', N'Trang Sức', N'nhan-cuoi-vang-18k-dinh-da-cz.jpg', '2023-04-15', 20, N'Mới'),
    (4, N'Nhẫn Cưới Vàng 18K', N'Trang Sức', N'nhan-cuoi-vang-18k.jpg', '2023-04-20', 15, N'Mới'),
    (5, N'Nhẫn Cưới Vàng 14K Đính Đá CZ', N'Trang Sức', N'nhan-cuoi-vang-14k-dinh-da-cz.jpg', '2023-04-25', 25, N'Mới'),
    (6, N'Nhẫn Cưới Vàng 24K Đính Đá CZ', N'Trang Sức', N'nhan-cuoi-vang-24k-dinh-da-cz.jpg', '2023-05-01', 15, N'Mới'),
    (7, N'Nhẫn Cưới Bạch Kim Đính Đá CZ', N'Trang Sức', N'nhan-cuoi-bach-kim-dinh-da-cz.jpg', '2023-05-05', 20, N'Mới'),
    (8, N'Nhẫn Đính Đá Sapphire', N'Trang Sức', N'nhan-dinh-da-sapphire.jpg', '2023-05-10', 12, N'Mới'),
    (11, N'Dây Chuyền Vàng 24K', N'Trang Sức', N'day-chuyen-vang-24k.jpg', '2023-05-25', 18, N'Mới'),
    (12, N'Dây Chuyền Vàng 18K Đính Đá Ruby', N'Trang Sức', N'day-chuyen-vang-18k-dinh-da-ruby.jpg', '2023-05-28', 15, N'Mới'),
    (13, N'Dây Chuyền Bạch Kim', N'Trang Sức', N'day-chuyen-bach-kim.jpg', '2023-06-01', 20, N'Mới'),
    (14, N'Dây Chuyền Vàng Trắng 14K', N'Trang Sức', N'day-chuyen-vang-trang-14k.jpg', '2023-06-05', 12, N'Mới'),
    (15, N'Dây Chuyền Vàng 18K Đính Đá Emerald', N'Trang Sức', N'day-chuyen-vang-18k-dinh-da-emerald.jpg', '2023-06-10', 10, N'Mới'),
    (16, N'Lắc Tay Bạc Đính Đá PNJSilver Fantasia', N'Trang Sức', N'lac-tay-bac-dinh-da-pnjsilver-fantasia.jpg', '2024-05-18', 30, N'Mới'),
    (17, N'Lắc Tay Bạc Ý PNJSilver', N'Trang Sức', N'lac-tay-bac-y-pnjsilver.jpg', '2024-05-18', 25, N'Mới'),
    (18, N'Vòng Tay Bạc PNJSilver Friendzone Breaker Hình Chữ Love', N'Trang Sức', N'vong-tay-bac-pnjsilver-friendzone-breaker-hinh-chu-love.jpg', '2024-05-18', 20, N'Mới'),
    (19, N'Lắc Tay Trẻ Em Bạc PNJSilver Juice Me Up', N'Trang Sức', N'lac-tay-tre-em-bac-pnjsilver-juice-me-up.jpg', '2024-05-18', 15, N'Mới'),
    (20, N'Vòng Tay Bạc Đính Đá PNJSilver XMXMK', N'Trang Sức', N'vong-tay-bac-dinh-da-pnjsilver-xmxmk.jpg', '2024-05-18', 10, N'Mới'),
    (21, N'Bông tai Vàng Trắng 14K đính Ngọc trai Freshwater PNJ PFXMW000415', N'Trang Sức', N'bong-tai-vang-trang-14k-dinh-ngoc-trai-freshwater-pnj-pfxmw000415.jpg', '2023-06-20', 30, N'Mới'),
    (22, N'Bông tai Bạc đính Ngọc trai STYLE By PNJ Edgy PMMXW000003', N'Trang Sức', N'bong-tai-bac-dinh-ngoc-trai-style-by-pnj-edgy-pmmxw000003.jpg', '2023-06-21', 25, N'Mới'),
    (23, N'Bông tai Vàng Trắng 14K đính Ngọc trai Freshwater PNJ PFXMW000311', N'Trang Sức', N'bong-tai-vang-trang-14k-dinh-ngoc-trai-freshwater-pnj-pfxmw000311.jpg', '2023-06-22', 20, N'Mới'),
    (24, N'Bông tai Bạc đính đá CZ PNJSilver Fantasy XMZMW000052', N'Trang Sức', N'bong-tai-bac-dinh-da-cz-pnjsilver-fantasy-xmzmw000052.jpg', '2023-06-23', 30, N'Mới'),
    (25, N'Bông tai Vàng Trắng 14K đính đá ECZ Swarovski PNJ XMXMY000120', N'Trang Sức', N'bong-tai-vang-trang-14k-dinh-da-ecz-swarovski-pnj-xmxmy000120.jpg', '2023-06-24', 25, N'Mới');

-- Chèn dữ liệu cho bảng SanPhamDangBan
INSERT INTO SanPhamDangBan (MaSanPham, TenSanPham, HinhSanPham, LoaiSanPham, MoTaSanPham, SoLuongTrongCuaHang, SoLuongDaBan, GiaNiemYet, MaKhuyenMai, DoanhThu)
VALUES
    (1, N'Dây Chuyền Vàng 18K Đính Đá CZ', N'day-chuyen-vang-18k-dinh-da-cz.jpg', N'Trang Sức', N'Dây chuyền vàng 18K đính đá CZ lấp lánh, thiết kế sang trọng và quý phái.', 25, 5, 5000000, 1, 25000000),
    (2, N'Vòng Tay Vàng 14K', N'vong-tay-vang-14k.jpg', N'Trang Sức', N'Vòng tay vàng 14K trơn đẹp, kiểu dáng đơn giản nhưng tinh tế.', 20, 5, 3000000, 2, 15000000),
    (3, N'Nhẫn Cưới Vàng 18K Đính Đá CZ', N'nhan-cuoi-vang-18k-dinh-da-cz.jpg', N'Trang Sức', N'Nhẫn cưới vàng 18K đính đá CZ, thiết kế tinh tế và sang trọng.', 18, 2, 8900000, NULL, 17800000),
    (4, N'Nhẫn Cưới Vàng 18K', N'nhan-cuoi-vang-18k.jpg', N'Trang Sức', N'Nhẫn cưới vàng 18K trơn đẹp, kiểu dáng hiện đại và thanh lịch.', 12, 3, 7200000, 1, 19440000),
    (5, N'Nhẫn Cưới Vàng 14K Đính Đá CZ', N'nhan-cuoi-vang-14k-dinh-da-cz.jpg', N'Trang Sức', N'Nhẫn cưới vàng 14K đính đá CZ, sự kết hợp hoàn hảo giữa sang trọng và đẳng cấp.', 22, 3, 6500000, NULL, 19500000),
    (11, N'Dây Chuyền Vàng 24K', N'day-chuyen-vang-24k.jpg', N'Trang Sức', N'Dây chuyền vàng 24K trơn đẹp, thiết kế sang trọng và quý phái.', 16, 2, 15000000, 1, 30000000),
    (12, N'Dây Chuyền Vàng 18K Đính Đá Ruby', N'day-chuyen-vang-18k-dinh-da-ruby.jpg', N'Trang Sức', N'Dây chuyền vàng 18K đính đá Ruby quý hiếm, sự lựa chọn hoàn hảo cho những dịp đặc biệt.', 13, 2, 20000000, NULL, 40000000),
    (13, N'Dây Chuyền Bạch Kim', N'day-chuyen-bach-kim.jpg', N'Trang Sức', N'Dây chuyền bạch kim trơn đẹp, thiết kế trang nhã và sang trọng.', 18, 2, 12000000, 2, 24000000),
    (14, N'Dây Chuyền Vàng Trắng 14K', N'day-chuyen-vang-trang-14k.jpg', N'Trang Sức', N'Dây chuyền vàng trắng 14K đơn giản nhưng tinh tế, phù hợp với mọi phong cách.', 10, 2, 10000000, NULL, 20000000),
    (15, N'Dây Chuyền Vàng 18K Đính Đá Emerald', N'day-chuyen-vang-18k-dinh-da-emerald.jpg', N'Trang Sức', N'Dây chuyền vàng 18K đính đá Emerald xanh ngọc, sự kết hợp hoàn hảo giữa vàng và đá quý.', 8, 2, 25000000, 3, 50000000),
    (16, N'Lắc Tay Bạc Đính Đá PNJSilver Fantasia', N'lac-tay-bac-dinh-da-pnjsilver-fantasia.jpg', N'Trang Sức', N'Lắc tay bạc đính đá PNJSilver Fantasia thiết kế tinh tế và sang trọng.', 25, 5, 535000, 1, 2675000),
    (17, N'Lắc Tay Bạc Ý PNJSilver', N'lac-tay-bac-y-pnjsilver.jpg', N'Trang Sức', N'Lắc tay bạc Ý PNJSilver với thiết kế đơn giản nhưng rất tinh tế.', 20, 5, 1455000, 2, 7275000),
    (18, N'Vòng Tay Bạc PNJSilver Friendzone Breaker Hình Chữ Love', N'vong-tay-bac-pnjsilver-friendzone-breaker-hinh-chu-love.jpg', N'Trang Sức', N'Vòng tay bạc PNJSilver Friendzone Breaker với thiết kế hình chữ Love đặc biệt.', 18, 2, 733000, NULL, 1466000),
    (19, N'Lắc Tay Trẻ Em Bạc PNJSilver Juice Me Up', N'lac-tay-tre-em-bac-pnjsilver-juice-me-up.jpg', N'Trang Sức', N'Lắc tay trẻ em bạc PNJSilver Juice Me Up dễ thương và an toàn cho bé.', 13, 2, 499000, 1, 998000),
    (20, N'Vòng Tay Bạc Đính Đá PNJSilver XMXMK', N'vong-tay-bac-dinh-da-pnjsilver-xmxmk.jpg', N'Trang Sức', N'Vòng tay bạc đính đá PNJSilver XMXMK lấp lánh, thiết kế sang trọng.', 8, 2, 1475000, 3, 2950000),
    (21, N'Bông tai Vàng Trắng 14K đính Ngọc trai Freshwater PNJ PFXMW000415', N'bong-tai-vang-trang-14k-dinh-ngoc-trai-freshwater-pnj-pfxmw000415.jpg', N'Trang Sức', N'Bông tai vàng trắng 14K đính ngọc trai Freshwater, thiết kế sang trọng và tinh tế.', 30, 0, 4500000, 1, 0),
    (22, N'Bông tai Bạc đính Ngọc trai STYLE By PNJ Edgy PMMXW000003', N'bong-tai-bac-dinh-ngoc-trai-style-by-pnj-edgy-pmmxw000003.jpg', N'Trang Sức', N'Bông tai bạc đính ngọc trai STYLE By PNJ Edgy, phong cách trẻ trung và hiện đại.', 25, 0, 1200000, 2, 0),
    (23, N'Bông tai Vàng Trắng 14K đính Ngọc trai Freshwater PNJ PFXMW000311', N'bong-tai-vang-trang-14k-dinh-ngoc-trai-freshwater-pnj-pfxmw000311.jpg', N'Trang Sức', N'Bông tai vàng trắng 14K đính ngọc trai Freshwater, sự lựa chọn hoàn hảo cho quý cô thanh lịch.', 20, 0, 5000000, 3, 0),
    (24, N'Bông tai Bạc đính đá CZ PNJSilver Fantasy XMZMW000052', N'bong-tai-bac-dinh-da-cz-pnjsilver-fantasy-xmzmw000052.jpg', N'Trang Sức', N'Bông tai bạc đính đá CZ PNJSilver Fantasy, thiết kế độc đáo và cuốn hút.', 30, 0, 800000, NULL, 0),
    (25, N'Bông tai Vàng Trắng 14K đính đá ECZ Swarovski PNJ XMXMY000120', N'bong-tai-vang-trang-14k-dinh-da-ecz-swarovski-pnj-xmxmy000120.jpg', N'Trang Sức', N'Bông tai vàng trắng 14K đính đá ECZ Swarovski, mang đến vẻ đẹp lấp lánh và sang trọng.', 25, 0, 3000000, 1, 0);

-- Chèn dữ liệu cho bảng DanhGiaSanPham
INSERT INTO DanhGiaSanPham (MaSanPham, MaNguoiDanhGia, NoiDungDanhGia, NgayDanhGia)
VALUES
    (1, 2, N'Dây chuyền đẹp, vàng 18K sáng bóng và đá CZ lấp lánh.', '2023-05-01'),
    (2, 3, N'Vòng tay vàng 14K đơn giản nhưng rất tinh tế và sang trọng.', '2023-05-05'),
    (3, 1, N'Nhẫn cưới đẹp, thiết kế tinh xảo và sang trọng.', '2023-05-10'),
    (11, 2, N'Dây chuyền vàng 24K trơn đẹp, sáng bóng và sang trọng.', '2023-05-28'),
    (12, 3, N'Dây chuyền đính đá Ruby quý hiếm, thiết kế tinh xảo và đẳng cấp.', '2023-06-01'),
    (13, 1, N'Dây chuyền bạch kim trơn đẹp, trang nhã và thanh lịch.', '2023-06-05'),
    (14, 2, N'Dây chuyền vàng trắng 14K đơn giản nhưng rất tinh tế.', '2023-06-08'),
    (15, 3, N'Dây chuyền đính đá Emerald xanh ngọc, sự kết hợp hoàn hảo giữa vàng và đá quý.', '2023-06-12');

-- Chèn dữ liệu cho bảng HoaDon
INSERT INTO HoaDon (MaHoaDon, TongGiaTriHoaDon, NgayXuat, MaKhachHang, MaKhuyenMai)
VALUES
    (1, 4500000, '2023-05-01', 1, 1),
    (2, 4200000, '2023-05-03', 2, 2),
    (3, 25620000, '2023-05-07', 3, NULL);

-- Chèn dữ liệu cho bảng ChiTietHoaDon
INSERT INTO ChiTietHoaDon (MaHoaDon, MaSanPham, SoLuong, TongGia)
VALUES
    (1, 1, 1, 4500000),
    (2, 2, 2, 4200000),
    (3, 3, 2, 17800000),
    (3, 5, 1, 6500000);

-- Chèn dữ liệu cho bảng NhanVien
INSERT INTO NhanVien (MaNhanVien, TenNhanVien, HinhDaiDien, VaiTro, HeSoLuong, NgaySinh, NgayVaoLam)
VALUES
    (1, N'Nguyễn Văn D', N'hinhdaidien_nhanvien1.jpg', N'Quản lý', 1.5, '1988-03-12', '2015-06-01'),
    (2, N'Trần Thị E', N'hinhdaidien_nhanvien2.jpg', N'Nhân viên bán hàng', 1.2, '1992-09-25', '2018-02-15'),
    (3, N'Lê Văn F', N'hinhdaidien_nhanvien3.jpg', N'Nhân viên kho', 1.1, '1995-11-08', '2020-07-01');

-- Chèn dữ liệu cho bảng ChienLuocTiepThi
INSERT INTO ChienLuocTiepThi (MaChienLuoc, LoaiSanPham, TenChienLuoc, NoiDungChienLuoc, MaNguoiBienSoan, NgayLap)
VALUES
    (2, N'Trang Sức', N'Ưu đãi đặc biệt', N'Tặng voucher trị giá 500.000 đồng khi mua nhẫn cưới trong tháng 7', 1, '2023-05-20');
