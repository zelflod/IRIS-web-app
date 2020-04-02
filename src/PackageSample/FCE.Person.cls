Class FCE.Person Extends %Persistent
{

Property Name As %String;

Storage Default
{
<Data name="PersonDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
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
