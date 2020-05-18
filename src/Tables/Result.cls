Class Tables.Result Extends %Persistent
{

Property score As %Integer;

Property cup As Tables.Cup;

Property judge As Tables.Judge;

Property dancer As Tables.Dancer;

Storage Default
{
<Data name="ResultDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>score</Value>
</Value>
<Value name="3">
<Value>cup</Value>
</Value>
<Value name="4">
<Value>judge</Value>
</Value>
<Value name="5">
<Value>dancer</Value>
</Value>
</Data>
<DataLocation>^Tables.ResultD</DataLocation>
<DefaultData>ResultDefaultData</DefaultData>
<IdLocation>^Tables.ResultD</IdLocation>
<IndexLocation>^Tables.ResultI</IndexLocation>
<StreamLocation>^Tables.ResultS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
