create index index_DimCustomer
on DimCustomer(CustomerKey,CityKey,Travel,Postal);

create index index_DimItem
on DimItem(ItemKey);

create index index_DimStore
on DimStore(StoreKey,CityKey);

create index index_DimRepresentativeOffice
on DimRepresentativeOffice(CityKey,CityName,State);

create index index_DimTime
on DimTime(TimeKey,day,month,quarter,year);

create index index_FactOrderItems
on FactOrderItems(TimeKey,ItemKey,CustomerKey,OrderedQuantity,OrderedCost,Profit)


create index index_FactStoreItems
on FactStoreItems(TimeKey,StoreKey,ItemKey,Quantity)
