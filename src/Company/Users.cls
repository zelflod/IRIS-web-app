/// all users
Class Company.Users Extends %Persistent
{

Property name As %String;

Property age As %Decimal;

Property sex As %Decimal;

Storage Default
{
<Data name="UsersDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>name</Value>
</Value>
<Value name="3">
<Value>age</Value>
</Value>
<Value name="4">
<Value>sex</Value>
</Value>
<Value name="5">
<Value>Height</Value>
</Value>
</Data>
<DataLocation>^Company.UsersD</DataLocation>
<DefaultData>UsersDefaultData</DefaultData>
<IdLocation>^Company.UsersD</IdLocation>
<IndexLocation>^Company.UsersI</IndexLocation>
<StreamLocation>^Company.UsersS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

Method createUser(name As %String, age As %Numeric, sex As %Numeric) As %Boolean
{
	set ##this.name = name
	set ##this.age = age
	set ##this.sex = sex
	set result = ##this.%Save()
	quit result
}

Method getUsers(data) As %String
{
	set data = []
	&sql(
	 	DECLARE MyCursor CURSOR FOR
	    SELECT id, name, age, sex
	    INTO :id, :name, :age, :sex
	    FROM Company.Users
 	)
 	//вариант в массив INTO :singleUserData()
 	&sql(OPEN MyCursor)
 	
  FOR { 
    &sql(FETCH MyCursor)
    if (SQLCODE) quit

    set obj = {"id": (id), "name": (name), "age": (age), "sex": (sex)}
    do data.%Push(obj)
 	}
 	&sql(CLOSE MyCursor)
 	
 	quit
}

ClassMethod SaveUser(requestUserObj) As %Status
{
  set result = {}
  set obj = ##class(Company.Users).%New()
  set obj.name = requestUserObj.fname
  set obj.age = requestUserObj.fage
  set saveResult = obj.%Save()

  if $$$ISOK(saveResult) set result = {"result": true}
  else  set result = {"result": false}
  set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(saveResult)
  set result.message = ErrorMessage

  return result
}

ClassMethod sampleDynamicRequest(paramAge)
{
	set sqlRaw = "select * from {%1%} where age>?"
	set table = "Company.Users"
	set sql = $Replace(sqlRaw, "{%1%}", table)

	set sqlObj = ##class(%SQL.Statement).%New()
	set qStatus = sqlObj.%Prepare(sql)
	set rset = sqlObj.%Execute(paramAge)
	do rset.%Display()
}

ClassMethod sampleStaticRequest()
{
	set searchAge = 18
	&sql(DECLARE C1 CURSOR FOR 
       SELECT id,name,age,sex 
	   INTO :idVar, :nameVar,:ageVar,:sexVar 
       FROM Company.Users
       WHERE age > :searchAge)
  &sql(OPEN C1)
      QUIT:(SQLCODE'=0)
  &sql(FETCH C1)
  WHILE (SQLCODE = 0) {
     WRITE nameVar," is ",ageVar," years",!
    &sql(FETCH C1) }
  &sql(CLOSE C1)
}

}
