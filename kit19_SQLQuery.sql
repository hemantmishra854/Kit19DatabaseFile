--create database
create database kit19;
use kit19;
--create table 
create table tbl_Product(
ProductId int primary key identity,
ProductName nvarchar(max) not null,
Size char(1) not null,
Price int not null,
MfgDate date not null,
Category varchar(20) not null
)

-- insert sample data into table
insert into tbl_Product(ProductName, Size,Price,MfgDate,Category)
values('Mobile', 'L', 100, GETDATE(), 'Standard');

insert into tbl_Product(ProductName, Size,Price,MfgDate,Category)
values('Mobile', 'M', 500, GETDATE(), 'Premium');

insert into tbl_Product(ProductName, Size,Price,MfgDate,Category)
values('Mobile', 'S', 250, GETDATE(), 'Economy');

insert into tbl_Product(ProductName, Size,Price,MfgDate,Category)
values('Laptop', 'L', 100, GETDATE(), 'Standard');

insert into tbl_Product(ProductName, Size,Price,MfgDate,Category)
values('Laptop', 'M', 500, GETDATE(), 'Premium');

insert into tbl_Product(ProductName, Size,Price,MfgDate,Category)
values('Laptop', 'S', 250, GETDATE(), 'Economy');

--select table data
select * from tbl_Product;
-- create procedure to list all tbl_product data
create procedure spGetProducts
As
begin
select * from tbl_Product;
end;

-- create stored procedure to search tbl_product data based on specific search criteria
create procedure spSearchProduct
@Operator varchar(10) = 'and',
@ProductName nvarchar(max)= null,
@Size char(1) = null,
@Price int = null,
@MfgDate date = null,
@Category varchar(20) = null
as
begin
if Lower(@Operator) = 'and'
select * from tbl_Product where (ProductName = @ProductName or @ProductName is null) and
(Size = @Size or @Size is null) and
(Price = @Price or @Price is null) and
(MfgDate = @MfgDate or @MfgDate is null) and
(Category = @Category or @Category is null);
else if Lower(@Operator) = 'or'
select * from tbl_Product where ProductName = @ProductName or
Size = @Size or
Price = @Price or
MfgDate = @MfgDate or
Category = @Category;
end;

-- exec stored procedure
exec spSearchProduct @Operator= 'and', @ProductName= 'Mobile', @Size='L',@Price=null, 
@MfgDate='2024-01-01', @category='Standard'