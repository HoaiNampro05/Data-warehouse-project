
-- Chèn dữ liệu cho thành phố Hà Nội (CityId: CT01) --
INSERT INTO Stores (StoreId, CityId, PhoneNumber, Time) VALUES ('ST00000001', 'CT01', '0123456789', '2016-01-01');
INSERT INTO Stores (StoreId, CityId, PhoneNumber, Time) VALUES ('ST00000002', 'CT01', '0987654321', '2016-01-01');

-- Chèn dữ liệu cho thành phố Hồ Chí Minh (CityId: CT02) --
INSERT INTO Stores (StoreId, CityId, PhoneNumber, Time) VALUES ('ST00000003', 'CT02', '0987654321', '2017-02-15');
INSERT INTO Stores (StoreId, CityId, PhoneNumber, Time) VALUES ('ST00000004', 'CT02', '0123456789', '2017-02-15');


-- Chèn dữ liệu cho thành phố Đà Nẵng (CityId: CT03) --
INSERT INTO Stores (StoreId, CityId, PhoneNumber, Time) VALUES ('ST00000005', 'CT03', '0987654321', '2018-05-10');
INSERT INTO Stores (StoreId, CityId, PhoneNumber, Time) VALUES ('ST00000006', 'CT03', '0123456789', '2018-05-10');

-- Chèn dữ liệu cho thành phố khác tùy chọn (CityId: CT04) --
INSERT INTO Stores (StoreId, CityId, PhoneNumber, Time) VALUES ('ST00000007', 'CT04', '0123456789', '2019-07-20');
INSERT INTO Stores (StoreId, CityId, PhoneNumber, Time) VALUES ('ST00000008', 'CT04', '0987654321', '2019-07-20');


-- Chèn dữ liệu cho thành phố A (CityId: CT05) --
INSERT INTO Stores (StoreId, CityId, PhoneNumber, Time) VALUES ('ST00000009', 'CT05', '0123456789', '2020-09-05');
INSERT INTO Stores (StoreId, CityId, PhoneNumber, Time) VALUES ('ST00000010', 'CT05', '0987654321', '2020-09-05');
INSERT INTO Stores (StoreId, CityId, PhoneNumber, Time) VALUES ('ST00000011', 'CT05', '0123456789', '2020-09-05');

-- Chèn dữ liệu cho thành phố B (CityId: CT06) --
INSERT INTO Stores (StoreId, CityId, PhoneNumber, Time) VALUES ('ST00000012', 'CT06', '0987654321', '2021-11-12');
INSERT INTO Stores (StoreId, CityId, PhoneNumber, Time) VALUES ('ST00000013', 'CT06', '0123456789', '2021-11-12');

-- Chèn dữ liệu cho thành phố C (CityId: CT07) --
INSERT INTO Stores (StoreId, CityId, PhoneNumber, Time) VALUES ('ST00000014', 'CT07', '0123456789', '2022-03-18');

-- Chèn dữ liệu cho thành phố D (CityId: CT08) --
INSERT INTO Stores (StoreId, CityId, PhoneNumber, Time) VALUES ('ST00000015', 'CT08', '0987654321', '2023-06-25');
INSERT INTO Stores (StoreId, CityId, PhoneNumber, Time) VALUES ('ST00000016', 'CT08', '0123456789', '2023-06-25');
-- Chèn dữ liệu cho thành phố E (CityId: CT09) --
INSERT INTO Stores (StoreId, CityId, PhoneNumber, Time) VALUES ('ST00000017', 'CT09', '0123456789', '2023-09-10');
INSERT INTO Stores (StoreId, CityId, PhoneNumber, Time) VALUES ('ST00000018', 'CT09', '0987644321', '2023-09-10');
-- Chèn dữ liệu cho thành phố F (CityId: CT10) --
INSERT INTO Stores (StoreId, CityId, PhoneNumber, Time) VALUES ('ST00000019', 'CT10', '0987654321', '2024-02-29');
INSERT INTO Stores (StoreId, CityId, PhoneNumber, Time) VALUES ('ST00000020', 'CT10', '0987654321', '2024-02-29');


update Stores
set Time = '2016-02-02'
where Time > '2022-01-01';
update stores
set time = '2023-01-02'
where time < '2021-11-12';
select count(*) from stores;
