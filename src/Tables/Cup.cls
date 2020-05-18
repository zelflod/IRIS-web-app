Class Tables.Cup Extends %Persistent
{

Property name As %String;

Property level As %String;

Storage Default
{
<Data name="CupDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>name</Value>
</Value>
<Value name="3">
<Value>level</Value>
</Value>
</Data>
<DataLocation>^Tables.CupD</DataLocation>
<DefaultData>CupDefaultData</DefaultData>
<IdLocation>^Tables.CupD</IdLocation>
<IndexLocation>^Tables.CupI</IndexLocation>
<StreamLocation>^Tables.CupS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
