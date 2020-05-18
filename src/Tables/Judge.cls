Class Tables.Judge Extends %Persistent
{

Property name As %String;

Property status As %String;

Storage Default
{
<Data name="JudgeDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>name</Value>
</Value>
<Value name="3">
<Value>status</Value>
</Value>
</Data>
<DataLocation>^Tables.JudgeD</DataLocation>
<DefaultData>JudgeDefaultData</DefaultData>
<IdLocation>^Tables.JudgeD</IdLocation>
<IndexLocation>^Tables.JudgeI</IndexLocation>
<StreamLocation>^Tables.JudgeS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
