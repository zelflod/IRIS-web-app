Class FCE.Somenewclass Extends %Persistent
{

Property somefield As %Integer;

Property Employee As FCE.Employee;

Storage Default
{
<Data name="SomenewclassDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>somefield</Value>
</Value>
<Value name="3">
<Value>Employee</Value>
</Value>
</Data>
<DataLocation>^FCE.SomenewclassD</DataLocation>
<DefaultData>SomenewclassDefaultData</DefaultData>
<IdLocation>^FCE.SomenewclassD</IdLocation>
<IndexLocation>^FCE.SomenewclassI</IndexLocation>
<StreamLocation>^FCE.SomenewclassS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
