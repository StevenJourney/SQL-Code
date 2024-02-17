--Cleaning Data in SQL Queries

Select*
From NashvilleHousing

Select SaleDate, Convert(Date,SaleDate)
From NashvilleHousing

--Update NashvilleHousing
--Set SaleDate = Convert(Date,SaleDate)

ALTER TABLE NashvilleHousing
Add SaleDateConverted Date;

Update NashvilleHousing
Set SaleDateConverted = Convert(Date,SaleDate)

--Populate Property Address Data

Select *
From NashvilleHousing
--Where PropertyAddress is null
order by ParcelID

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
From NashvilleHousing a
join NashvilleHousing b
	on a.ParcelID = b.ParcelID
	AND a.UniqueID <> b.UniqueID
Where a. PropertyAddress is null

Update a
SET PropertyAddress = ISNULL (a.PropertyAddress, b.PropertyAddress)
From NashvilleHousing a
join NashvilleHousing b
	on a.ParcelID = b.ParcelID
	AND a.UniqueID <> b.UniqueID
Where a. PropertyAddress is null

--Breaking out Address into Individual Columns (Address,City,State)
Select PropertyAddress
From NashvilleHousing

Select
Substring(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1) As Address,
Substring(PropertyAddress,CHARINDEX(',',PropertyAddress)+ 1,LEN(PropertyAddress)) As Address
From NashvilleHousing

ALTER TABLE NashvilleHousing
Add PropertySplitAddress Nvarchar(255);

Update NashvilleHousing
Set PropertySplitAddress = Substring(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1)

ALTER TABLE NashvilleHousing
Add PropertySplitCity Nvarchar(255);

Update NashvilleHousing
Set PropertySplitCity = Substring(PropertyAddress,CHARINDEX(',',PropertyAddress)+ 1,LEN(PropertyAddress))




Select*
From NashvilleHousing



Select OwnerAddress
From NashvilleHousing

Select PARSENAME(Replace(OwnerAddress,',','.'),3) ,
PARSENAME(Replace(OwnerAddress,',','.'),2),
PARSENAME(Replace(OwnerAddress,',','.'),1)
From NashvilleHousing

ALTER TABLE NashvilleHousing
Add OwnerSplitAddress Nvarchar(255);

Update NashvilleHousing
Set OwnerSplitAddress = PARSENAME(Replace(OwnerAddress,',','.'),3)

ALTER TABLE NashvilleHousing
Add OwnerSplitCity Nvarchar(255);

Update NashvilleHousing
Set OwnerSplitCity  = PARSENAME(Replace(OwnerAddress,',','.'),2)

ALTER TABLE NashvilleHousing
Add OwnerSplitState Nvarchar(255);

Update NashvilleHousing
Set OwnerSplitState = PARSENAME(Replace(OwnerAddress,',','.'),1)


Select Distinct(SoldAsVacant), count (soldasvacant)
From NashvilleHousing
Group by SoldAsVacant
order by 2 desc

Select SoldAsVacant
, Case when soldasvacant = 'Y' then 'Yes'
when soldasvacant = 'N' then 'No'
else soldasvacant
end
from NashvilleHousing
order by SoldAsVacant

Update NashvilleHousing
Set Soldasvacant =
Case when soldasvacant = 'Y' then 'Yes'
	when soldasvacant = 'N' then 'No'
	else soldasvacant
	end
from NashvilleHousing

--Remove Duplicates

With RowNumCTE As (
Select*,
	ROW_NUMBER()OVER (
	PARTITION BY ParcelID,
				PropertyAddress,
				SalePrice,
				SaleDate,
				LegalReference
				order by UniqueID) row_num
	From NashvilleHousing)

	Select*
	From RowNumCTE
	Where row_num > 1

Select*
From NashvilleHousing

Alter table nashvillehousing
Drop column owneraddress, Taxdistrict, Propertyaddress
	

