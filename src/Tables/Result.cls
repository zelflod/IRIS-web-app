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

ClassMethod Save(cupId As %Integer, judgeId As %Integer, dancerId As %Integer, score As %Integer) As %Status
{
    set obj = ##class(Tables.Result).%New()
    
    do obj.dancerSetObjectId(dancerId)
    do obj.cupSetObjectId(cupId)
    do obj.judgeSetObjectId(judgeId)
    set obj.score = score

    set result = obj.%Save()
    Return result
}

Method getAll(data) As %String
{
	set data = []
	&sql(
	 	DECLARE MyCursor CURSOR FOR
	    SELECT ID, cup, dancer, judge, score
	    INTO :ID, :cup, :dancer, :judge, :score
	    FROM Tables.Result
 	)
 	&sql(OPEN MyCursor)
 	
  FOR { 
    &sql(FETCH MyCursor)
    if (SQLCODE) quit

    set r = ##class(Tables.Result).%OpenId(ID)


    set obj = {"id": (ID), "cup": (r.cup.name), "dancer": (r.dancer.name), "judge": (r.judge.name), "score": (score)}
    do data.%Push(obj)
 	}
 	&sql(CLOSE MyCursor)
 	
 	quit
}

}
