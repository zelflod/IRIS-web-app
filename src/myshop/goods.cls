Class MyShop.Goods Extends %Persistent
{

Property Name As %String;

Property Price As %Decimal;

Property Group;

Property Description As %String;

Storage Default
{
<Data name="GoodsDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
<Value name="3">
<Value>Price</Value>
</Value>
<Value name="4">
<Value>Group</Value>
</Value>
<Value name="5">
<Value>Description</Value>
</Value>
</Data>
<DataLocation>^MyShop.GoodsD</DataLocation>
<DefaultData>GoodsDefaultData</DefaultData>
<IdLocation>^MyShop.GoodsD</IdLocation>
<IndexLocation>^MyShop.GoodsI</IndexLocation>
<StreamLocation>^MyShop.GoodsS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
