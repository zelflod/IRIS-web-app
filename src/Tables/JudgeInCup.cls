Class Tables.JudgeInCup Extends %Persistent
{

Property cup As Tables.Cup;

Property judge As Tables.Judge;

Storage Default
{
<Data name="JudgeInCupDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>cup</Value>
</Value>
<Value name="3">
<Value>judge</Value>
</Value>
</Data>
<DataLocation>^Tables.JudgeInCupD</DataLocation>
<DefaultData>JudgeInCupDefaultData</DefaultData>
<IdLocation>^Tables.JudgeInCupD</IdLocation>
<IndexLocation>^Tables.JudgeInCupI</IndexLocation>
<StreamLocation>^Tables.JudgeInCupS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
