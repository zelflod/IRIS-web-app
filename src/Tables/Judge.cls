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

ClassMethod SaveJudge(newObj As Tables.Judge) As %Status
{
    set obj = ##class(Tables.Judge).%New()

    set obj.name = newObj.name
    set x = obj.nameIsValid(obj.name)

    set obj.status = newObj.status
    set x = obj.statusIsValid(obj.status)

    set result = obj.%Save()
    Return result
}

Method getAll(data) As %String
{
	set data = []
	&sql(
	 	DECLARE MyCursor CURSOR FOR
	    SELECT ID, name, status
	    INTO :ID, :name, :status
	    FROM Tables.Judge
 	)
 	&sql(OPEN MyCursor)
 	
  FOR { 
    &sql(FETCH MyCursor)
    if (SQLCODE) quit

    set obj = {"id": (ID), "name": (name), "status": (status), "value": (name)}
    do data.%Push(obj)
 	}
 	&sql(CLOSE MyCursor)
 	
 	quit
}

}
