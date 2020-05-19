Class Tables.DancerInCup Extends %Persistent
{

Property dancer As Tables.Dancer;

Property cup As Tables.Cup;

Storage Default
{
<Data name="DancerInCupDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>dancer</Value>
</Value>
<Value name="3">
<Value>cup</Value>
</Value>
</Data>
<DataLocation>^Tables.DancerInCupD</DataLocation>
<DefaultData>DancerInCupDefaultData</DefaultData>
<IdLocation>^Tables.DancerInCupD</IdLocation>
<IndexLocation>^Tables.DancerInCupI</IndexLocation>
<StreamLocation>^Tables.DancerInCupS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

ClassMethod Save(dancerId As %Integer, cupId As %Integer) As %Status
{
    set obj = ##class(Tables.DancerInCup).%New()
    
    do obj.dancerSetObjectId(dancerId)
    do obj.cupSetObjectId(cupId)

    set result = obj.%Save()
    Return result
}

}
