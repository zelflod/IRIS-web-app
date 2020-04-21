Class FCE.Person Extends %Persistent
{

Property Address As User.Address;

Property Document As User.Document;

Property Name As %String [ InitialExpression = "a" ];

Storage Default
{
<Data name="PersonDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
<Value name="3">
<Value>Address</Value>
</Value>
<Value name="4">
<Value>Document</Value>
</Value>
</Data>
<DataLocation>^FCE.PersonD</DataLocation>
<DefaultData>PersonDefaultData</DefaultData>
<IdLocation>^FCE.PersonD</IdLocation>
<IndexLocation>^FCE.PersonI</IndexLocation>
<StreamLocation>^FCE.PersonS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
